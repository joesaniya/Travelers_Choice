import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:searchfield/searchfield.dart';
import '../../controllers/search_controller.dart';
import '../../models/Country_modal.dart';
import '../../services/auth_service.dart';
import '../../theme/app_theme.dart';

class SearchPlace extends StatefulWidget {
  String isocode;
  double conversionRate;
  SearchPlace({super.key, required this.isocode, required this.conversionRate});

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace>
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

  @override
  void initState() {
    super.initState();
    log('ConversionRate111:${widget.isocode}');
    log('ConversionSymbol111:${widget.conversionRate}');
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
    controller.searchbtn(
      // controller.locationTE.text
      _selectedCountry!,
      widget.isocode,
      widget.conversionRate,

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
      // await AuthController().getCountryList().then((value) {
      //   if (value) {
      //     isLoading = false;
      //     setState(() {});
      //   }
      // });
    });
  }

  Destination? _selectedCountry;

  List<CountryModal> countryList = <CountryModal>[];
  bool isCountryListLoading = true;
  Future getCountryList() async {
    isCountryListLoading = true;
    try {
      var data = await AuthService().getCountry();
      countryList.clear();
      if (data != null) {
        setState(() {});
        countryList.add(data);
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
                    // SizedBox(
                    //   height: 100,
                    //   width: double.infinity,
                    //   child: DropdownSearch<String>(
                    //     popupProps: PopupProps.menu(
                    //       showSelectedItems: true,
                    //       disabledItemFn: (String s) => s.startsWith('I'),
                    //     ),
                    //     items: const [
                    //       "Brazil",
                    //       "Italia (Disabled)",
                    //       "Tunisia",
                    //       'Canada'
                    //     ],
                    //     dropdownDecoratorProps: const DropDownDecoratorProps(
                    //       dropdownSearchDecoration: InputDecoration(
                    //           // labelText: "Menu mode",
                    //           // hintText: "country in menu mode",
                    //           ),
                    //     ),
                    //     onChanged: print,
                    //     selectedItem: "Brazil",
                    //   ),
                    // )
                  ],
                ),
              );
            });
  }

  Widget _searchBox() {
    return Container(
        // width: kIsWeb ? 450 : double.infinity,
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
        child: SearchField<Destination>(
          focusNode: controller.focus,

          // searchStyle: FxTextStyle.bodyMedium(),
          searchStyle: const TextStyle(color: Colors.white),
          suggestionStyle: FxTextStyle.bodyMedium(),
          controller: controller.locationTE,
          hint: 'Where do you want to see?',

          searchInputDecoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              // fillColor: theme.cardTheme.color,
              fillColor: Colors.transparent,
              suffixIcon: const Icon(
                Iconsax.location,
                // color: theme.colorScheme.onBackground,
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
            // color: Colors.white
            color: const Color(0xfff5f5f5),

            borderRadius: BorderRadius.circular(10),
          ),
          onSubmit: (value) {
            log('ONSUBIT');
          },
          onSuggestionTap: (value) {
            log('tap');

            _selectedCountry = value.item!;

            log('onSuggestionTap');
            print('onsugguest');
            print('value Country-->${value.item!.name}');
            log('value Country-->${value.item!.name}');

            log(value.searchKey.toString());
            controller.focus.unfocus();
            setState(() {
              _selectedCountry!.country = controller.locationTE.text;
              // controller.locationTE.text = controller.locationplace!;
              log('controller:${controller.locationTE.text}');
            });
          },

          suggestions: countryList.isEmpty ||
                  countryList.first.destinations.isEmpty
              ? []

              // // _countryCodes
              // .map((e) => SearchFieldListItem<Destination>(
              //     // e,

              //     e!.countryName.toString(),
              //     item: e,
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //       child: Text(
              //         // e,
              //         'No Data',
              //         // e.name.toString()[0].toUpperCase() +
              //         //     e.name.toString().substring(1).toLowerCase(),
              //         style: FxTextStyle.bodyMedium(),
              //       ),
              //     )))
              // .toList()
              : countryList.first.destinations
                  .map((e) => SearchFieldListItem<Destination>(
                      // e,

                      e.name.toString()[0].toUpperCase() +
                          e.name.toString().substring(1).toLowerCase(),
                      item: e,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          // e,
                          // controller.locationTE.text.isEmpty?Text('Nodata'):Text('data'),

                          e.name.toString()[0].toUpperCase() +
                              e.name.toString().substring(1).toLowerCase(),
                          style: FxTextStyle.bodyMedium(),
                        ),
                      )))
                  .toList(),
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
              backgroundColor: Colors.white,
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
