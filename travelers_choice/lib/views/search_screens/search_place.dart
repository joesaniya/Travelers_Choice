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
  const SearchPlace({Key? key}) : super(key: key);

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
              // return Container(
              //   // color: Colors.yellow,
              //   // padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 99),
              //   child: Column(
              //     children: <Widget>[
              //       Container(
              //         // color: Colors.yellow,
              //         // margin: EdgeInsets.only(left: 24, right: 24, top: 36),
              //         child: FxContainer.none(
              //           borderRadiusAll: 4,
              //           // border: Border.all(color: Colors.blue),
              //           child: Column(
              //             children: <Widget>[

              //               GestureDetector(
              //                 onTap: () => FocusScope.of(context).unfocus(),
              //                 child: SlideTransition(
              //                   position: controller.locationAnimation,
              //                   child: SearchField<Destination>(
              //                     focusNode: controller.focus,
              //                     searchStyle: FxTextStyle.bodyMedium(),
              //                     suggestionStyle: FxTextStyle.bodyMedium(),
              //                     controller: controller.locationTE,
              //                     hint: 'Search',
              //                     searchInputDecoration: InputDecoration(
              //                         floatingLabelBehavior:
              //                             FloatingLabelBehavior.never,
              //                         filled: true,
              //                         isDense: true,
              //                         fillColor: theme.cardTheme.color,
              //                         suffixIcon: Icon(
              //                           Iconsax.location,
              //                           color: theme.colorScheme.onBackground,
              //                         ),
              //                         hintText: "Where do you want to see?",
              //                         border: const OutlineInputBorder(
              //                             borderSide: BorderSide(
              //                                 color: Color(0xff1529e8),
              //                                 // color: Colors.lightBlueAccent,
              //                                 width: 1)),
              //                         enabledBorder: const OutlineInputBorder(
              //                             borderSide: BorderSide(
              //                                 color: Color(0xff1529e8),
              //                                 width: 1)),
              //                         focusedBorder: const OutlineInputBorder(
              //                             borderSide: BorderSide(
              //                                 color: Color(0xff1529e8),
              //                                 width: 1)),
              //                         contentPadding: FxSpacing.all(16),
              //                         hintStyle: FxTextStyle.bodyMedium(),
              //                         isCollapsed: true),
              //                     maxSuggestionsInViewPort: 6,
              //                     itemHeight: 50,

              //                     suggestionsDecoration: BoxDecoration(
              //                       // color: Colors.white
              //                       color: const Color(0xfff5f5f5),
              //                       // color: const Color(0xff1529e8),
              //                       borderRadius: BorderRadius.circular(10),
              //                     ),
              //                     onSubmit: (value) {
              //                       log('ONSUBIT');
              //                     },
              //                     // onSubmit: (value) {
              //                     //   setState(() {
              //                     //     // _selectedItem = value;
              //                     //     _selectedCountry = value;
              //                     //     // foundCompany = value as List<Search>?;
              //                     //   });

              //                     //   print(value);
              //                     //   log(value);
              //                     //   log('country');
              //                     // },
              //                     // onSuggestionTap: (SearchFieldListItem x) {
              //                     //   _selectedCountry = x.item;
              //                     //   setState(() {});
              //                     //   log('se');
              //                     // },
              //                     onSuggestionTap: (value) {
              //                       log('tap');

              //                       // log(countryList.first.destinations
              //                       //     .toString());
              //                       // log(countryList.first.destinations);
              //                       // countryList.first.countries =
              //                       //     value.item as List<Country?>?;
              //                       _selectedCountry = value.item!;

              //                       log('onSuggestionTap');
              //                       print('onsugguest');
              //                       print(
              //                           'value Country-->${value.item!.name}');
              //                       log('value Country-->${value.item!.name}');

              //                       log(value.searchKey.toString());
              //                       controller.focus.unfocus();
              //                       setState(() {});
              //                     },
              //                     // suggestions:
              //                     //     //  _countryCodes
              //                     //     AuthController()
              //                     //         .countryList
              //                     //         .first
              //                     //         .countries!
              //                     //         .map((e) =>
              //                     //             SearchFieldListItem(e.toString(),
              //                     //                 child: Text(
              //                     //                   e!.countryName.toString(),
              //                     //                   style: const TextStyle(
              //                     //                       color: Colors.black),
              //                     //                 )))
              //                     //         .toList(),
              //                     suggestions:
              //                         //  AuthController()
              //                         //     .countryList
              //                         //     .first
              //                         //     .countries!
              //                         countryList.isEmpty ||
              //                                 countryList
              //                                     .first.destinations.isEmpty
              //                             ? []

              //                                 // _countryCodes
              //                                 .map((e) => SearchFieldListItem<
              //                                         Destination>(
              //                                     // e,

              //                                     e!.countryName.toString(),
              //                                     item: e,
              //                                     child: Padding(
              //                                       padding: const EdgeInsets
              //                                               .symmetric(
              //                                           horizontal: 8.0),
              //                                       child: Text(
              //                                         // e,
              //                                         e.countryName.toString(),
              //                                         style: FxTextStyle
              //                                             .bodyMedium(),
              //                                       ),
              //                                     )))
              //                                 .toList()
              //                             : countryList.first.destinations
              //                                 .map((e) => SearchFieldListItem<
              //                                         Destination>(
              //                                     // e,

              //                                     e.name.toString(),
              //                                     item: e,
              //                                     child: Padding(
              //                                       padding: const EdgeInsets
              //                                               .symmetric(
              //                                           horizontal: 8.0),
              //                                       child: Text(
              //                                         // e,
              //                                         e.name.toString(),
              //                                         style: FxTextStyle
              //                                             .bodyMedium(),
              //                                       ),
              //                                     )))
              //                                 .toList(),
              //                   ),
              //                 ),
              //               ),
              //               SlideTransition(
              //                 position: controller.dateAnimation,
              //                 child: TextFormField(
              //                   style: FxTextStyle.bodyMedium(),
              //                   controller: controller.dateTE,
              //                   readOnly:
              //                       true, //set it true, so that user will not able to edit text

              //                   onTap: controller.dateselect,
              //                   decoration: InputDecoration(
              //                       floatingLabelBehavior:
              //                           FloatingLabelBehavior.never,
              //                       filled: true,
              //                       isDense: true,
              //                       fillColor: theme.cardTheme.color,
              //                       suffixIcon: Icon(
              //                         FeatherIcons.calendar,
              //                         color: theme.colorScheme.onBackground,
              //                       ),
              //                       hintText: "yyyy-mm-dd",
              //                       // border: InputBorder.none,
              //                       // enabledBorder: InputBorder.none,
              //                       // focusedBorder: InputBorder.none,
              //                       border: const OutlineInputBorder(
              //                           borderSide: BorderSide(
              //                               color: Color(0xff1529e8),
              //                               // color: Colors.lightBlueAccent,
              //                               width: 1)),
              //                       enabledBorder: const OutlineInputBorder(
              //                           borderSide: BorderSide(
              //                               color: Color(0xff1529e8),
              //                               width: 1)),
              //                       focusedBorder: const OutlineInputBorder(
              //                           borderSide: BorderSide(
              //                               color: Color(0xff1529e8),
              //                               width: 1)),
              //                       contentPadding: FxSpacing.all(16),
              //                       hintStyle: FxTextStyle.bodyMedium(),
              //                       isCollapsed: true),
              //                   autofocus: false,
              //                   keyboardType: TextInputType.datetime,
              //                 ),
              //               ),
              //               SlideTransition(
              //                 position: controller.locationAnimation,
              //                 child: FxButton.block(
              //                   elevation: 0,
              //                   borderRadiusAll: 4,
              //                   onPressed: () {
              //                     log('search_button');
              //                     log("Selected Data:$_selectedCountry");

              //                     controller.searchbtn(
              //                       _selectedCountry!,
              //                       // controller.allattractionList.first
              //                     );
              //                   },
              //                   splashColor:
              //                       theme.colorScheme.onPrimary.withAlpha(28),
              //                   // backgroundColor: theme.colorScheme.primary,
              //                   backgroundColor: const Color(0xff1529e8),
              //                   child: Container(
              //                     clipBehavior: Clip.antiAliasWithSaveLayer,
              //                     decoration: const BoxDecoration(),
              //                     child: Row(
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       children: [
              //                         FxText.labelLarge(
              //                           "Search",
              //                           fontWeight: 600,
              //                           color: theme.colorScheme.onPrimary,
              //                           letterSpacing: 0.4,
              //                         ),
              //                         FxSpacing.width(8),
              //                         SlideTransition(
              //                             position: controller.searchAnimation,
              //                             child: Icon(
              //                               FeatherIcons.search,
              //                               color: theme.colorScheme.onPrimary,
              //                               size: 20,
              //                             )),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // );
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
              // hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          maxSuggestionsInViewPort: 6,
          itemHeight: 50,
          suggestionsDecoration: BoxDecoration(
            // color: Colors.white
            color: const Color(0xfff5f5f5),
            // color: const Color(0xff1529e8).withOpacity(0.2),
            // color: const Color(0xff1529e8),
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

                  // _countryCodes
                  .map((e) => SearchFieldListItem<Destination>(
                      // e,

                      e!.countryName.toString(),
                      item: e,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          // e,
                          e.name.toString()[0].toUpperCase() +
                              e.name.toString().substring(1).toLowerCase(),
                          style: FxTextStyle.bodyMedium(),
                        ),
                      )))
                  .toList()
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
