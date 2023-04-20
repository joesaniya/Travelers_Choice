import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../theme/app_theme.dart';
import '../controller/hotel_search_controller.dart';
import 'hotel_splash.dart';

class HotelSearch extends StatefulWidget {
  const HotelSearch({super.key});

  @override
  State<HotelSearch> createState() => _HotelSearchState();
}

class _HotelSearchState extends State<HotelSearch>
    with TickerProviderStateMixin {
  late HotelSearchController controller;
  // late AnimationController controller;
  // Animation<Offset>? offset;
  late ThemeData theme, theme1;

  @override
  void initState() {
    super.initState();

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
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
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

  @override
  Widget build(BuildContext context) {
    // DateTime newdate = DateTime.now();
    //  String formattedYear = DateFormat('EEEE, yyyy').format(newdate);
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
                        child: TextFormField(
                          style: FxTextStyle.titleSmall(
                            fontWeight: 500,
                          ),
                          decoration: InputDecoration(
                            hintStyle: FxTextStyle.titleSmall(fontWeight: 500),
                            hintText: "Hotels near me",
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            prefixIcon: Icon(
                              MdiIcons.magnify,
                              size: 22,
                              color: theme.colorScheme.onBackground,
                            ),
                            isDense: true,
                            contentPadding: const EdgeInsets.only(top: 14),
                          ),
                          autofocus: false,
                          textInputAction: TextInputAction.search,
                          textCapitalization: TextCapitalization.sentences,
                          controller: TextEditingController(text: ""),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 16, left: 16),
                        child: InkWell(
                          onTap: () {
                            _pickDate(context);
                          },
                          child: Icon(
                            MdiIcons.calendarOutline,
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

                                  GestureDetector(
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(
                                                  1900), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(2101));
                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                        print(formattedDate);
                                        controller.selectedValue =
                                            formattedDate as DateTime;
                                        log('Checkin:${controller.selectedValue}');
                                      } else {
                                        log("checkIn is not selected");
                                      }
                                    },
                                    child: controller.selectedValue == null
                                        ? FxText.bodyLarge("28 May",
                                            fontWeight: 600)
                                        : FxText.bodyLarge(
                                            controller.selectedValue.toString(),
                                            fontWeight: 600),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  FxText.bodySmall("Check out",
                                      fontWeight: 500),
                                  FxText.bodyLarge("31 May", fontWeight: 600),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  FxText.bodySmall("Person", fontWeight: 500),
                                  FxText.bodyLarge("2 Couple", fontWeight: 600),
                                ],
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
                              pageBuilder: (_, __, ___) =>
                                  const HotelSplash()));
                    },
                    splashColor: theme.colorScheme.onPrimary.withAlpha(30),
                    backgroundColor: const Color(0xff1529e8),
                    // backgroundColor: theme.colorScheme.primary,
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
