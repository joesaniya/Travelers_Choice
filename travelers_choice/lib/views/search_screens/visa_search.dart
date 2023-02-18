import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:searchfield/searchfield.dart';

import '../../controllers/search_controller.dart';
import '../../models/Country_modal.dart';
import '../../models/visa_country_modal.dart';
import '../../services/auth_service.dart';
import '../../services/visa_service.dart';
import '../../theme/app_theme.dart';

class SearchVisa extends StatefulWidget {
  const SearchVisa({Key? key}) : super(key: key);

  @override
  State<SearchVisa> createState() => _SearchVisaState();
}

class _SearchVisaState extends State<SearchVisa>
    with TickerProviderStateMixin {
  late CustomTheme customTheme;
  late ThemeData theme;
  late SearchController controller;
  // late LogInController controller;
  // late OutlineInputBorder outlineInputBorder;
  TextEditingController dateinput = TextEditingController();

  int? len;

  String? _selectedItem;

  final List<String> _countryCodes = [
    'Afghanistan',
    'Turkey',
    'Germany',
    'France',
    'Italy',
    'Spain',
    'United Kingdom',
    'United States',
    'Canada',
    'Australia',
    'New Zealand',
    'India',
    'Indonesia',
    'Bangladesh',
    'Sri Lanka',
  ];

  bool isLoading = true;

  List<String> countries = ["india", "china", "uae"];

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    controller = FxControllerStore.put(SearchController(this));
    fetchData();
    _width = 100;
    _btnText = "Search";
  }

  double? _width;
  String? _btnText;

  Future _pretendSearch() async {
    setState(() {
      _btnText = "";
      _width = 36;
    });
    await Future.delayed(const Duration(seconds: 2));
    controller.searchVisabtn(
      // controller.locationTE.text
      _selectedCountry!,
      // controller.allattractionList.first
    );
    setState(() {
      _btnText = "Search";
      _width = 120;
    });
  }


  fetchData() {
    Future.delayed(Duration.zero, () async {
      await getCountryList().then((value) {
        if (value) {
          isLoading = false;
          setState(() {});
        }
      });
    });
  }

   VisaCountryModal? _selectedCountry;
  List<VisaCountryModal> countryList = <VisaCountryModal>[];
  bool isCountryListLoading = true;
  Future getCountryList() async {
    isCountryListLoading = true;
    try {
      var data = await VisaService().getVisaCountry();
      countryList.clear();
      if (data != null) {
        setState(() {});
        // countryList.add(data);
        countryList = data;

        isCountryListLoading = false;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      // isLoading
      //     ? const CircularProgressIndicator()
      //     :
      FxBuilder<SearchController>(
          controller: controller,
          builder: (controller) {
            return Container(
              child: Column(
                children: [
                  _searchBox(),
                ],
              ),
            );
          });
  }

  Widget _searchBox() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(80)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                // Color.fromARGB(255, 127, 0, 255),
                // Color.fromARGB(255, 255, 0, 255)
                const Color(0xff1529e8),
                const Color.fromARGB(255, 82, 96, 222).withOpacity(0.8),
              ]),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            _searchField(),
            _searchBtn(),
          ],
        ));
  }

  Widget _searchField() {

    return Expanded(
        child: SlideTransition(
            position: controller.locationAnimation,
            child:
            SearchField(
              searchStyle: const TextStyle(color: Colors.white),
              suggestionStyle: FxTextStyle.bodyMedium(),
              controller: controller.visaTE,
              hint: 'Select Visa',
              searchInputDecoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  isDense: true,
                  fillColor: Colors.transparent,
                  suffixIcon: const Icon(
                    Iconsax.location,
                    color: Colors.white,
                  ),
                  hintText: "Where do you want to see?",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: FxSpacing.all(16),
                  hintStyle: const TextStyle(color: Colors.white),
                  isCollapsed: true),
              maxSuggestionsInViewPort: 6,
              itemHeight: 50,
              suggestionsDecoration: BoxDecoration(
                color: const Color(0xfff5f5f5),
                borderRadius: BorderRadius.circular(10),
              ),
              onSuggestionTap: (value) {
                log('tap');

                print('value Country-->${value.item!}');
                print('value Country value-->${value.item.runtimeType}');


                _selectedCountry = value.item! as VisaCountryModal;

                log('onSuggestionTap');
                print('onsugguest');
                // log('value Country-->${value.item!.name}');

                log(value.searchKey.toString());
                controller.visaFocus.unfocus();
                // setState(() {
                //   _selectedCountry = controller.visaTE.text;
                //   // controller.locationTE.text = controller.locationplace!;
                //   log('controller:${controller.visaTE.text}');
                // });
              },
                suggestions: countryList.isEmpty ||
                    countryList.first.name.isEmpty
                    ? []

                    // _countryCodes
                        .map((e) => SearchFieldListItem<VisaCountryModal>(
                      // e,

                        e!.name.toString(),
                        item: e,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            // e,
                            e.name.toString(),
                            style: FxTextStyle.bodyMedium(),
                          ),
                        )))
                        .toList()
                    : countryList
                .map((e) => SearchFieldListItem<VisaCountryModal>(
        // e,

        e.name.toString(),
        item: e,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            // e,
            e.name.toString(),
            style: FxTextStyle.bodyMedium(),
          ),
        )))
        .toList()
              // [
              //   countryList.elementAt(0).name,
              //   countryList.elementAt(1).name
              // ]
              //    countryList.map((e) => SearchFieldListItem(e, child: Text(e)))
              //     .toList(),
            ),
    ),
    );
  }

  Widget _searchBtn() {
    return AnimatedContainer(
        width: _width,
        height: 36,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40))),
          child: _btnText == "" ? _loadingBox() : _btnTextWidget(),
          onPressed: () async {
            await _pretendSearch();
          },
        ));
  }

  Widget _btnTextWidget() {
    return Text(
      _btnText.toString(),
      style: const TextStyle(
        color: Color.fromARGB(255, 127, 0, 255),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _loadingBox() {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(0),
        child: const SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(
              backgroundColor: Color.fromARGB(255, 127, 0, 255),
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 255, 0, 255)),
            )));
  }
}
