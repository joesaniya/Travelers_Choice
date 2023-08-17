import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/full_app.dart';
import '../../card_widgets/customsnackbar.dart';
import '../../controllers/Activity_controller.dart';
import '../../controllers/checkout_controller.dart';
import '../../models/Slot_Time.dart';
import '../../models/atteraction_model.dart';
import '../../models/slot_pick.dart';
import '../../services/app_constants.dart';
import '../../theme/app_theme.dart';

class TourWidgets extends StatefulWidget {
  // final DetailattractionModal Excursions;
  // List<DetailattractionModal> Excursions;
  // final String excursions;
  List<Activity> excursions;
  final String excursionid;

  TourWidgets(
      // this.Excursions,
      this.excursions,
      this.excursionid,
      {super.key}
      //  {required List<DetailattractionModal> Excursions}
      );

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<TourWidgets>
    with TickerProviderStateMixin {
  late ThemeData theme;
  bool isSelected = false;

  late ActivityController activitycontroller;
  late CheckOutController checkoutcontroller;
  bool clickedExcursion = true;
  List<TextEditingController> controllerTE = [];
  List<TextEditingController> SlotcontrollerTE = [];
  String? token;
  List<Activity> tempFavouriteList = favouriteListCart.map((e) => e).toList();

  Widget privatetransferwidget(int i) {
    log('privatetransferwidget()');
    return Container(
        // decoration: BoxDecoration(
        //     color: theme.cardTheme.color,
        //     // color: const Color(0xff1529e8),
        //     borderRadius: BorderRadius.circular(8)),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.excursions[i].privateTransfers!.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          for (var element
                              in widget.excursions[i].privateTransfers!) {
                            element.isActive = false;
                          }
                          widget.excursions[i].privateTransfers![index]
                              .isActive = true;
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: widget.excursions[i]
                                      .privateTransfers![index].isActive
                                  ? Colors.blue
                                  : theme.cardTheme.color,
                              borderRadius: BorderRadius.circular(8)),
                          width: 50,
                          child: Padding(
                            padding: FxSpacing.y(5),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FxText.bodyMedium(
                                  widget.excursions[i].privateTransfers![index]
                                      .name
                                      .toString(),
                                  fontWeight: 900,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FxText.bodyMedium(
                                      'Seats:',
                                      fontWeight: 600,
                                    ),
                                    FxText.bodyMedium(widget.excursions[i]
                                        .privateTransfers![index].maxCapacity
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FxText.bodyMedium(
                                      'Cost(1 person):',
                                      fontWeight: 600,
                                    ),
                                    FxText.bodyMedium(widget.excursions[i]
                                        .privateTransfers![index].cost
                                        .toString()),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  Expanded(child: Container())
                ],
              );
            }));
  }

//alert
  showAlertDialog(index, List<SlotTime> timeSlotList) async {
    AlertDialog alert = AlertDialog(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: FxText(
            "Select Time Slot",
            fontWeight: 700,
            textAlign: TextAlign.center,
            // color: Colors.white,
            color: const Color(0xff1529e8),
            // textAlign: TextAlign.center,
            // style: TextStyle(color: Colors.white),
          ),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Expanded(
                      flex: 14,
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int preIndex) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                for (var element in timeSlotList) {
                                  if (element.eventId ==
                                      timeSlotList[preIndex].eventId) {
                                    if (int.parse(
                                            timeSlotList[preIndex].available) ==
                                        0) {
                                      element.isSelected = false;
                                    } else {
                                      element.isSelected = true;
                                    }
                                    element.isSelected = true;
                                    if (element.isSelected == true) {
                                      activitycontroller.listSLotDetails
                                          .add(element);
                                    }
                                  } else {
                                    element.isSelected = false;
                                    log('isSele:${element.isSelected} ');
                                  }
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      timeSlotList[preIndex].isSelected == false
                                          ? const Color(0xffB9DDFF)
                                          : Colors.green
                                  // color:
                                  //     (timeSlotList[preIndex].isSelected == false
                                  //         ? int.parse(timeSlotList[preIndex]
                                  //                     .available) >=
                                  //                 10
                                  //             ? Colors.blueGrey
                                  //             : int.parse(timeSlotList[preIndex]
                                  //                         .available) ==
                                  //                     0
                                  //                 ? Colors.red
                                  //                 : Colors.yellow
                                  //         : Colors.green),
                                  ),
                              // width: 100,
                              // height: 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FxText.bodyMedium(
                                          getFormattedDate(
                                              timeSlotList[preIndex]
                                                  .startDateTime
                                                  .toString()),
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: 600,
                                        ),
                                        FxText.bodyMedium(
                                          ' - ',
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: 600,
                                        ),
                                        FxText.bodyMedium(
                                          getFormattedDate(
                                              timeSlotList[preIndex]
                                                  .endDateTime
                                                  .toString()),
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: 600,
                                        )
                                      ],
                                    ),
                                  ),

                                  // Text(timeSlotList[preIndex].startDateTime.toString().substring(11, 16) + "-"+"${timeSlotList[preIndex].endDateTime.toString().substring(11, 16)}",
                                  //   style:TextStyle(color:Colors.white),),

                                  FxText.bodyMedium(
                                    "Adult Cost",
                                    color: Colors.black,
                                    fontWeight: 600,
                                  ),
                                  FxText.bodyMedium(
                                    '${timeSlotList[preIndex].adultPrice} AED',
                                    // "${timeSlotList[preIndex].adultPrice * widget.conversionRate} ${widget.currencySymbol}",
                                    color: Colors.black,
                                    fontWeight: 600,
                                  ),

                                  FxText.bodyMedium(
                                    "Child Cost",
                                    color: Colors.black,
                                    fontWeight: 600,
                                  ),
                                  FxText.bodyMedium(
                                    '${timeSlotList[preIndex].childPrice} AED',
                                    color: Colors.black,
                                    fontWeight: 600,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: timeSlotList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1.17
                                // childAspectRatio: 3 / 4
                                ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff1529e8),
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.excursions[index].activityTimeSlot =
                                        activitycontroller.listSLotDetails.last;
                                    // widget.excursions[index].activityTimeSlot
                                    //     !.add(activitycontroller
                                    //         .listSLotDetails.last);
                                  });
                                  // activitiesListTime.add(listSLotDetails.last);
                                  // log(activitiesListTime);

                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Apply",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                ));
          },
        ));

    // show the dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    setState(() {});
  }

  String timeconverted(String startEnd) {
    // void timeconverted() {
    var result = startEnd;
    // String originalDateTime = '2023-08-20T17:45:00';

    String originalDateTime = result;
    // String originalDateTime = '2023-06-30T17:45:00';
    // String originalDateTime = '2023-06-30T18:15:00';

    DateTime parsedDateTime = DateTime.parse(originalDateTime);
    String formattedTime = DateFormat('HH:mm:ss').format(parsedDateTime);

    log('formattedTime:$formattedTime');

    String originalTime = formattedTime;

    DateTime parsedTime = DateFormat('HH:mm:ss').parseStrict(originalTime);
    String formattedAMPN = DateFormat('h:mm a').format(parsedTime);

    log('Start and End:$formattedAMPN');
    return result;
  }

  Widget dropdownwidget(int i) {
    ///transfr
    List<String> tempTransferCodes = [];
    bool? isPrivate = widget.excursions[i].isPrivateTransferAvailable;
    bool? isShared = widget.excursions[i].isSharedTransferAvailable;

    log("TransferCode Private => $isPrivate Shared => $isShared");
    if (((isPrivate != null && !isPrivate) &&
            (isShared != null && !isShared)) ||
        ((isPrivate != null && isPrivate) && (isShared != null && isShared))) {
      if (!tempTransferCodes.contains("Without Transfer")) {
        tempTransferCodes.add("Without Transfer");
      }
    }
    if (isPrivate != null && isPrivate) {
      if (!tempTransferCodes.contains("private")) {
        tempTransferCodes.add("private");
      }
    }
    if (isShared != null && isShared) {
      if (!tempTransferCodes.contains("shared")) {
        tempTransferCodes.add("shared");
      }
    }

    activitycontroller.TransferCodes = tempTransferCodes;

    log("TransferCode =>   ${activitycontroller.TransferCodes}");

    return Container(
      decoration: BoxDecoration(
          color: theme.cardTheme.color,
          // color: const Color(0xff1529e8),
          borderRadius: BorderRadius.circular(8)),
      height: 50,
      width: 150,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: [
              Expanded(
                  child: FxText.labelLarge(
                // activitycontroller.TransferCodes[0],

                'Select Transfer',
                fontWeight: 600,
                color: Colors.black,
                letterSpacing: 0.4,
              )),
            ],
          ),
          value: widget.excursions[i].transferCode
          // ??
          //     activitycontroller.TransferCodes[0]
          /*widget.excursions[i].isSharing
              ? activitycontroller.TransferCodes[2]
              : widget.excursions[i].isPrivate
                  ? activitycontroller.TransferCodes[1]
                  : activitycontroller.TransferCodes[0]*/
          ,
          items: activitycontroller.TransferCodes.map((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: Center(
                  child: Text(
                    value,
                    style: FxTextStyle.bodyMedium(),
                  ),
                ));
          }).toList(),
          onChanged: (value) {
            setState(() {
              widget.excursions[i].transferCode = value.toString();
              log('Transfer:${activitycontroller.selectedtransfer}');
            });
            activitycontroller.addisPrivateORsharing(widget.excursions[i],
                isPrivate: widget.excursions[i].transferCode == "private",
                isSharing: widget.excursions[i].transferCode == "shared");
          },
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 20,
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.black,
          buttonHeight: 30,
          buttonWidth: 200,
          buttonPadding:
              const EdgeInsets.only(left: 14, right: 14, top: 4, bottom: 4),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: theme.cardTheme.color,
          ),
          itemHeight: 40,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownPadding: null,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 2,
          scrollbarAlwaysShow: true,
          offset: const Offset(0, 0),
        ),
      ),
    );
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

  @override
  void initState() {
    super.initState();
    log('Excursion Id:${widget.excursionid}');
    log('Selected Dateinitial:${widget.excursions.first.selectedDate}');
    log('Activity Length:${widget.excursions.length.toString()}');
    // for (int i = 0; i < widget.excursions.length; i++) {
    //   controller.slottimeget.add([]);
    // }
    favouriteListCheck();
    // timeconverted();
    // getSlot("83", "54", "2023-08-20", context);
    // Slotdate("83", "54", "2023-08-20", context);
    //                   controller.SlotPick(
    //                     widget.excursions[i]
    //                         .productId
    //                         .toString(),
    //                     widget.excursions[i]
    //                         .productCode
    //                         .toString(),
    //                     widget.excursions[i]
    //                         .selectedDate!
    //                         .toString(),
    //                   );

    initializingData();
    theme = AppTheme.shoppingTheme;
    var selectedData = widget.excursions;

    activitycontroller = FxControllerStore.put(ActivityController(this));
    checkoutcontroller = FxControllerStore.put(CheckOutController(this));
    // log(activitycontroller.person_count);
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
        controller: activitycontroller,
        builder: (controller) {
          return _buildBody();
        });
  }

  favouriteListCheck() async {
    isSelected =
        favouriteListCart.any((e) => e.sId == widget.excursions.first.sId);
    setState(() {
      isSelected;
    });
    log('Fav List Check:$isSelected');
  }

  Widget _buildSelectBurj() {
    if (activitycontroller.selectedtour.isNotEmpty) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey.shade300, width: 1)),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: FxText.bodyMedium(
                    '${activitycontroller.selectedtour.length} Selected',
                    fontWeight: 800,
                  )),
                  FxText.bodyLarge(
                    // controller.selectedtour.first.GrandTotalAmount.toString(),
                    // '${controller.grandSelectedTourAmount().toString()} AED',
                    '${((activitycontroller.grandSelectedTourAmount() * conversionRate) as double).toStringAsFixed(2)} $currencySymbol',

                    fontWeight: 700,
                    color: const Color(0xff1529e8),
                  ),
                ],
              )
            ],
          ));
    } else {
      return const SizedBox();
    }
  }

  Widget _buildSelect1() {
    if (activitycontroller.selectedtour.isNotEmpty) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey.shade300, width: 1)),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: FxText.bodyMedium(
                    '${activitycontroller.selectedtour.length} Selected',
                    fontWeight: 800,
                  )),
                  FxText.bodyLarge(
                    // controller.selectedtour.first.GrandTotalAmount.toString(),
                    // '${controller.grandSelectedTourAmount().toString()} AED',
                    '${((activitycontroller.grandSelectedTourAmount() * conversionRate) as double).toStringAsFixed(2)} $currencySymbol',

                    fontWeight: 700,
                    color: const Color(0xff1529e8),
                  ),
                ],
              )
              // Column(
              //     children: controller.selectedtour.map((Activity tour) {
              //   return Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Expanded(child: Text(tour.name.toString())),
              //       FxSpacing.width(20),
              //       Text(tour.grandTotal.toString()),
              //     ],
              //   );
              // }).toList()),
              // FxSpacing.height(20),
              // FxDashedDivider(
              //   dashSpace: 4,
              //   dashWidth: 8,
              //   color: theme.colorScheme.onBackground.withAlpha(180),
              //   height: 1.2,
              // ),
              // FxSpacing.height(20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     FxText.bodyLarge(
              //       'Total Amount',
              //       fontWeight: 700,
              //       color: const Color(0xff1529e8),
              //     ),
              //     FxText.bodyLarge(
              //       // controller.selectedtour.first.GrandTotalAmount.toString(),
              //       controller.grandSelectedTourAmount().toString(),
              //       fontWeight: 700,
              //       color: const Color(0xff1529e8),
              //     ),
              //   ],
              // )
            ],
          ));
    } else {
      // return Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
      //   decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: const BorderRadius.all(Radius.circular(10)),
      //       border: Border.all(color: Colors.grey.shade300, width: 1)),
      //   child: Center(
      //     child: FxText.bodyMedium(
      //       'No Tour Option Selected!!',
      //       muted: true,
      //       fontWeight: 700,
      //     ),
      //   ),
      // );
      return const SizedBox();
    }
  }

  Widget _buildSelect() {
    if (activitycontroller.selectedtour == null) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey.shade300, width: 1)),
          child: Column(
            children: [
              Column(
                  children:
                      activitycontroller.selectedtour.map((Activity tour) {
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
                    activitycontroller.grandSelectedTourAmount().toString(),
                    fontWeight: 700,
                    color: const Color(0xff1529e8),
                  ),
                ],
              )
            ],
          ));
    } else {
      if (activitycontroller.selectedtour.isEmpty) {
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

  CustomSlots? FunctionGetSlots(String productId) {
    if (activitycontroller.slottimeget.isNotEmpty) {
      log('If');
      for (var e in activitycontroller.slottimeget) {
        log('for Each');
        if (e.id == productId) {
          log('for ech if');
          activitycontroller.customSlots = e;
          log("event => ${e.event}");
          activitycontroller.customSlots!.slots = e.slots!;
          break;
        }
      }
    } else {}
    return activitycontroller.customSlots;
  }

  Widget _slotsUiGrid(String productId) {
    log('Id:$productId');
    activitycontroller.customSlots = FunctionGetSlots(productId);
    List<SlotTime> currentSlot = activitycontroller.customSlots!.slots!;
    return GridView(
      primary: false,
      padding: const EdgeInsets.all(16),
      // crossAxisSpacing: 10,
      // childAspectRatio: 0.90,
      // mainAxisSpacing: 10,
      // maxCrossAxisExtent:
      // 140.0,
      // maxCrossAxisExtent:
      //     150.0,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      physics: const AlwaysScrollableScrollPhysics(),
      children: List.generate(
        // controller.timeslotstart,
        currentSlot.length
        // 9
        ,

        (int index) {
          log('Start Time:${currentSlot[index].startDateTime.toString()}');
          String StartTime = currentSlot[index].startDateTime.toString();

          DateTime parsedStartTime = DateTime.parse(StartTime);
          String formattedStartTime =
              DateFormat('HH:mm:ss').format(parsedStartTime);

          log('formattedTime:$formattedStartTime');

          String originalStartTime = formattedStartTime;

          DateTime parsedTimeStart =
              DateFormat('HH:mm:ss').parseStrict(originalStartTime);
          String formattedStartAMPN =
              DateFormat('h:mm a').format(parsedTimeStart);

          log('Start:$formattedStartAMPN');
          // log('currentSlot!.length:${currentSlot!.length}');

          //end
          String EndTime = currentSlot[index].endDateTime.toString();

          DateTime parsedEndTime = DateTime.parse(EndTime);
          String formattedEndTime =
              DateFormat('HH:mm:ss').format(parsedEndTime);

          log('formattedTime:$formattedEndTime');

          String originalEndTime = formattedEndTime;

          DateTime parsedTimeEnd =
              DateFormat('HH:mm:ss').parseStrict(originalEndTime);
          String formattedEndAMPN = DateFormat('h:mm a').format(parsedTimeEnd);

          log('default:${activitycontroller.defaultChoiceIndex} $index');
          log('End:$formattedEndAMPN');
          return GestureDetector(
            onTap: () {
              // controller.closeEndDrawer();
              setState(() {
                log('Clicked Index:$index');

                for (var e in activitycontroller.slottimeget) {
                  log('for Each');
                  if (e.id == productId) {
                    log('for ech if');
                    currentSlot = e.slots!;
                    activitycontroller.customSlots!.SelectedIndex = index;

                    log("before update event -> ${e.event}");
                    e.event = currentSlot[index];
                    activitycontroller.customSlots!.event = e.event;

                    // controller.selectedtour.add(e.event as Activity);
                    // log(' controller.selectedtour.add(e.event as Activity):${controller.selectedtour.first.event!.eventName}');

                    log('Clicked Event:${activitycontroller.customSlots!.event}');
                  }
                }

                // controller.events.add(currentSlot[index]);
                log('Event Index:$index');
                log('Event Name:${currentSlot[index].toJson()}');
                // log('Events:${controller.events.map((e) => e.eventName).toList()}');
                log('selected card Id:${currentSlot[index].eventId}');
                log('selected card:${activitycontroller.defaultChoiceIndex}');
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: activitycontroller.customSlots!.SelectedIndex == index
                    ? const Color(0xffB9DDFF)
                    : const Color(0xffF5F5F4),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 1,
                    spreadRadius: 0.0,
                    color: Colors.black26,
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(40)),
              ),
              padding: FxSpacing.xy(5, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // FxText
                  //     .bodyMedium(
                  //   controller
                  //       .slottimeget[
                  //           index]
                  //       .eventId,
                  //   color: Colors
                  //       .black,
                  //   fontWeight:
                  //       600,
                  // ),
                  FxText.bodyMedium(
                    // "$timeconverted(currentSlot![index].startDateTime)- $timeconverted(currentSlot![index].startDateTime)",
                    // timeconverted(controller
                    //     .slottimeget[
                    //         index]
                    //     .startDateTime
                    //     .toString()),
                    "$formattedStartAMPN- $formattedEndAMPN",
                    color: Colors.black,
                    fontWeight: 600,
                  ),

                  FxSpacing.height(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                        height: 20,
                        width: 20,
                        color: Colors.black,
                        image: AssetImage(
                          'assets/icons/icons8-person.png',
                        ),
                      ),
                      FxText.bodyMedium(
                        // '554 AEd',
                        '${currentSlot[index].adultPrice} AED',
                        color: Colors.black,
                        fontWeight: 600,
                      ),
                    ],
                  ),

                  FxSpacing.height(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                        height: 20,
                        width: 20,
                        color: Colors.black,
                        image: AssetImage(
                          'assets/icons/childicon.png',
                        ),
                      ),
                      FxText.bodyMedium(
                        '${currentSlot[index].childPrice} AED',
                        // '${widget.Slots[index].adultPrice}AED',
                        // '${((widget.Slots[index].childPrice.toDouble() * conversionRate!)).toStringAsFixed(2)} $currencySymbol',
                        color: Colors.black,
                        fontWeight: 600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCartList() {
    List<Widget> list = [];
    log('_buildCartList() calling');
    log(widget.excursions.length.toString());

    for (var i = 0; i < widget.excursions.length; i++) {
      List<TextEditingController> controllers = List.generate(
        widget.excursions.length,
        (index) => TextEditingController(),
      );
      bool? isPrivate = widget.excursions[i].isPrivateTransferAvailable;
      bool? isShared = widget.excursions[i].isSharedTransferAvailable;
      controllerTE.add(TextEditingController());

      log(
          'Selected Tour Date:${activitycontroller.selectedtour.map((e) => e.selectedDate)}');
//slot
      List<TextEditingController> Slotcontrollers = List.generate(
        widget.excursions.length,
        (index) => TextEditingController(),
      );
      SlotcontrollerTE.add(TextEditingController());

      //transfer
      if (widget.excursions[i].isPrivateTransferAvailable == false &&
          widget.excursions[i].isSharedTransferAvailable == false) {
        activitycontroller.itemValue.add(["Without Transfer"]);
      } else if (widget.excursions[i].isPrivateTransferAvailable == true &&
          widget.excursions[i].isSharedTransferAvailable == true) {
        activitycontroller.itemValue
            .add(["Without Transfer", "Private Transfer", "Shared Transfer"]);
        // if(detailAttractionResponse.attraction!.activities![i].isPrivateTransferAvailable==true){
        //   itemValue.add(["Without Transfer","Private Transfer", "Shared Transfer"]);
        //
        // }else {
        //   itemValue.add(["Without Transfer"]);
        // }
      } else if (widget.excursions[i].isPrivateTransferAvailable == true &&
          widget.excursions[i].isSharedTransferAvailable == false) {
        activitycontroller.itemValue
            .add(["Without Transfer", "Private Transfer"]);
      } else if (widget.excursions[i].isPrivateTransferAvailable == false &&
          widget.excursions[i].isSharedTransferAvailable == true) {
        activitycontroller.itemValue
            .add(["Without Transfer", "Shared Transfer"]);
      } else {
        activitycontroller.itemValue.add(["Without Transfer"]);
      }
      //
      list.add(FadeTransition(
        opacity: activitycontroller.fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxSpacing.height(10),
            GestureDetector(
              onTap: () {
                clickedExcursion = !clickedExcursion;

                setState(() {});

                // controller.updateTourSlot(currentSlot[i])
                activitycontroller.updateTours(widget.excursions[i]);

                // log('Count:${widget.excursions[i].adultCount}${widget.excursions[i].childCount}${widget.excursions[i].infantCount}');
                // controller.SlotPick(
                //   widget.excursions[i].productId.toString(),
                //   widget.excursions[i].productCode.toString(),
                //   widget.excursions[i].selectedDate!.toString(),
                // );
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: !clickedExcursion
                        ? const Text("Added this Excursion!!")
                        : const Text("Removed this Excursion!!")));
              },
              child: Card(
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
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 20),
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
                              // onTap: () {
                              //   clickedExcursion = !clickedExcursion;

                              //   setState(() {});
                              //   // controller.updateTours(widget.excursions[i]);
                              //   // checkoutcontroller.addCart
                              //   //     ? checkoutcontroller.cartController.reverse()
                              //   //     : checkoutcontroller.cartController.forward();

                              //   //todo
                              //   // if (controllerTE[i].text.isEmpty) {
                              //   //   ScaffoldMessenger.of(context).showSnackBar(
                              //   //       const SnackBar(
                              //   //           content: Text("Select Your Date")));
                              //   // } else {
                              //   // selectedIndex = i;
                              //   // controller.selectedtour
                              //   //         .contains(widget.excursions[i])
                              //   //     ? selectedIndex = i
                              //   //     : selectedIndex = null;
                              //   controller.updateTours(widget.excursions[i]);
                              //   log('Count:${widget.excursions[i].adultCount}${widget.excursions[i].childCount}${widget.excursions[i].infantCount}');

                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(
                              //           content: !clickedExcursion
                              //               ? const Text(
                              //                   "Added this Excursion!!")
                              //               : const Text(
                              //                   "Removed this Excursion!!")));
                              // },
                              child: AnimatedContainer(
                                // height: 40 ?? 28,
                                // width: 40 ?? 28,
                                height: 20,
                                width: 20,
                                duration: const Duration(milliseconds: 0),
                                curve: Curves.fastLinearToSlowEaseIn,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.0),
                                    color: activitycontroller.selectedtour
                                            .contains(widget.excursions[i])
                                        ? Colors.indigo
                                        : Colors.white,
                                    border: Border.all(
                                      color: activitycontroller.selectedtour
                                              .contains(widget.excursions[i])
                                          ? Colors.transparent
                                          : Colors.black,
                                    )),
                                child: !activitycontroller.selectedtour
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

                        Column(children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FxText.bodySmall('per person*'),
                              widget.excursions[i].adultPrice == null
                                  ? FxText.bodyLarge(
                                      '0',
                                      fontWeight: 900,
                                    )
                                  : FxText.bodyLarge(
                                      '${((widget.excursions[i].lowPrice * conversionRate) as double).toStringAsFixed(2)} $currencySymbol',

                                      // '${widget.excursions[i].lowPrice.toString()} AED',
                                      fontWeight: 900,
                                    )
                            ],
                          ),
                          !activitycontroller.selectedtour
                                  .contains(widget.excursions[i])
                              ? const SizedBox(height: 0)
                              : Column(
                                  children: [
                                    // selectedIndex == i
                                    //     ? const SizedBox()
                                    //     : const Text('data'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        dropdownwidget(i),
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
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate: DateTime
                                                              .now(), //DateTime.now() - not to allow to choose before today.
                                                          lastDate:
                                                              DateTime(2101))
                                                      .then((value) async {
                                                if (value != null) {
                                                  // log(
                                                  //     value); //pickedDate output format => 2021-03-10 00:00:00.000
                                                  String formattedDate =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(value);
                                                  log(formattedDate);
                                                  // dateTE.text = formattedDate;
                                                  controllerTE[i].text =
                                                      formattedDate;
                                                  widget.excursions[i]
                                                          .selectedDate =
                                                      formattedDate;

                                                  log('Selected Date:${widget.excursions[i].selectedDate}');

                                                  var data =
                                                      await activitycontroller
                                                          .SlotPick(
                                                    // controller
                                                    //     .processGetTimeSlot(
                                                    widget
                                                        .excursions[i].productId
                                                        .toString(),
                                                    widget.excursions[i]
                                                        .productCode
                                                        .toString(),
                                                    widget.excursions[i]
                                                        .selectedDate!
                                                        .toString(),
                                                  );
                                                  setState(() {
                                                    // controller.slottimeget =
                                                    //     data!;
                                                    // CustomSlots? customslot =
                                                    //     FunctionGetSlots(widget
                                                    //         .excursions[i]
                                                    //         .productId
                                                    //         .toString());
                                                    // currentEvent =
                                                    //     customslot!.event;
                                                  });
                                                  log('controller.slottimeget:${activitycontroller.slottimeget}');
                                                  // dataslot =
                                                  //     await controller.SlotPick(
                                                  //   widget.excursions[i].productId
                                                  //       .toString(),
                                                  //   widget
                                                  //       .excursions[i].productCode
                                                  //       .toString(),
                                                  //   widget.excursions[i]
                                                  //       .selectedDate!
                                                  //       .toString(),
                                                  // );

                                                  // setState(() {
                                                  //   dateinput.text = formattedDate; //set output date to TextField value.
                                                  // });
                                                } else {
                                                  log("Date is not selected");
                                                }
                                                return null;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                                filled: true,
                                                isDense: true,
                                                fillColor:
                                                    theme.cardTheme.color,
                                                hintText: "yyyy-mm-dd",
                                                border: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                contentPadding:
                                                    FxSpacing.all(16),
                                                hintStyle: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  letterSpacing: 0.4,
                                                ),
                                                // hintStyle: FxTextStyle.bodyMedium(),
                                                isCollapsed: true),
                                            autofocus: false,
                                            keyboardType:
                                                TextInputType.datetime,
                                          ),
                                        ),
                                      ],
                                    ),

                                    FxSpacing.height(10),

                                    //buton
                                    widget.excursionid ==
                                                '63ff12f5d7333637a938cad4' &&
                                            controllerTE[i].text.isNotEmpty
                                        ? Row(
                                            children: [
                                              FxContainer(
                                                onTap: () async {
                                                  if (controllerTE[i]
                                                      .text
                                                      .isEmpty) {
                                                    CustomSnackbar.show(
                                                      context: context,
                                                      message:
                                                          'Select Your Tour date',
                                                      backgroundColor:
                                                          const Color(
                                                              0xff1529e8),
                                                      duration: const Duration(
                                                          seconds: 2),
                                                    );
                                                  } else {
                                                    var data =
                                                        await activitycontroller
                                                            .processGetTimeSlot(
                                                      widget.excursions[i]
                                                          .productId
                                                          .toString(),
                                                      widget.excursions[i]
                                                          .productCode
                                                          .toString(),
                                                      widget.excursions[i]
                                                          .selectedDate!
                                                          .toString(),
                                                    );
                                                    setState(() {});

                                                    activitycontroller
                                                        .timeSlotList = data;
                                                    log("timeSlot $data");

                                                    activitycontroller
                                                                .timeSlotList !=
                                                            null
                                                        ? showAlertDialog(
                                                            i,
                                                            activitycontroller
                                                                .timeSlotList)
                                                        : log('none');
                                                  }
                                                },
                                                borderRadiusAll: 10,
                                                // padding: FxSpacing.xy(8, 4),
                                                padding: FxSpacing.xy(6, 15),
                                                color: const Color(0xff1529e8),

                                                child: FxText.bodySmall(
                                                  'Select Time SLot',

                                                  fontWeight: 900,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.white,
                                                  // color: theme.colorScheme.onPrimary,
                                                ),
                                              ),
                                              Expanded(
                                                child: widget.excursions[i]
                                                            .activityTimeSlot ==
                                                        null
                                                    ? Container()
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          FxText.bodyMedium(
                                                            getFormattedDate(widget
                                                                .excursions[i]
                                                                .activityTimeSlot!
                                                                .startDateTime
                                                                .toString()),
                                                            color: Colors.black,
                                                            fontWeight: 600,
                                                          ),
                                                          FxText.bodyMedium(
                                                            ' - ',
                                                            color: Colors.black,
                                                            fontWeight: 600,
                                                          ),
                                                          FxText.bodyMedium(
                                                            getFormattedDate(widget
                                                                .excursions[i]
                                                                .activityTimeSlot!
                                                                .endDateTime
                                                                .toString()),
                                                            color: Colors.black,
                                                            fontWeight: 600,
                                                          ),
                                                        ],
                                                      ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),

                                    FxSpacing.height(10),

                                    //transfer
                                    widget.excursions[i].privateTransfers!
                                                .isNotEmpty &&
                                            widget.excursions[i].transferCode ==
                                                'private'
                                        ? privatetransferwidget(i)
                                        : const SizedBox(),
                                    FxSpacing.height(10),

                                    personCount(activitycontroller,
                                        widget.excursions[i], setState, theme,
                                        isAdult: true),
                                    //child
                                    FxSpacing.height(4),

                                    personCount(activitycontroller,
                                        widget.excursions[i], setState, theme,
                                        isChild: true),
                                    FxSpacing.height(4),

                                    //infant

                                    personCount(activitycontroller,
                                        widget.excursions[i], setState, theme,
                                        isInfant: true),
                                    if (isPrivate != null && isPrivate)
                                      FxSpacing.height(4),
                                    if (isPrivate != null && isPrivate)
                                      cost(widget.excursions[i],
                                          isPrivate: true),
                                    if (isShared != null && isShared)
                                      FxSpacing.height(4),
                                    if (isShared != null && isShared)
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
                                          '${((activitycontroller.getTotal(widget.excursions[i]) * conversionRate!)).toStringAsFixed(2)} $currencySymbol',
                                          fontWeight: 700,
                                        ),
                                      ],
                                    ),
                                    // FxSpacing.height(4),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     FxText.bodyMedium(
                                    //       'Private Cost',
                                    //       fontWeight: 600,
                                    //     ),
                                    //     widget
                                    //                 .excursions[i]
                                    //                 .privateTransfers![i]
                                    //                 .cost ==
                                    //             null
                                    //         ? FxText.bodyMedium(
                                    //             '0.0',
                                    //             fontWeight: 700,
                                    //           )
                                    //         : FxText.bodyMedium(
                                    //             widget.excursions[i]
                                    //                 .privateTransfers![i].cost!
                                    //                 .toStringAsFixed(1),

                                    //             // '${((widget.excursions[i].privateTransfers![i].cost! * conversionRate!)).toStringAsFixed(2)} $currencySymbol',
                                    //             fontWeight: 700,
                                    //           ),
                                    //   ],
                                    // ),

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
                                            color: theme
                                                .colorScheme.onBackground
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
                                          // controller
                                          //     .getGrandTotal(
                                          //         widget.excursions[i])
                                          //     .toString(),
                                          '${((activitycontroller.getGrandTotal(widget.excursions[i]) * conversionRate!)).toStringAsFixed(2)} $currencySymbol',

                                          fontWeight: 800,
                                          color: const Color(0xff1529e8),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                        ]),
                      ],
                    ),
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
      opacity: activitycontroller.cartAnimation,
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
                    position: activitycontroller.dateAnimation,
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        style: FxTextStyle.bodyMedium(),
                        controller: activitycontroller.dateTE,
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

//slotui
  Widget _buildBody() {
    return _buildCartList();
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
