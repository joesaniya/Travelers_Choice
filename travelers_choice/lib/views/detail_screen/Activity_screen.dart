import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/extensions/extensions.dart';
import 'package:intl/intl.dart';

import '../../controllers/Activity_controller.dart';
import '../../controllers/checkout_controller.dart';
import '../../loading_effect.dart';
import '../../models/atteraction_model.dart';
import '../../theme/app_theme.dart';
import '../full_app.dart';

class ActivityScreen extends StatefulWidget {
  // final DetailattractionModal Excursions;
  // List<DetailattractionModal> Excursions;
  // final String excursions;
  List<Activity> excursions;
  ActivityScreen(
      // this.Excursions,
      this.excursions,
      {super.key}
      //  {required List<DetailattractionModal> Excursions}
      );

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late ActivityController controller;
  late CheckOutController controller1;
  bool clickedExcursion = true;
  List<TextEditingController> controllerTE = [];
  String? token;
  List<Activity> tempFavouriteList = favouriteListCart.map((e) => e).toList();
  @override
  void initState() {
    super.initState();

    // initializingData();
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(ActivityController(this));
    controller1 = FxControllerStore.put(CheckOutController(this));
    print(controller.person_count);
  }

  // void initializingData() {
  //   SharedPreferences.getInstance().then((sharedPrefValue) {
  //     setState(() {
  //       token = sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN)!;
  //       log('Profile Toen:${token!}');
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<ActivityController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildSelect1() {
    if (controller.selectedtour.isNotEmpty) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey.shade300, width: 1)),
          child: Column(
            children: [
              Column(
                  children: controller.selectedtour.map((Activity tour) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(tour.name.toString())),
                    FxSpacing.width(20),
                    Text(tour.grandTotal.toString()),
                  ],
                );
              }).toList()),
              FxSpacing.height(20),
              FxDashedDivider(
                dashSpace: 4,
                dashWidth: 8,
                color: theme.colorScheme.onBackground.withAlpha(180),
                height: 1.2,
              ),
              FxSpacing.height(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FxText.bodyLarge(
                    'Total Amount',
                    fontWeight: 700,
                    color: const Color(0xff1529e8),
                  ),
                  FxText.bodyLarge(
                    // controller.selectedtour.first.GrandTotalAmount.toString(),
                    controller.grandSelectedTourAmount().toString(),
                    fontWeight: 700,
                    color: const Color(0xff1529e8),
                  ),
                ],
              )
            ],
          ));
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.grey.shade300, width: 1)),
        child: Center(
          child: FxText.bodyMedium(
            'No Tour Option Selected!!',
            muted: true,
            fontWeight: 700,
          ),
        ),
      );
    }
  }

  Widget _buildSelect() {
    if (controller.selectedtour == null) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey.shade300, width: 1)),
          child: Column(
            children: [
              Column(
                  children: controller.selectedtour.map((Activity tour) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(tour.name.toString())),
                    FxSpacing.width(20),
                    Text(tour.grandTotal.toString()),
                  ],
                );
              }).toList()),
              FxSpacing.height(20),
              FxDashedDivider(
                dashSpace: 4,
                dashWidth: 8,
                color: theme.colorScheme.onBackground.withAlpha(180),
                height: 1.2,
              ),
              FxSpacing.height(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FxText.bodyLarge(
                    'Total Amount',
                    fontWeight: 700,
                    color: const Color(0xff1529e8),
                  ),
                  FxText.bodyLarge(
                    // controller.selectedtour.first.GrandTotalAmount.toString(),
                    controller.grandSelectedTourAmount().toString(),
                    fontWeight: 700,
                    color: const Color(0xff1529e8),
                  ),
                ],
              )
            ],
          ));
    } else {
      if (controller.selectedtour.isEmpty) {
        return const Scaffold(body: Center(child: Text("No Data found")));
      } else {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey.shade300, width: 1)),
          child: Center(
            child: FxText.bodyMedium(
              'No Tour Option Selected!!',
              muted: true,
              fontWeight: 700,
            ),
          ),
        );
      }
    }
  }

  int? selectedIndex;

  Widget _buildCartList() {
    List<Widget> list = [];
    log('message');
    log(widget.excursions.length.toString());

    // for (Cart cart in controller.carts!)
    // for (var cart in widget.excursions)

    for (var i = 0; i < widget.excursions.length; i++) {
      List<TextEditingController> controllers = List.generate(
        widget.excursions.length,
        (index) => TextEditingController(),
      );
      controllerTE.add(TextEditingController());
      // if (i >= controllerTE.length) {
      //   controllerTE.add(TextEditingController());
      // }

      // controller.selectedtour[i].selectedDate = controllerTE[i].text;

      print(
          'Selected Tour Date:${controller.selectedtour.map((e) => e.selectedDate)}');

      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FxSpacing.height(20),
            // Row(
            //   children: [
            //     Expanded(child: Container()),
            //     GestureDetector(
            //       onTap: () {
            //         clickedExcursion = !clickedExcursion;

            //         setState(() {});
            //         if (controllerTE[i].text.isEmpty) {
            //           ScaffoldMessenger.of(context).showSnackBar(
            //               const SnackBar(content: Text("Select Your Date")));
            //         } else {
            //           controller.updateTours(widget.excursions[i]);
            //           log('Count:${widget.excursions[i].adultCount}${widget.excursions[i].childCount}${widget.excursions[i].infantCount}');

            //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //               content: !clickedExcursion
            //                   ? const Text("Added this Excursion!!")
            //                   : const Text("Removed this Excursion!!")));
            //         }

            //         // Navigator.pop(context);
            //       },
            //       child: AnimatedContainer(
            //         // height: 40 ?? 28,
            //         // width: 40 ?? 28,
            //         height: 20,
            //         width: 20,
            //         duration: const Duration(milliseconds: 500),
            //         curve: Curves.fastLinearToSlowEaseIn,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(2.0),
            //             color: controller.selectedtour
            //                     .contains(widget.excursions[i])
            //                 ? Colors.indigo
            //                 : Colors.white,
            //             border: Border.all(
            //               color: controller.selectedtour
            //                       .contains(widget.excursions[i])
            //                   ? Colors.transparent
            //                   : Colors.black,
            //             )),
            //         child:
            //             !controller.selectedtour.contains(widget.excursions[i])
            //                 ? null
            //                 : Icon(
            //                     FeatherIcons.check,
            //                     color: Colors.white.withAlpha(200),
            //                     size: 20,
            //                   ),
            //       ),
            //     ),

            //     //todo
            //     // Checkbox(
            //     //   checkColor: Colors.white,
            //     //   value: controller.selectedtour.contains(widget.excursions[i]),
            //     //   onChanged: (bool? value) {
            //     //     setState(() {
            //     //       clickedExcursion = value!;
            //     //     });
            //     //     if (controllerTE[i].text.isEmpty) {
            //     //       ScaffoldMessenger.of(context).showSnackBar(
            //     //           const SnackBar(content: Text("Select Your Date")));
            //     //     } else {
            //     //       controller.updateTours(widget.excursions[i]);
            //     //       log('Count:${widget.excursions[i].adultCount}${widget.excursions[i].childCount}${widget.excursions[i].infantCount}');

            //     //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     //           content: !clickedExcursion
            //     //               ? const Text("Added this Excursion!!")
            //     //               : const Text("Removed this Excursion!!")));
            //     //     }
            //     //   },
            //     // ),

            //     //plus
            //     // InkWell(
            //     //   onTap: () {
            //     //     clickedExcursion = !clickedExcursion;

            //     //     setState(() {});
            //     //     if (controllerTE[i].text.isEmpty) {
            //     //       ScaffoldMessenger.of(context).showSnackBar(
            //     //           const SnackBar(content: Text("Select Your Date")));
            //     //     } else {
            //     //       controller.updateTours(widget.excursions[i]);
            //     //       log('Count:${widget.excursions[i].adultCount}${widget.excursions[i].childCount}${widget.excursions[i].infantCount}');

            //     //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     //           content: !clickedExcursion
            //     //               ? const Text("Added this Excursion!!")
            //     //               : const Text("Removed this Excursion!!")));
            //     //     }

            //     //     // Navigator.pop(context);
            //     //   },
            //     //   child: FxContainer.bordered(
            //     //     paddingAll: 4,
            //     //     color: theme.colorScheme.onPrimary,
            //     //     borderColor: Colors.black,
            //     //     child:
            //     //         !controller.selectedtour.contains(widget.excursions[i])
            //     //             ? Icon(
            //     //                 FeatherIcons.plus,
            //     //                 color: Colors.indigo.withAlpha(200),
            //     //                 size: 12,
            //     //               )
            //     //             : Icon(
            //     //                 FeatherIcons.minus,
            //     //                 color: Colors.red.withAlpha(200),
            //     //                 size: 12,
            //     //               ),
            //     //   ),
            //     // ),
            //   ],
            // ),
            FxSpacing.height(10),
            Card(
              shadowColor: Colors.black,
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              // color: const Color(0xff5c69e0),
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 8,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey.shade300, width: 1)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // FxSpacing.height(10),
                      // FxText.bodyLarge(
                      //   widget.excursions[i].name ?? '',
                      //   muted: true,
                      //   fontWeight: 900,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              clickedExcursion = !clickedExcursion;

                              setState(() {});
                              // controller.updateTours(widget.excursions[i]);
                              // controller1.addCart
                              //     ? controller1.cartController.reverse()
                              //     : controller1.cartController.forward();

                              //todo
                              // if (controllerTE[i].text.isEmpty) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       const SnackBar(
                              //           content: Text("Select Your Date")));
                              // } else {
                              // selectedIndex = i;
                              // controller.selectedtour
                              //         .contains(widget.excursions[i])
                              //     ? selectedIndex = i
                              //     : selectedIndex = null;
                              controller.updateTours(widget.excursions[i]);
                              log('Count:${widget.excursions[i].adultCount}${widget.excursions[i].childCount}${widget.excursions[i].infantCount}');

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: !clickedExcursion
                                          ? const Text("Added this Excursion!!")
                                          : const Text(
                                              "Removed this Excursion!!")));
                              // }

                              // Navigator.pop(context);
                            },
                            child: AnimatedContainer(
                              // height: 40 ?? 28,
                              // width: 40 ?? 28,
                              height: 20,
                              width: 20,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.0),
                                  color: controller.selectedtour
                                          .contains(widget.excursions[i])
                                      ? Colors.indigo
                                      : Colors.white,
                                  border: Border.all(
                                    color: controller.selectedtour
                                            .contains(widget.excursions[i])
                                        ? Colors.transparent
                                        : Colors.black,
                                  )),
                              child: !controller.selectedtour
                                      .contains(widget.excursions[i])
                                  ? null
                                  : Icon(
                                      FeatherIcons.check,
                                      color: Colors.white.withAlpha(200),
                                      size: 20,
                                    ),
                            ),
                          ),
                          FxSpacing.width(30),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FxText.bodyLarge(
                                widget.excursions[i].name ?? '',
                                muted: true,
                                fontWeight: 900,
                              ),
                            ),
                          ),
                        ],
                      ),
                      FxSpacing.height(20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     FxText.bodyMedium(
                      //       'Tour : ',
                      //       fontWeight: 600,
                      //     ),
                      //     FxSpacing.width(30),
                      //     Expanded(
                      //       child: Align(
                      //         alignment: Alignment.centerRight,
                      //         child: FxText.bodyMedium(
                      //           widget.excursions[i].name ?? '',
                      //           fontWeight: 700,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // FxSpacing.height(4),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     FxText.bodyMedium(
                      //       'Transfer',
                      //       fontWeight: 600,
                      //     ),
                      //     // FxText.bodyMedium(
                      //     //   // '\$' + controller.order.precise,
                      //     //   'without',
                      //     //   fontWeight: 700,
                      //     // ),
                      //     Expanded(child: Container()),
                      //     GestureDetector(
                      //       onTap: () {
                      //         log('transfer clicked');
                      //         log(controller.selectedtransfer == 'private'
                      //                 ? widget.excursions[i].privateTransferPrice
                      //                     .toString()
                      //                 : widget.excursions[i].sharedTransferPrice
                      //                     .toString()
                      //             // controller.selectedtransfer=='Without'?0:controller.selectedtransfer=='private'?widget.excursions[i].privateTransferPrice:controller.selectedtransfer=='shared'?widget.excursions[i].sharedTransferPrice:0
                      //             // widget.excursions[i].privateTransferPrice.toString()
                      //             );
                      //         setState(() {});
                      //       },
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //             color: theme.cardTheme.color,
                      //             // color: const Color(0xff1529e8),
                      //             borderRadius: BorderRadius.circular(8)),
                      //         height: 50,
                      //         width: 150,
                      //         child: DropdownButtonHideUnderline(
                      //           child: DropdownButton2(
                      //             isExpanded: true,
                      //             hint: Row(
                      //               children: [
                      //                 Expanded(
                      //                   child: FxText.labelLarge(
                      //                     // "Code",
                      //                     controller.TransferCodes[0],
                      //                     // controller.selectedtransfer![0],
                      //                     fontWeight: 600,
                      //                     color: Colors.black,
                      //                     // color: theme.colorScheme.onPrimary,
                      //                     letterSpacing: 0.4,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             value: widget.excursions[i].isSharing
                      //                 ? controller.TransferCodes[2]
                      //                 : widget.excursions[i].isPrivate
                      //                     ? controller.TransferCodes[1]
                      //                     : controller.TransferCodes[0],

                      //             // items: widget.excursions.first
                      //             //             .isSharedTransferAvailable ==
                      //             //         false
                      //             //     ? controller.SharedwithoutCodes.map(
                      //             //         (String value) {
                      //             //         return DropdownMenuItem<String>(
                      //             //             value: value,
                      //             //             child: Center(
                      //             //               child: Text(
                      //             //                 value,
                      //             //                 style: FxTextStyle.bodyMedium(),
                      //             //               ),
                      //             //             ));
                      //             //       }).toList()
                      //             //     : widget.excursions.first
                      //             //                 .isPrivateTransferAvailable ==
                      //             //             false
                      //             //         ? controller.withoutPrivateCodes
                      //             //             .map((String value) {
                      //             //             return DropdownMenuItem<String>(
                      //             //                 value: value,
                      //             //                 child: Center(
                      //             //                   child: Text(
                      //             //                     value,
                      //             //                     style: FxTextStyle
                      //             //                         .bodyMedium(),
                      //             //                   ),
                      //             //                 ));
                      //             //           }).toList()
                      //             //         : widget.excursions.first
                      //             //                         .isPrivateTransferAvailable ==
                      //             //                     false ||
                      //             //                 widget.excursions.first
                      //             //                         .isSharedTransferAvailable ==
                      //             //                     false
                      //             //             ? controller.withoutcodes
                      //             //                 .map((String value) {
                      //             //                 return DropdownMenuItem<String>(
                      //             //                     value: value,
                      //             //                     child: Center(
                      //             //                       child: Text(
                      //             //                         value,
                      //             //                         style: FxTextStyle
                      //             //                             .bodyMedium(),
                      //             //                       ),
                      //             //                     ));
                      //             //               }).toList()
                      //             //             : controller.TransferCodes.map(
                      //             //                 (String value) {
                      //             //                 return DropdownMenuItem<String>(
                      //             //                     value: value,
                      //             //                     child: Center(
                      //             //                       child: Text(
                      //             //                         value,
                      //             //                         style: FxTextStyle
                      //             //                             .bodyMedium(),
                      //             //                       ),
                      //             //                     ));
                      //             //               }).toList(),

                      //             items: controller.TransferCodes.map(
                      //                 (String value) {
                      //               return DropdownMenuItem<String>(
                      //                   value: value,
                      //                   child: Center(
                      //                     child: Text(
                      //                       value,
                      //                       style: FxTextStyle.bodyMedium(),
                      //                     ),
                      //                   ));
                      //             }).toList(),
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 controller.selectedtransfer =
                      //                     value.toString();
                      //               });
                      //               controller.addisPrivateORsharing(
                      //                   widget.excursions[i],
                      //                   isPrivate: controller.selectedtransfer ==
                      //                       controller.TransferCodes[1],
                      //                   isSharing: controller.selectedtransfer ==
                      //                       controller.TransferCodes[2]);
                      //             },

                      //             icon: const Icon(Icons.arrow_drop_down),
                      //             iconSize: 20,
                      //             iconEnabledColor: Colors.black,
                      //             iconDisabledColor: Colors.black,
                      //             buttonHeight: 30,
                      //             buttonWidth: 200,
                      //             buttonPadding: const EdgeInsets.only(
                      //                 left: 14, right: 14, top: 4, bottom: 4),
                      //             dropdownDecoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(4),
                      //               color: Colors.white,
                      //             ),
                      //             buttonDecoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(10),
                      //               // border: Border.all(
                      //               //     color: AppColor
                      //               //         .Secondary1,
                      //               //     width: 1),
                      //               // color: const Color(0xff2C2138),
                      //               color: theme.cardTheme.color,
                      //             ),

                      //             itemHeight: 40,

                      //             itemPadding:
                      //                 const EdgeInsets.only(left: 14, right: 14),
                      //             dropdownMaxHeight: 200,
                      //             dropdownPadding: null,

                      //             scrollbarRadius: const Radius.circular(40),
                      //             scrollbarThickness: 2,
                      //             scrollbarAlwaysShow: true,
                      //             offset: const Offset(0, 0),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      //ttransfer
                      // controller1.addCart
                      //     ?
                      !controller.selectedtour.contains(widget.excursions[i])
                          ? const SizedBox()
                          : Column(
                              children: [
                                // selectedIndex == i
                                //     ? const SizedBox()
                                //     : const Text('data'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        log('transfer clicked');
                                        log(controller.selectedtransfer ==
                                                'private'
                                            ? widget.excursions[i]
                                                .privateTransferPrice
                                                .toString()
                                            : widget.excursions[i]
                                                .sharedTransferPrice
                                                .toString());
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: theme.cardTheme.color,
                                            // color: const Color(0xff1529e8),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        height: 50,
                                        width: 150,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            isExpanded: true,
                                            hint: Row(
                                              children: [
                                                Expanded(
                                                    child:
                                                        // controller.TransferCodes[0] ==
                                                        //         'without'
                                                        //     ? FxText.labelLarge(
                                                        //         // "Code",
                                                        //         // "Without Transfer",
                                                        //         controller
                                                        //             .TransferCodes[0],
                                                        //         // controller.selectedtransfer![0],
                                                        //         fontWeight: 600,
                                                        //         color: Colors.black,
                                                        //         // color: theme.colorScheme.onPrimary,
                                                        //         letterSpacing: 0.4,
                                                        //       )
                                                        //     :
                                                        FxText.labelLarge(
                                                  // "Code",
                                                  // "Without Transfer",
                                                  controller.TransferCodes[0],
                                                  // controller.selectedtransfer![0],
                                                  fontWeight: 600,
                                                  color: Colors.black,
                                                  // color: theme.colorScheme.onPrimary,
                                                  letterSpacing: 0.4,
                                                )),
                                              ],
                                            ),
                                            value: widget
                                                    .excursions[i].isSharing
                                                ? controller.TransferCodes[2]
                                                : widget.excursions[i].isPrivate
                                                    ? controller
                                                        .TransferCodes[1]
                                                    : controller
                                                        .TransferCodes[0],
                                            items: controller.TransferCodes.map(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Center(
                                                    child: Text(
                                                      value,
                                                      style: FxTextStyle
                                                          .bodyMedium(),
                                                    ),
                                                  ));
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                controller.selectedtransfer =
                                                    value.toString();
                                              });
                                              controller.addisPrivateORsharing(
                                                  widget.excursions[i],
                                                  isPrivate: controller
                                                          .selectedtransfer ==
                                                      controller
                                                          .TransferCodes[1],
                                                  isSharing: controller
                                                          .selectedtransfer ==
                                                      controller
                                                          .TransferCodes[2]);
                                            },
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            iconSize: 20,
                                            iconEnabledColor: Colors.black,
                                            iconDisabledColor: Colors.black,
                                            buttonHeight: 30,
                                            buttonWidth: 200,
                                            buttonPadding:
                                                const EdgeInsets.only(
                                                    left: 14,
                                                    right: 14,
                                                    top: 4,
                                                    bottom: 4),
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Colors.white,
                                            ),
                                            buttonDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: theme.cardTheme.color,
                                            ),
                                            itemHeight: 40,
                                            itemPadding: const EdgeInsets.only(
                                                left: 14, right: 14),
                                            dropdownMaxHeight: 200,
                                            dropdownPadding: null,
                                            scrollbarRadius:
                                                const Radius.circular(40),
                                            scrollbarThickness: 2,
                                            scrollbarAlwaysShow: true,
                                            offset: const Offset(0, 0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: theme.cardTheme.color,
                                          // color: const Color(0xff1529e8),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      height: 50,
                                      width: 150,
                                      child: TextFormField(
                                        style: FxTextStyle.bodyMedium(),
                                        // controller: controller.dateTE,
                                        // controller: controllers[i],
                                        controller: controllerTE[i],
                                        readOnly:
                                            true, //set it true, so that user will not able to edit text

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
                                            // dateTE.text = formattedDate;
                                            controllerTE[i].text =
                                                formattedDate;
                                            widget.excursions[i].selectedDate =
                                                formattedDate;

                                            // setState(() {
                                            //   dateinput.text = formattedDate; //set output date to TextField value.
                                            // });
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                        decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            filled: true,
                                            isDense: true,
                                            fillColor: theme.cardTheme.color,
                                            // suffixIcon: Icon(
                                            //   FeatherIcons.calendar,
                                            //   color: theme.colorScheme.onBackground,
                                            // ),
                                            hintText: "yyyy-mm-dd",
                                            border: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            // enabledBorder: outlineInputBorder,
                                            // focusedBorder: outlineInputBorder,
                                            // border: outlineInputBorder,
                                            contentPadding: FxSpacing.all(16),
                                            hintStyle: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              letterSpacing: 0.4,
                                            ),
                                            // hintStyle: FxTextStyle.bodyMedium(),
                                            isCollapsed: true),
                                        autofocus: false,
                                        keyboardType: TextInputType.datetime,
                                      ),
                                    ),
                                  ],
                                ),
                                FxSpacing.height(4),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     FxText.bodyMedium(
                                //       'Date',
                                //       fontWeight: 600,
                                //     ),
                                //     FxSpacing.width(50),
                                //     Container(
                                //       decoration: BoxDecoration(
                                //           color: theme.cardTheme.color,
                                //           // color: const Color(0xff1529e8),
                                //           borderRadius: BorderRadius.circular(8)),
                                //       height: 50,
                                //       width: 150,
                                //       child: TextFormField(
                                //         style: FxTextStyle.bodyMedium(),
                                //         // controller: controller.dateTE,
                                //         // controller: controllers[i],
                                //         controller: controllerTE[i],
                                //         readOnly:
                                //             true, //set it true, so that user will not able to edit text

                                //         onTap: () async {
                                //           DateTime? pickedDate = await showDatePicker(
                                //               context: context,
                                //               initialDate: DateTime.now(),
                                //               firstDate: DateTime(
                                //                   1900), //DateTime.now() - not to allow to choose before today.
                                //               lastDate: DateTime(2101));

                                //           if (pickedDate != null) {
                                //             print(
                                //                 pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                //             String formattedDate =
                                //                 DateFormat('yyyy-MM-dd').format(pickedDate);
                                //             print(formattedDate);
                                //             // dateTE.text = formattedDate;
                                //             controllerTE[i].text = formattedDate;
                                //             widget.excursions[i].selectedDate =
                                //                 formattedDate;

                                //             // setState(() {
                                //             //   dateinput.text = formattedDate; //set output date to TextField value.
                                //             // });
                                //           } else {
                                //             print("Date is not selected");
                                //           }
                                //         },
                                //         decoration: InputDecoration(
                                //             floatingLabelBehavior:
                                //                 FloatingLabelBehavior.never,
                                //             filled: true,
                                //             isDense: true,
                                //             fillColor: theme.cardTheme.color,
                                //             // suffixIcon: Icon(
                                //             //   FeatherIcons.calendar,
                                //             //   color: theme.colorScheme.onBackground,
                                //             // ),
                                //             hintText: "yyyy-mm-dd",
                                //             border: InputBorder.none,
                                //             enabledBorder: InputBorder.none,
                                //             focusedBorder: InputBorder.none,
                                //             // enabledBorder: outlineInputBorder,
                                //             // focusedBorder: outlineInputBorder,
                                //             // border: outlineInputBorder,
                                //             contentPadding: FxSpacing.all(16),
                                //             hintStyle: const TextStyle(
                                //               fontWeight: FontWeight.w600,
                                //               color: Colors.black,
                                //               letterSpacing: 0.4,
                                //             ),
                                //             // hintStyle: FxTextStyle.bodyMedium(),
                                //             isCollapsed: true),
                                //         autofocus: false,
                                //         keyboardType: TextInputType.datetime,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // FxSpacing.height(4),
                                personCount(controller, widget.excursions[i],
                                    setState, theme,
                                    isAdult: true),
                                //child
                                FxSpacing.height(4),

                                personCount(controller, widget.excursions[i],
                                    setState, theme,
                                    isChild: true),
                                FxSpacing.height(4),

                                //infant

                                personCount(controller, widget.excursions[i],
                                    setState, theme,
                                    isInfant: true),
                                if (widget.excursions[i].isPrivate)
                                  FxSpacing.height(4),
                                if (widget.excursions[i].isPrivate)
                                  cost(widget.excursions[i], isPrivate: true),
                                if (widget.excursions[i].isSharing)
                                  FxSpacing.height(4),
                                if (widget.excursions[i].isSharing)
                                  cost(widget.excursions[i],
                                      isSharing: true), //aount
                                FxSpacing.height(4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FxText.bodyMedium(
                                      'Amount',
                                      fontWeight: 600,
                                    ),
                                    FxText.bodyMedium(
                                      controller
                                          .getTotal(widget.excursions[i])
                                          .toString(),
                                      // 'IMG Worlds of Adventure',
                                      fontWeight: 700,
                                    ),
                                  ],
                                ),
                                // if (cart.isPrivate) FxSpacing.height(4),
                                // if (cart.isPrivate) cost(cart, isPrivate: true),
                                // if (cart.isSharing) FxSpacing.height(4),
                                // if (cart.isSharing) cost(cart, isSharing: true),

                                FxSpacing.height(4),

                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     FxText.bodyMedium(
                                //       'Tax',
                                //       fontWeight: 600,
                                //     ),
                                //     FxText.bodyMedium(
                                //       // '\$' + controller.tax.precise,
                                //       '\$ 33',
                                //       fontWeight: 700,
                                //     ),
                                //   ],
                                // ),
                                // FxSpacing.height(4),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     FxText.bodyMedium(
                                //       'Offer',
                                //       fontWeight: 600,
                                //     ),
                                //     FxText.bodyMedium(
                                //       // '- \$' + controller.offer.precise,
                                //       '- \$ 50',
                                //       fontWeight: 700,
                                //     ),
                                //   ],
                                // ),
                                FxSpacing.height(12),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(),
                                    ),
                                    Expanded(
                                      child: FxDashedDivider(
                                        dashSpace: 4,
                                        dashWidth: 8,
                                        color: theme.colorScheme.onBackground
                                            .withAlpha(180),
                                        height: 1.2,
                                      ),
                                    )
                                  ],
                                ),
                                FxSpacing.height(12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FxText.bodyMedium(
                                      'Grand Total',
                                      fontWeight: 700,
                                      color: const Color(0xff1529e8),
                                    ),
                                    FxText.bodyMedium(
                                      // '\$' + controller.total.precise,
                                      controller
                                          .getGrandTotal(widget.excursions[i])
                                          .toString(),
                                      // controller.products.
                                      fontWeight: 800,
                                      color: const Color(0xff1529e8),
                                    ),
                                  ],
                                ),
                              ],
                            )
                      // : const SizedBox()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ));
    }
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      // padding: FxSpacing.nTop(20),
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 140),
      children: list,
    );
  }

  Widget _billingWidget() {
    log('billing Widget');
    // bool increaseAble = controller.increaseAble(controller.product);
    // bool decreaseAble = controller.decreaseAble(controller.product);
    return FadeTransition(
      opacity: controller.cartAnimation,
      // opacity: controller.fadeAnimation,
      child: FxContainer(
        borderRadiusAll: 4,
        // color: Colors.red,
        color: Colors.white,
        // color: Color(0xffe5fdfd),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxText.bodyMedium(
              'Tour Options',
              muted: true,
              fontWeight: 700,
            ),
            FxSpacing.height(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Tour',
                  fontWeight: 600,
                ),
                FxText.bodyMedium(
                  'Ferrari',
                  fontWeight: 700,
                ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Transfer',
                  fontWeight: 600,
                ),
                // FxText.bodyMedium(
                //   // '\$' + controller.order.precise,
                //   'without',
                //   fontWeight: 700,
                // ),
                // Expanded(child: Container()),
                Container(
                  height: 45,
                  width: 400,
                  decoration: BoxDecoration(
                      // color: theme.cardTheme.color,
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4)),
                ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Date',
                  fontWeight: 600,
                ),
                Expanded(child: Container()),
                Expanded(
                  child: SlideTransition(
                    position: controller.dateAnimation,
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        style: FxTextStyle.bodyMedium(),
                        controller: controller.dateTE,
                        readOnly:
                            true, //set it true, so that user will not able to edit text

                        // onTap: controller.dateselect(i),
                        onTap: () {},
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            isDense: true,
                            fillColor: theme.cardTheme.color,
                            suffixIcon: Icon(
                              FeatherIcons.calendar,
                              color: theme.colorScheme.onBackground,
                            ),
                            hintText: "yyyy-mm-dd",
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            // enabledBorder: outlineInputBorder,
                            // focusedBorder: outlineInputBorder,
                            // border: outlineInputBorder,
                            contentPadding: FxSpacing.all(16),
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: 0.4,
                            ),
                            // hintStyle: FxTextStyle.bodyMedium(),
                            isCollapsed: true),
                        autofocus: false,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ),
                ),
                // FxText.bodyMedium(
                //   // '\$' + controller.order.precise,
                //   '2023-01-31',
                //   fontWeight: 700,
                // ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Adult',
                  fontWeight: 600,
                ),
                Expanded(child: Container()),
              ],
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Amount',
                  fontWeight: 600,
                ),
                FxText.bodyMedium(
                  '345.00 AED',
                  // 'IMG Worlds of Adventure',
                  fontWeight: 700,
                ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Tax',
                  fontWeight: 600,
                ),
                FxText.bodyMedium(
                  // '\$' + controller.tax.precise,
                  '\$ 33',
                  fontWeight: 700,
                ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Offer',
                  fontWeight: 600,
                ),
                FxText.bodyMedium(
                  // '- \$' + controller.offer.precise,
                  '- \$ 50',
                  fontWeight: 700,
                ),
              ],
            ),
            FxSpacing.height(12),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  child: FxDashedDivider(
                    dashSpace: 4,
                    dashWidth: 8,
                    color: theme.colorScheme.onBackground.withAlpha(180),
                    height: 1.2,
                  ),
                )
              ],
            ),
            FxSpacing.height(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Grand Total',
                  fontWeight: 700,
                  color: const Color(0xff1529e8),
                ),
                FxText.bodyMedium(
                  // '\$' + controller.total.precise,
                  '345.00 AED',
                  // controller.products.
                  fontWeight: 800,
                  color: const Color(0xff1529e8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
      return Scaffold(
        body: Container(
            padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
            child: LoadingEffect.getCartLoadingScreen(
              context,
            )),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              controller.goBack();
            },
            child: Icon(
              FeatherIcons.chevronLeft,
              size: 20,
              color: theme.colorScheme.onBackground,
            ).autoDirection(),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: FxText.titleMedium(
            'Tour Options',
            fontWeight: 700,
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xfff5f5f5),
        body: Stack(
          children: [
            _buildCartList(),
            // FxSpacing.height(20),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: FxSpacing.xy(12, 8),
                child: PhysicalModel(
                  color: theme.cardTheme.color!.withAlpha(200),
                  elevation: 12,
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                  shadowColor: theme.colorScheme.onBackground.withAlpha(12),
                  shape: BoxShape.rectangle,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.cardTheme.color!.withAlpha(200),
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                    ),
                    padding: FxSpacing.xy(16, 12),
                    child: Column(
                      children: <Widget>[
                        _buildSelect1(),
                        FadeTransition(
                          opacity: controller.fadeAnimation,
                          child: FxButton.block(
                              onPressed: () {
                                // token == null
                                //     ? controller.Login()
                                //     :
                                controller.goToCheckout();
                                // favouriteListCart
                                //     .add(controller.selectedtour as Activity);
                              },
                              backgroundColor: const Color(0xff1529e8),
                              // backgroundColor: theme.colorScheme.primary,
                              elevation: 0,
                              borderRadiusAll: 4,
                              child: Row(
                                children: [
                                  SlideTransition(
                                    position: controller.animation,
                                    child: Image(
                                      height: 22,
                                      width: 22,
                                      color: theme.colorScheme.onPrimary,
                                      image: const AssetImage(
                                          'assets/images/apps/shopping2/icons/clear_cart_outline.png'),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: FxText.bodyMedium(
                                        'Checkout',
                                        fontWeight: 600,
                                        color: theme.colorScheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),

        //todo
        // body: ListView(
        //   padding: FxSpacing.nTop(20),
        //   children: [
        //     //todo
        //     // _billingWidget(),
        //     _buildCartList(),
        //     FxSpacing.height(20),
        //     _buildSelect1(),
        //     FadeTransition(
        //       opacity: controller.fadeAnimation,
        //       child: FxButton.block(
        //           onPressed: () {
        //             controller.goToCheckout();
        //           },
        //           backgroundColor: const Color(0xff1529e8),
        //           // backgroundColor: theme.colorScheme.primary,
        //           elevation: 0,
        //           borderRadiusAll: 4,
        //           child: Row(
        //             children: [
        //               SlideTransition(
        //                 position: controller.animation,
        //                 child: Image(
        //                   height: 22,
        //                   width: 22,
        //                   color: theme.colorScheme.onPrimary,
        //                   image: const AssetImage(
        //                       'assets/images/apps/shopping2/icons/clear_cart_outline.png'),
        //                 ),
        //               ),
        //               Expanded(
        //                 child: Center(
        //                   child: FxText.bodyMedium(
        //                     'Checkout',
        //                     fontWeight: 600,
        //                     color: theme.colorScheme.onPrimary,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           )),
        //     ),
        //     FxSpacing.height(80),
        //   ],
        // ),
      );
    }
  }
}

Widget personCount(controller, cart, setState, theme,
    {isAdult = false, isChild = false, isInfant = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      FxText.bodyMedium(
        isAdult
            ? 'Adult'
            : isChild
                ? "Child"
                : "Infant",
        fontWeight: 600,
      ),
      // FxText.bodyMedium(
      //   // '\$' + controller.order.precise,
      //   '1 adult',
      //   fontWeight: 700,
      // ),
      Expanded(child: Container()),
      Row(
        children: [
          FxContainer(
            onTap: () async {
              controller.personCountFn(cart,
                  isIncrement: true,
                  isChild: isChild,
                  isAdult: isAdult,
                  isInfant: isInfant);
              setState(() {});
            },
            bordered: isDefault(controller, cart,
                isAdult: isAdult,
                isChild: isChild,
                isInfant: isInfant,
                isIncrement: true),
            //  controller.increaseAble(cart),
            paddingAll: 4,
            borderRadiusAll: 2,
            border: Border.all(color: const Color(0xff1529e8)),
            color: isDefault(controller, cart,
                    isAdult: isAdult,
                    isChild: isChild,
                    isInfant: isInfant,
                    isIncrement: true)
                ? const Color(0xff1529e8)
                : theme.colorScheme.onBackground.withAlpha(200),
            child: Icon(
              FeatherIcons.plus,
              size: 12,
              color: isDefault(controller, cart,
                      isAdult: isAdult,
                      isChild: isChild,
                      isInfant: isInfant,
                      isIncrement: true)
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onPrimary,
            ),
          ),
          FxSpacing.width(15),
          FxSpacing.height(8),
          FxText.bodyMedium(
            controller
                .getCounts(cart.sId,
                    isAdult: isAdult, isChild: isChild, isInfant: isInfant)
                .toString(),
            fontWeight: 700,
          ),
          FxSpacing.height(8),
          FxSpacing.width(15),
          FxContainer(
            onTap: () async {
              controller.personCountFn(cart,
                  isAdult: isAdult, isChild: isChild, isInfant: isInfant);
              setState(() {});
            },
            paddingAll: 4,
            borderRadiusAll: 2,
            bordered: isDefault(controller, cart,
                isAdult: isAdult, isChild: isChild, isInfant: isInfant),
            //  controller.decreaseAble(cart),
            border: Border.all(color: const Color(0xff1529e8).withAlpha(120)),
            color: isDefault(controller, cart,
                    isAdult: isAdult, isChild: isChild, isInfant: isInfant)
                ? const Color(0xff1529e8).withAlpha(28)
                : theme.colorScheme.onBackground.withAlpha(200),
            child: Icon(
              FeatherIcons.minus,
              size: 12,
              color: isDefault(controller, cart,
                      isAdult: isAdult, isChild: isChild, isInfant: isInfant)
                  ? const Color(0xff1529e8)
                  // theme.colorScheme.primary
                  : theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    ],
  );
}

bool isDefault(controller, cart,
    {bool isAdult = false,
    bool isChild = false,
    bool isInfant = false,
    isIncrement = false}) {
  int value = controller.getCounts(cart.sId,
      isAdult: isAdult, isChild: isChild, isInfant: isInfant);
  if (isAdult) {
    return isIncrement ? value >= 1 : value != 1;
  } else {
    return isIncrement ? value >= 0 : value != 0;
  }
}

Widget cost(Activity tour, {bool isPrivate = false, bool isSharing = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      FxText.bodyMedium(
        isPrivate ? "Private" : "Sharing",
        fontWeight: 600,
      ),
      FxText.bodyMedium(
        (isPrivate ? tour.privateTransferPrice : tour.sharedTransferPrice)
            .toString(),
        // 'IMG Worlds of Adventure',
        fontWeight: 700,
      ),
    ],
  );
}
