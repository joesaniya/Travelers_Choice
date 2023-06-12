import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/attraction_Controller.dart';
import '../../controllers/search_attraction_controller.dart';

import '../../services/app_constants.dart';
import '../../services/auth_service.dart';
import '../../theme/app_theme.dart';

class SearchAttractionScreen extends StatefulWidget {
  String isocode;
  double conversionRate;
  SearchAttractionScreen(
      {super.key, required this.isocode, required this.conversionRate});

  @override
  State<SearchAttractionScreen> createState() => _SearchAttractionScreenState();
}

class _SearchAttractionScreenState extends State<SearchAttractionScreen>
    with TickerProviderStateMixin {
  late CustomTheme customTheme;
  late ThemeData theme;
  late SearchAttractionController controller;
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

  bool isLoading = true; //searchbuttonloading
  bool isLoadingg = true; //getattraction

  @override
  void initState() {
    super.initState();
    log('ConversionRate111:${widget.isocode}');
    log('ConversionSymbol111:${widget.conversionRate}');
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    controller = FxControllerStore.put(SearchAttractionController(this));
    fetchData();
    getAttraction(context);
    _width = 100;
    _btnText = "Search";
  }

  SharedPreferences? sharedPreferences;
  // List<AllattractionModal> allattractionList = <AllattractionModal>[];

  getAttraction(BuildContext context) async {
    await AuthService().getCountry();
    log('searchAttraction function called');
    sharedPreferences = await SharedPreferences.getInstance();
    Future.delayed(Duration.zero, () async {
      await AttractionController().getAllattractionList(context).then((value) {
        if (value != null) {
          isLoadingg = false;
          controller.allattractionList = [];
          controller.allattractionList!.add(value);
          log('All1:${controller.allattractionList}');

          setState(() {
            controller.countryCode = sharedPreferences!
                .getString(AppConstants.KEY_ACCESS_TOKEN_countryId);
            log('CountryCode:${controller.countryCode}');
            controller.currencies = sharedPreferences!
                .getString(AppConstants.KEY_ACCESS_TOKEN_CurrenciesList);
          });
        }
      });
    });
  }

  double? _width;
  String? _btnText;
  String? keydata;
  Future _pretendSearch() async {
    setState(() {
      _btnText = "";
      _width = 36;
    });
    await Future.delayed(const Duration(seconds: 2));
    controller.searchbtn(
      controller.locationTE.text,
      // controller.selectedCountry!,
      keydata!,

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
      log('delayed');
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

  // AttractionSearchDataModal? _selectedCountry;
  // String? _selectedCountry;

  // List<AttractionSearchDataModal> countryList = <AttractionSearchDataModal>[];
  bool isCountryListLoading = true;
  Future getCountryList() async {
    isCountryListLoading = true;
    try {
      log('try');
      // var data = await AuthService().getCountry();
      var data = await AuthService().getSearch();
      controller.countryList.clear();
      if (data != null) {
        setState(() {});
        controller.countryList.add(data);
        isCountryListLoading = false;
        log('get');
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
        FxBuilder<SearchAttractionController>(
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
        child: SearchField(
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

            controller.selectedCountry = value.searchKey;

            log('onSuggestionTap');
            print('onsugguest');
            print('value Country-->${value.item!}');
            log('value Country-->${value.item!}');

            // log(value.searchKey.toString());
            log(value.item.toString());
            controller.focus.unfocus();
            keydata = value.item.toString();
            log('keydata1:$keydata');
            setState(() {
              // _selectedCountry!.country = controller.locationTE.text;
              // _selectedCountry.attractions.first.id =
              //     controller.locationTE.text;
              controller.selectedCountry = keydata;
              log('keydata:$keydata');
              controller.selectedCountry = controller.locationTE.text;
              // controller.locationTE.text = controller.locationplace!;
              log('controller TE:${controller.locationTE.text}');
            });
          },

          suggestions: controller.countryList.isEmpty ||
                  controller.countryList.first.destinations.isEmpty
              ? []
              : controller.countryList.first.destinations
                      .map((e) => SearchFieldListItem<dynamic>(
                          // e,

                          e.name.toString()[0].toUpperCase() +
                              e.name.toString().substring(1).toLowerCase(),
                          item: e.sId,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              // e,
                              // controller.locationTE.text.isEmpty?Text('Nodata'):Text('data'),

                              e.name.toString()[0].toUpperCase() +
                                  e.name.toString().substring(1).toLowerCase(),
                              style: FxTextStyle.bodyMedium(),
                            ),
                          )))
                      .toList() +
                  controller.countryList.first.attractions
                      .map((e) => SearchFieldListItem<dynamic>(
                          // e,

                          e.title.toString()[0].toUpperCase() +
                              e.title.toString().substring(1).toLowerCase(),
                          item: e.id,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              // e,
                              // controller.locationTE.text.isEmpty?Text('Nodata'):Text('data'),

                              e.title.toString()[0].toUpperCase() +
                                  e.title.toString().substring(1).toLowerCase(),
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
