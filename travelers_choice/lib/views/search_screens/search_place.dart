import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
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

  String? _selectedCountry;

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
                // color: Colors.yellow,
                // padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 99),
                child: Column(
                  children: <Widget>[
                    Container(
                      // color: Colors.yellow,
                      // margin: EdgeInsets.only(left: 24, right: 24, top: 36),
                      child: FxContainer.none(
                        borderRadiusAll: 4,
                        // border: Border.all(color: Colors.blue),
                        child: Column(
                          children: <Widget>[
                            // SlideTransition(
                            //   position: controller.locationAnimation,
                            //   child: TextFormField(
                            //     style: FxTextStyle.bodyMedium(),

                            //     decoration: InputDecoration(
                            //         floatingLabelBehavior:
                            //             FloatingLabelBehavior.never,
                            //         filled: true,
                            //         isDense: true,
                            //         fillColor: theme.cardTheme.color,
                            //         suffixIcon: Icon(
                            //           FeatherIcons.map,
                            //           color: theme.colorScheme.onBackground,
                            //         ),
                            //         hintText: "Where do you want to see?",
                            //         border: const OutlineInputBorder(
                            //             borderSide: BorderSide(
                            //                 color: Color(0xff1529e8),
                            //                 // color: Colors.lightBlueAccent,
                            //                 width: 1)),
                            //         enabledBorder: const OutlineInputBorder(
                            //             borderSide: BorderSide(
                            //                 color: Color(0xff1529e8), width: 1)),
                            //         focusedBorder: const OutlineInputBorder(
                            //             borderSide: BorderSide(
                            //                 color: Color(0xff1529e8), width: 1)),
                            //         contentPadding: FxSpacing.all(16),
                            //         hintStyle: FxTextStyle.bodyMedium(),
                            //         isCollapsed: true),
                            //     maxLines: 1,
                            //     controller: controller.locationTE,
                            //     // validator: controller.validatePassword,
                            //     cursorColor: theme.colorScheme.onBackground,
                            //   ),
                            // ),

                            GestureDetector(
                              onTap: () => FocusScope.of(context).unfocus(),
                              child: SlideTransition(
                                position: controller.locationAnimation,
                                child: SearchField(
                                  focusNode: controller.focus,
                                  searchStyle: FxTextStyle.bodyMedium(),
                                  suggestionStyle: FxTextStyle.bodyMedium(),
                                  controller: controller.locationTE,
                                  hint: 'Search',
                                  searchInputDecoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      isDense: true,
                                      fillColor: theme.cardTheme.color,
                                      suffixIcon: Icon(
                                        Iconsax.location,
                                        color: theme.colorScheme.onBackground,
                                      ),
                                      hintText: "Where do you want to see?",
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff1529e8),
                                              // color: Colors.lightBlueAccent,
                                              width: 1)),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff1529e8),
                                              width: 1)),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff1529e8),
                                              width: 1)),
                                      contentPadding: FxSpacing.all(16),
                                      hintStyle: FxTextStyle.bodyMedium(),
                                      isCollapsed: true),
                                  maxSuggestionsInViewPort: 6,
                                  itemHeight: 50,

                                  suggestionsDecoration: BoxDecoration(
                                    // color: Colors.white
                                    color: const Color(0xfff5f5f5),
                                    // color: const Color(0xff1529e8),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onSubmit: (value) {
                                    setState(() {
                                      // _selectedItem = value;
                                      _selectedCountry = value;
                                      // foundCompany = value as List<Search>?;
                                    });

                                    print(value);
                                    log(value);
                                    log('country');
                                  },
                                  // onSuggestionTap: (SearchFieldListItem x) {
                                  //   _selectedCountry = x.item;
                                  //   setState(() {});
                                  //   log('se');
                                  // },
                                  onSuggestionTap: (value) {
                                    log('tap');
                                    // log(countryList.first.destinations
                                    //     .toString());
                                    // log(countryList.first.destinations);
                                    // countryList.first.countries =
                                    //     value.item as List<Country?>?;
                                    _selectedCountry = value.item.toString();
                                    setState(() {});
                                    log('onSuggestionTap');
                                    log(value.searchKey.toString());
                                    controller.focus.unfocus();
                                  },
                                  // suggestions:
                                  //     //  _countryCodes
                                  //     AuthController()
                                  //         .countryList
                                  //         .first
                                  //         .countries!
                                  //         .map((e) =>
                                  //             SearchFieldListItem(e.toString(),
                                  //                 child: Text(
                                  //                   e!.countryName.toString(),
                                  //                   style: const TextStyle(
                                  //                       color: Colors.black),
                                  //                 )))
                                  //         .toList(),
                                  suggestions:
                                      //  AuthController()
                                      //     .countryList
                                      //     .first
                                      //     .countries!
                                      countryList.isEmpty ||
                                              countryList
                                                  .first.destinations.isEmpty
                                          ? []

                                              // _countryCodes
                                              .map((e) => SearchFieldListItem(
                                                  // e,
                                                  e!.countryName.toString(),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Text(
                                                      // e,
                                                      e.countryName.toString(),
                                                      style: FxTextStyle
                                                          .bodyMedium(),
                                                    ),
                                                  )))
                                              .toList()
                                          : countryList.first.destinations
                                              .map((e) => SearchFieldListItem(
                                                  // e,
                                                  e.name.toString(),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Text(
                                                      // e,
                                                      e.name.toString(),
                                                      style: FxTextStyle
                                                          .bodyMedium(),
                                                    ),
                                                  )))
                                              .toList(),
                                ),
                              ),
                            ),
                            SlideTransition(
                              position: controller.dateAnimation,
                              child: TextFormField(
                                style: FxTextStyle.bodyMedium(),
                                controller: controller.dateTE,
                                readOnly:
                                    true, //set it true, so that user will not able to edit text
                                // onTap: () async {
                                //   DateTime? pickedDate = await showDatePicker(
                                //       context: context,
                                //       initialDate: DateTime.now(),
                                //       firstDate: DateTime(
                                //           1900), //DateTime.now() - not to allow to choose before today.
                                //       lastDate: DateTime(2101));

                                //   if (pickedDate != null) {
                                //     print(
                                //         pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                //     String formattedDate =
                                //         DateFormat('yyyy-MM-dd').format(pickedDate);
                                //     print(
                                //         formattedDate); //formatted date output using intl package =>  2021-03-16
                                //     //you can implement different kind of Date Format here according to your requirement

                                //     setState(() {
                                //       dateinput.text =
                                //           formattedDate; //set output date to TextField value.
                                //     });
                                //   } else {
                                //     print("Date is not selected");
                                //   }
                                // },
                                onTap: controller.dateselect,
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    filled: true,
                                    isDense: true,
                                    fillColor: theme.cardTheme.color,
                                    suffixIcon: Icon(
                                      FeatherIcons.calendar,
                                      color: theme.colorScheme.onBackground,
                                    ),
                                    hintText: "yyyy-mm-dd",
                                    // border: InputBorder.none,
                                    // enabledBorder: InputBorder.none,
                                    // focusedBorder: InputBorder.none,
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff1529e8),
                                            // color: Colors.lightBlueAccent,
                                            width: 1)),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff1529e8),
                                            width: 1)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff1529e8),
                                            width: 1)),
                                    contentPadding: FxSpacing.all(16),
                                    hintStyle: FxTextStyle.bodyMedium(),
                                    isCollapsed: true),
                                autofocus: false,
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                            SlideTransition(
                              position: controller.locationAnimation,
                              child: FxButton.block(
                                elevation: 0,
                                borderRadiusAll: 4,
                                onPressed: () {
                                  controller.searchbtn(_selectedCountry);
                                },
                                splashColor:
                                    theme.colorScheme.onPrimary.withAlpha(28),
                                // backgroundColor: theme.colorScheme.primary,
                                backgroundColor: const Color(0xff1529e8),
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: const BoxDecoration(),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FxText.labelLarge(
                                        "Search",
                                        fontWeight: 600,
                                        color: theme.colorScheme.onPrimary,
                                        letterSpacing: 0.4,
                                      ),
                                      FxSpacing.width(8),
                                      SlideTransition(
                                          position: controller.searchAnimation,
                                          child: Icon(
                                            FeatherIcons.search,
                                            color: theme.colorScheme.onPrimary,
                                            size: 20,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
  }
}
