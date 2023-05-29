import 'dart:developer';
import 'package:iconsax/iconsax.dart';
import 'package:searchfield/searchfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/Hotel_folder/views/search_hotel.dart';
import 'package:intl/intl.dart';
import '../../models/Country_modal.dart';
import '../../services/auth_service.dart';
import '../../theme/app_theme.dart';
import '../bottomsheet.dart/person_seat.dart';
import '../controller/hotel_search_controller.dart';
import '../controller/person_seat_controller.dart';

class HotelSearch extends StatefulWidget {
  const HotelSearch({super.key});

  @override
  State<HotelSearch> createState() => _HotelSearchState();
}

class _HotelSearchState extends State<HotelSearch>
    with TickerProviderStateMixin {
  late HotelSearchController controller;
  late PersonSeatController controller1;
  // late AnimationController controller;
  // Animation<Offset>? offset;
  late ThemeData theme, theme1;

  @override
  void initState() {
    super.initState();
    fetchData();

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    // controller = AnimationController(
    //     vsync: this, duration: const Duration(milliseconds: 800));

    // offset = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
    //     .animate(CurvedAnimation(
    //   parent: controller,
    //   curve: Curves.easeOut,
    // ));
    controller = FxControllerStore.put(HotelSearchController(this));
    controller1 = FxControllerStore.put(PersonSeatController(this));
  }

  // @override
  // dispose() {
  //   super.dispose();
  //   controller.dispose();
  // }

  _pickDate(BuildContext context) async {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
  }

  Future<void> checkinPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2101));

    if (picked != null && picked != controller.selectedValue) {
      controller.selectedValue = picked;
      setState(() {
        controller.selectedValue = picked;
      });
    }

    log('selected:$controller.selectedValue');
  }

  Future<void> checkOutPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2101));

    if (picked != null && picked != controller.selectedCheckOut) {
      setState(() {
        controller.selectedCheckOut = picked;
      });
    }

    log('selected:$controller.selectedValue');
  }

  bool isLoading = true;

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
    DateTime newdate = DateTime.now();
    DateTime newdate2 = controller.selectedValue;
    String formattedYear = DateFormat.MMMd().format(newdate);
    String formattedYeardate = DateFormat.MMMd().format(newdate2);
    log('ui1:$formattedYear');
    log('ui2:$formattedYeardate');
    //checkOut
    DateTime checkOutTimeNow = DateTime.now();
    DateTime checkOutTimeSel = controller.selectedCheckOut;
    String CurrentTimeCheckout = DateFormat.MMMd().format(checkOutTimeNow);
    String SlecteddateCheckout = DateFormat.MMMd().format(checkOutTimeSel);
    log('Checkout1:$CurrentTimeCheckout');
    log('Checkout2:$SlecteddateCheckout');
    return FxBuilder<HotelSearchController>(
        controller: controller,
        builder: (controller) {
          return FxContainer.bordered(
            marginAll: 0,
            color: Colors.transparent,
            paddingAll: 0,
            borderColor: const Color(0xff1529e8),
            child: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        // child: TextFormField(
                        //   style: FxTextStyle.titleSmall(
                        //     fontWeight: 500,
                        //   ),
                        //   decoration: InputDecoration(
                        //     hintStyle: FxTextStyle.titleSmall(fontWeight: 500),
                        //     hintText: "Hotels near me",
                        //     border: InputBorder.none,
                        //     enabledBorder: InputBorder.none,
                        //     focusedBorder: InputBorder.none,
                        //     prefixIcon: Icon(
                        //       MdiIcons.magnify,
                        //       size: 22,
                        //       color: theme.colorScheme.onBackground,
                        //     ),
                        //     isDense: true,
                        //     contentPadding: const EdgeInsets.only(top: 14),
                        //   ),
                        //   autofocus: false,
                        //   textInputAction: TextInputAction.search,
                        //   textCapitalization: TextCapitalization.sentences,
                        //   controller: TextEditingController(text: ""),
                        // ),

                        //   search
                        child: SearchField<Destination>(
                          focusNode: controller.focus,

                          // searchStyle: FxTextStyle.bodyMedium(),
                          searchStyle: const TextStyle(color: Colors.black),
                          suggestionStyle: FxTextStyle.bodyMedium(),
                          controller: controller.locationTE,
                          hint: 'Where do you want to see?',

                          searchInputDecoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              isDense: true,
                              // fillColor: theme.cardTheme.color,
                              fillColor: Colors.transparent,
                              // suffixIcon: const Icon(
                              //   Iconsax.location,
                              //   // color: theme.colorScheme.onBackground,
                              //   color: Colors.black,
                              // ),
                              hintText: "Where do you want to see?",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: FxSpacing.all(16),
                              hintStyle: const TextStyle(color: Colors.black),
                              isCollapsed: true),
                          maxSuggestionsInViewPort: 6,
                          itemHeight: 50,
                          suggestionsDecoration: BoxDecoration(
                            // color: Colors.black,
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
                              _selectedCountry!.country =
                                  controller.locationTE.text;
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
                                          e.name
                                              .toString()
                                              .substring(1)
                                              .toLowerCase(),
                                      item: e,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          // e,
                                          // controller.locationTE.text.isEmpty?Text('Nodata'):Text('data'),

                                          e.name.toString()[0].toUpperCase() +
                                              e.name
                                                  .toString()
                                                  .substring(1)
                                                  .toLowerCase(),
                                          style: FxTextStyle.bodyMedium(),
                                        ),
                                      )))
                                  .toList(),
                        ),

                        // child: DropdownFormField<Map<String, dynamic>>(
                        //   onEmptyActionPressed: () async {},
                        //   decoration: const InputDecoration(
                        //       border: OutlineInputBorder(),
                        //       suffixIcon: Icon(Icons.arrow_drop_down),
                        //       labelText: "Hotels near me"),
                        //   onSaved: (dynamic str) {},
                        //   onChanged: (dynamic str) {},
                        //   validator: (dynamic str) {
                        //     return null;
                        //   },
                        //   displayItemFn: (dynamic item) => Text(
                        //     (item ?? {})['name'] ?? '',
                        //     style: const TextStyle(fontSize: 16),
                        //   ),
                        //   findFn: (dynamic str) async => controller.roles,
                        //   selectedFn: (dynamic item1, dynamic item2) {
                        //     if (item1 != null && item2 != null) {
                        //       return item1['name'] == item2['name'];
                        //     }
                        //     return false;
                        //   },
                        //   filterFn: (dynamic item, str) =>
                        //       item['name']
                        //           .toLowerCase()
                        //           .indexOf(str.toLowerCase()) >=
                        //       0,
                        //   dropdownItemFn: (dynamic item,
                        //           int position,
                        //           bool focused,
                        //           bool selected,
                        //           Function() onTap) =>
                        //       ListTile(
                        //     title: Text(item['name']),
                        //     subtitle: Text(
                        //       item['desc'] ?? '',
                        //     ),
                        //     tileColor: focused
                        //         ? const Color.fromARGB(20, 0, 0, 0)
                        //         : Colors.transparent,
                        //     onTap: onTap,
                        //   ),
                        // ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 16, left: 16),
                        child: InkWell(
                          onTap: () {
                            // _pickDate(context);
                          },
                          child: Icon(
                            // MdiIcons.calendarOutline,
                            Iconsax.location,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    height: 0,
                    color: Color(0xff1529e8),
                    // color: theme.dividerColor,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            // onTap: () async {
                            //   DateTime? pickedDate =
                            //       await showDatePicker(
                            //           context: context,
                            //           initialDate: DateTime.now(),
                            //           firstDate: DateTime(
                            //               1900), //DateTime.now() - not to allow to choose before today.
                            //           lastDate: DateTime(2101));
                            //   if (pickedDate != null) {
                            //     print(
                            //         pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            //     String formattedDate =
                            //         DateFormat('yyyy-MM-dd')
                            //             .format(pickedDate);
                            //     print(formattedDate);
                            //     controller.selectedValue =
                            //         formattedDate as DateTime;
                            //     log('Checkin:${controller.selectedValue}');
                            //   } else {
                            //     log("checkIn is not selected");
                            //   }
                            // },
                            onTap: () => checkinPicker(context),
                            // onTap: () => controller.showPicker(context),
                            child: Container(
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: FxSpacing.only(
                                          // left: 16
                                          left: 0),
                                      child: FxText.bodySmall("Check in",
                                          fontWeight: 500),
                                    ),
                                    // SlideTransition(
                                    //   position: controller.checkInAnimation,
                                    //   child: TextFormField(
                                    //     onTap: () async {
                                    //       DateTime? pickedDate =
                                    //           await showDatePicker(
                                    //               context: context,
                                    //               initialDate: DateTime.now(),
                                    //               firstDate: DateTime(
                                    //                   1900), //DateTime.now() - not to allow to choose before today.
                                    //               lastDate: DateTime(2101));
                                    //       if (pickedDate != null) {
                                    //         print(
                                    //             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    //         String formattedDate =
                                    //             DateFormat('yyyy-MM-dd')
                                    //                 .format(pickedDate);
                                    //         print(formattedDate);
                                    //         controller.checkInTE.text =
                                    //             formattedDate;
                                    //         log('Checkin:${controller.checkInTE.text}');
                                    //       } else {
                                    //         log("checkIn is not selected");
                                    //       }
                                    //     },
                                    //     style: FxTextStyle.bodyLarge(
                                    //         fontWeight: 600),
                                    //     decoration: InputDecoration(
                                    //         floatingLabelBehavior:
                                    //             FloatingLabelBehavior.never,
                                    //         filled: true,
                                    //         isDense: true,
                                    //         fillColor: Colors.transparent,
                                    //         // fillColor: theme.cardTheme.color,
                                    //         hintText: "25 Mar",
                                    //         enabledBorder: InputBorder.none,
                                    //         focusedBorder: InputBorder.none,
                                    //         border: InputBorder.none,
                                    //         // enabledBorder: outlineInputBorder,
                                    //         // focusedBorder: outlineInputBorder,
                                    //         // border: outlineInputBorder,
                                    //         // contentPadding: FxSpacing.all(16),
                                    //         contentPadding:
                                    //             FxSpacing.only(left: 16),
                                    //         hintStyle: FxTextStyle.bodyLarge(
                                    //             fontWeight: 600),
                                    //         isCollapsed: true),
                                    //     maxLines: 1,
                                    //     controller: controller.checkInTE,
                                    //     validator: controller.validateCheckIn,
                                    //     cursorColor:
                                    //         theme.colorScheme.onBackground,
                                    //   ),
                                    // ),

                                    controller.selectedValue == null
                                        ? FxText.bodyLarge(formattedYear,
                                            fontWeight: 600)
                                        : FxText.bodyLarge(formattedYeardate,
                                            fontWeight: 600)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => checkOutPicker(context),
                            child: Container(
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FxText.bodySmall("Check out",
                                        fontWeight: 500),
                                    // FxText.bodyLarge("31 May", fontWeight: 600),
                                    controller.selectedCheckOut == null
                                        ? FxText.bodyLarge(CurrentTimeCheckout,
                                            fontWeight: 600)
                                        : FxText.bodyLarge(SlecteddateCheckout,
                                            fontWeight: 600)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              var data = await showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext buildContext) {
                                    return const PersonSeat();
                                  });
                              setState(() {});
                            },
                            child: Container(
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FxText.bodySmall(
                                        // "Person",
                                        "Room",
                                        fontWeight: 500),
                                    FxText.bodyLarge(
                                        // "2 Couple",
                                        '1 Room',
                                        // controller1.roomsList.length.toString(),
                                        // '4 Adults,2 Children',
                                        fontWeight: 600),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FxButton.block(
                    elevation: 0,
                    borderRadiusAll: 4,
                    onPressed: () {
                      // controller.register();
                      Navigator.of(context, rootNavigator: true).push(
                          PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                              transitionsBuilder: (
                                BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child,
                              ) =>
                                  FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                              pageBuilder: (_, __, ___) => const SearchHotel()
                              // const HotelSplash()
                              ));
                    },
                    splashColor: theme.colorScheme.onPrimary.withAlpha(30),
                    backgroundColor: const Color(0xff1529e8),
                    // backgroundColor: theme.colorScheme.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FxText.labelLarge(
                          "Search Hotels",
                          fontWeight: 600,
                          color: theme.colorScheme.onPrimary,
                          letterSpacing: 0.4,
                        ),
                        FxSpacing.width(8),
                        Icon(
                          FeatherIcons.search,
                          color: theme.colorScheme.onPrimary,
                          size: 20,
                        ),
                        // SlideTransition(
                        //   position: controller.arrowAnimation,
                        //   child: Icon(
                        //     FeatherIcons.arrowRight,
                        //     color: theme.colorScheme.onPrimary,
                        //     size: 20,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
