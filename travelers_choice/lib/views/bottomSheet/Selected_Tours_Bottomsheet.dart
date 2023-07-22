import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/Detail_controller.dart';
import '../../controllers/checkout_controller.dart';
import '../../models/atteraction_model.dart';
import '../../services/app_constants.dart';
import '../../theme/app_theme.dart';

class SelectedTourBottomSheet extends StatefulWidget {
  // final String pid;

  // final Datum Datas;
  // final String ProductSlug;
  // String? currencySymbol;
  // double? conversionRate;
  dynamic? len;
  List<Activity> Option;

  String? textdate;
  String? Transfer;
  double? totalAmount;
  // Function Total;
  SelectedTourBottomSheet({
    super.key,
    // required this.pid,
    // required this.Datas,
    // required this.ProductSlug,
    // this.currencySymbol,
    // this.conversionRate,
    this.len,
    required this.Option,
    this.textdate,
    this.Transfer,
    this.totalAmount,
    // required this.Total
  });

  @override
  State<SelectedTourBottomSheet> createState() =>
      _SelectedTourBottomSheetState();
}

class _SelectedTourBottomSheetState extends State<SelectedTourBottomSheet>
    with TickerProviderStateMixin {
  late ThemeData theme, theme1;

  late DetailController controller;
  // late ActivityController activitycontroller;
  late CheckOutController checkoutcontroller;
  List? selectedExcursions;

  @override
  void initState() {
    log('sheet');

    super.initState();
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    initializingData();
    controller = FxControllerStore.put(DetailController(
      this,
      //  widget.productid
    ));

    checkoutcontroller = FxControllerStore.put(CheckOutController(this));

    //  log('Grand Total Function${widget.Total}');

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });

    log('Grand Total${controller.grandSelectedTourAmount()}');
    log('Selected Total Amount:${widget.totalAmount}');
    selectedExcursions = widget.Option;
    // log('Selected Tour length:${widget.selectedtourOption.first.sId}');
    log('Selected Total Amount:${widget.totalAmount}');

    log('Selected Final Amount:${widget.Option.first.grandTotal}');

    // log('Selected Final Amount:${widget.selectedtourOption.first.grandTotal}');
  }

  String? currencySymbol;
  double? conversionRate;

  void initializingData() {
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        conversionRate = sharedPrefValue.getDouble(AppConstants.rate);
        log('conversionRate:$conversionRate');
        currencySymbol = sharedPrefValue.getString(AppConstants.symbol);
        log('currencySymbol:$currencySymbol');
      });
    });
  }

  String getFormattedDate(String date) {
    //selectedslotdate
    // DateTime now = date;

    // String formattedSlotDate = DateFormat.yMMMd().format(now);
    // log('formattedSlotDate:$formattedSlotDate');
    // log('Start Time:${controller.customSlots!.event!.startDateTime}');
    String StartTime = date;

    // String StartTime=date;
    DateTime parsedStartTime = DateTime.parse(StartTime);
    String formattedStartTime = DateFormat('HH:mm:ss').format(parsedStartTime);

    log('formattedTime:$formattedStartTime');

    String originalStartTime = formattedStartTime;

    DateTime parsedTimeStart =
        DateFormat('HH:mm:ss').parseStrict(originalStartTime);
    String formattedStartAMPN = DateFormat('h:mm a').format(parsedTimeStart);

    log('Start:$formattedStartAMPN');
    // log('currentSlot!.length:${currentSlot!.length}');

    return formattedStartAMPN;
  }

  String? rateconversion;
  String? rateselectedtourOption;
  Widget _billingWidget() {
    List<Widget> list = [];
    log('message');

    return SizedBox(
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: widget.Option.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // String? rateconversion;
          // String? rateselectedtourOption;
          log('amount not equal:${widget.totalAmount}');
          if (conversionRate != null) {
            log('ConersionRate:$conversionRate');
            rateconversion =
                ((widget.Option[index].grandTotal * conversionRate!))
                    .toStringAsFixed(2);
            log('Rate:$rateconversion');
            rateselectedtourOption =
                ((widget.Option[index].grandTotal * conversionRate!))
                    .toStringAsFixed(2);
          }
          return FadeTransition(
            opacity: controller.fadeAnimation,
            child: FxContainer(
              // borderRadiusAll: 4,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyMedium(
                          // '\$' + controller.order.precise,
                          widget.Option[index].name.toString(),
                          fontWeight: 900,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        onPressed: () {
                          log('remove clicked');
                          setState(() {
                            // widget.Option.removeAt(index);
                          });
                        },
                        icon: const Icon(
                          Icons.delete,
                          // color: Colors.red,
                          color: Colors.transparent,
                        ),
                      )
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
                      widget.Option[index].transferCode == null ||
                              widget.Option[index].transferCode!.isEmpty
                          ? FxText.bodyMedium(
                              'Without Transfer',
                              fontWeight: 700,
                            )
                          : FxText.bodyMedium(
                              widget.Option[index].transferCode.toString(),
                              fontWeight: 700,
                            ),

                      // widget.Transfer == null
                      //     ? FxText.bodyMedium(
                      //         'Private',
                      //         fontWeight: 700,
                      //       )
                      //     : FxText.bodyMedium(
                      //         widget.Transfer.toString(),
                      //         fontWeight: 700,
                      //       ),
                    ],
                  ),
                  FxSpacing.height(4),
                  // widget.event!.endDateTime == null
                  widget.Option[index].activityTimeSlot == null
                      ? const SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FxText.bodyMedium(
                              'Selected Slot',
                              fontWeight: 600,
                            ),
                            Expanded(child: Container()),
                            Row(
                              children: [
                                FxText.bodyMedium(
                                  // '20 Jul',
                                  getFormattedDate(widget.Option[index]
                                          .activityTimeSlot!.startDateTime
                                          .toString()

                                      // widget.event!.endDateTime.toString()
                                      ),
                                  // "$formattedStartAMPN- $formattedEndAMPN",
                                  color: Colors.black,
                                  fontWeight: 600,
                                ),
                                FxText.bodyMedium(
                                  ' - ',
                                  color: Colors.black,
                                  fontWeight: 600,
                                ),
                                FxText.bodyMedium(
                                  // '20 Jul',
                                  getFormattedDate(widget.Option[index]
                                      .activityTimeSlot!.endDateTime
                                      .toString()),
                                  // "$formattedStartAMPN- $formattedEndAMPN",
                                  color: Colors.black,
                                  fontWeight: 600,
                                ),
                              ],
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
                      FxText.bodyMedium(
                        widget.Option[index].selectedDate.toString(),
                        fontWeight: 700,
                      ),
                    ],
                  ),
                  FxSpacing.height(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.bodyMedium(
                        'Pax',
                        fontWeight: 600,
                      ),
                      Expanded(child: Container()),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FxContainer(
                            padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                            color: const Color(0xff1529e8).withAlpha(40),
                            child: Row(
                              children: [
                                FxText.bodyMedium(
                                    widget.Option[index].adultCount.toString(),
                                    color: const Color(0xff1529e8),
                                    // color: customTheme.groceryPrimary,
                                    fontWeight: 500,
                                    letterSpacing: -0.2),
                                FxSpacing.width(4),
                                FxText.bodyMedium('Adult',
                                    color: const Color(0xff1529e8),
                                    // color: customTheme.groceryPrimary,
                                    fontWeight: 500,
                                    letterSpacing: -0.2),
                              ],
                            ),
                          ),
                          FxSpacing.width(10),
                          FxContainer(
                            padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                            color: const Color(0xff1529e8).withAlpha(40),
                            child: Row(
                              children: [
                                FxText.bodyMedium(
                                    widget.Option[index].childCount.toString(),
                                    color: const Color(0xff1529e8),
                                    // color: customTheme.groceryPrimary,
                                    fontWeight: 500,
                                    letterSpacing: -0.2),
                                FxSpacing.width(4),
                                FxText.bodyMedium('child',
                                    color: const Color(0xff1529e8),
                                    // color: customTheme.groceryPrimary,
                                    fontWeight: 500,
                                    letterSpacing: -0.2),
                              ],
                            ),
                          ),
                          FxSpacing.width(10),
                          FxContainer(
                            padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                            color: const Color(0xff1529e8).withAlpha(40),
                            child: Row(
                              children: [
                                FxText.bodyMedium(
                                    widget.Option[index].infantCount.toString(),
                                    color: const Color(0xff1529e8),
                                    // color: customTheme.groceryPrimary,
                                    fontWeight: 500,
                                    letterSpacing: -0.2),
                                FxSpacing.width(4),
                                FxText.bodyMedium('Infant',
                                    color: const Color(0xff1529e8),
                                    // color: customTheme.groceryPrimary,
                                    fontWeight: 500,
                                    letterSpacing: -0.2),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  // FxSpacing.height(4),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     FxText.bodyMedium(
                  //       'Amount',
                  //       fontWeight: 600,
                  //     ),
                  //     FxText.bodyMedium(
                  //       rateconversion.toString(),
                  //       // '${((widget.selectedtourOption[index].grandTotal * conversionRate!)).toStringAsFixed(2)} $currencySymbol',
                  //       // "${widget.selectedtourOption[index].grandTotal}AED",
                  //       fontWeight: 700,
                  //     ),
                  //   ],
                  // ),
                  // FxSpacing.height(12),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       flex: 2,
                  //       child: Container(),
                  //     ),
                  //     Expanded(
                  //       child: FxDashedDivider(
                  //         dashSpace: 4,
                  //         dashWidth: 8,
                  //         color: theme.colorScheme.onBackground.withAlpha(180),
                  //         height: 1.2,
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // FxSpacing.height(12),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     FxText.bodyMedium(
                  //       'Grand Total',
                  //       fontWeight: 700,
                  //       color: const Color(0xff1529e8),
                  //     ),
                  //     FxText.bodyMedium(
                  //       // '\$' + controller.total.precise,
                  //       // rateselectedtourOption,
                  //       '$rateconversion $currencySymbol',
                  //       // '${((widget.selectedtourOption[index].grandTotal * conversionRate!)).toStringAsFixed(2)} $currencySymbol',
                  //       // "${widget.selectedtourOption[index].grandTotal}AED",
                  //       fontWeight: 800,
                  //       color: const Color(0xff1529e8),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          // return FxSpacing.height(10);
          return const Divider(
            color: Colors.black,
            thickness: 1,
          );
        },
      ),
    );
  }

  String? rateconversion1;
  Widget paymentInfo() {
    // String? rateconversion;

    double totPaymenet = controller.grandSelectedTourAmount();
    log('Total Payment:$totPaymenet');
    if (widget.totalAmount != null) {
      log('amount not equal:${widget.totalAmount}');
      if (conversionRate != null) {
        log('ConersionRate:$conversionRate');
        rateconversion1 =
            ((widget.totalAmount! * conversionRate!)).toStringAsFixed(2);
        log('Rate:$rateconversion1');
      }
    }
    return Container(
      // padding: FxSpacing.x(20),
      child: _billingWidget(),
      // child: ListView(
      //   shrinkWrap: true,
      //   physics: const AlwaysScrollableScrollPhysics(),
      //   // crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     //bill
      //     _billingWidget(),

      //   ],
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totPaymenetBuild = controller.grandSelectedTourAmount();
    log('Total Payment Build:$totPaymenetBuild');
    return FxBuilder<DetailController>(
        controller: controller,
        builder: (controller) {
          return Container(
            color: Colors.transparent,
            child: Container(
              padding: FxSpacing.xy(24, 16),
              decoration: const BoxDecoration(
                  // color: customTheme.card,
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.only(
                      // topLeft: Radius.circular(16),
                      // topRight: Radius.circular(16)
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child:
                  // controller.grandSelectedTourAmount() == null
                  // rateconversion1 == null
                  //     ? const CircularProgressIndicator()
                  //     :
                  Builder(builder: (context) {
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          FeatherIcons.x,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FxText.displaySmall(
                        '$currencySymbol $rateconversion1',
                        // '${((controller.grandSelectedTourAmount() * conversionRate) as double).toStringAsFixed(2)} $currencySymbol',
                        color: theme.colorScheme.onBackground,
                        fontWeight: 600,
                      ),
                    ),
                    FxSpacing.height(10),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            // color: customTheme.card,
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(13),
                                topRight: Radius.circular(13))),
                        padding: FxSpacing.xy(6, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Expanded(
                            //   child: ListView(
                            //     // padding: FxSpacing.all(20),
                            //     physics: const AlwaysScrollableScrollPhysics(),
                            //     children: [
                            //       // Container(
                            //       //   child: Row(
                            //       //     mainAxisAlignment:
                            //       //         MainAxisAlignment.spaceBetween,
                            //       //     children: [
                            //       //       Padding(
                            //       //         padding: FxSpacing.x(20),
                            //       //         child: FxText.displaySmall(
                            //       //           // '${((
                            //       //           //     // controller.grandSelectedTourAmount()
                            //       //           //     widget.Option.first.grandTotal * conversionRate!)).toStringAsFixed(2)} $currencySymbol',
                            //       //           '$rateconversion1 $currencySymbol',

                            //       //           color: theme.colorScheme.onBackground,
                            //       //           fontWeight: 600,
                            //       //         ),
                            //       //       ),
                            //       //     ],
                            //       //   ),
                            //       // ),
                            //       paymentInfo(),
                            //     ],
                            //   ),
                            // ),
                            Expanded(
                              child: paymentInfo(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                // vertical: 15
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FxText.bodyMedium(
                                    'Grand Total',
                                    color: theme.colorScheme.onBackground,
                                    fontWeight: 900,
                                    fontSize: 20,
                                  ),
                                  FxText.bodyMedium(
                                    '$rateconversion1 $currencySymbol',
                                    color: theme.colorScheme.onBackground,
                                    fontWeight: 900,
                                    fontSize: 20,
                                  ),
                                ],
                              ),
                            ),
                            FxSpacing.height(6),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                // vertical: 15
                              ),
                              child: FxButton.block(
                                onPressed: () {
                                  // controller.goToCheckout1();
                                  controller.BottomgoToCheckout1(
                                      widget.len,
                                      widget.Option,
                                      widget.textdate,
                                      widget.Transfer,
                                      widget.totalAmount);
                                },
                                backgroundColor: const Color(0xff1529e8),
                                // backgroundColor: customTheme.estatePrimary,
                                borderRadiusAll: 12,

                                elevation: 0,
                                child: FxText.bodyMedium(
                                  'Book Now',
                                  color: Colors.white,
                                  // color: customTheme.estateOnPrimary,
                                  fontWeight: 700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        });
  }
}
