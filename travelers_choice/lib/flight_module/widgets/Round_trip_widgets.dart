import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/extensions/date_time_extension.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'dart:developer';
import '../../theme/app_theme.dart';
import '../bottomsheet/Traveller_class_Sheet.dart';
import '../controller/one_way_controller.dart';
import '../controller/round_trip_scontroller.dart';
import 'upcoming_flights.dart';

class RoundTripWidgets extends StatefulWidget {
  const RoundTripWidgets({super.key});

  @override
  State<RoundTripWidgets> createState() => _RoundTripWidgetsState();
}

class _RoundTripWidgetsState extends State<RoundTripWidgets>
    with TickerProviderStateMixin {
  late CustomTheme customTheme;
  late ThemeData theme, theme1;
  late RoundTripController controller;
  // late RoundTripController controller;
  double? customwidth;

  @override
  void initState() {
    super.initState();

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(RoundTripController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    customwidth = MediaQuery.of(context).size.width / 2;
    final size = MediaQuery.of(context).size;
    return FxBuilder<RoundTripController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    DateTime newdate = DateTime.now();
    // String formattedDate = DateFormat.yMMMEd().format(newdate);
    String formattedDate = DateFormat.MMMd().format(newdate);
    print(formattedDate);
    String formattedYear = DateFormat('EEEE, yyyy').format(newdate);
    log('start:${controller.selectedDateRange?.start.day}');

    // DateTime new1 = controller.selectedDateRange.start;

    //start
    // DateTime startdate = controller.selectedDateRange?.start
    //     .toString()
    //     .split(' ')[0] as DateTime;
    // String formattedStartDate = DateFormat.MMMd().format(startdate);
    // log('Start:$formattedStartDate');
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,

        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Stack(
          //   children: [
          //     Column(
          //       children: [
          //         Container(
          //           // margin: const EdgeInsets.symmetric(horizontal: 20),
          //           // color: Colors.grey.shade200,
          //           // borderColor: Colors.amber,
          //           // border: Border.all(
          //           //     // color: Colors.grey.shade800,
          //           //     color: Colors.black,
          //           //     width: 1),
          //           margin:
          //               const EdgeInsets.symmetric(horizontal: 20),
          //           // height: 70,
          //           padding: const EdgeInsets.symmetric(
          //               vertical: 5, horizontal: 10),
          //           width: double.infinity,
          //           decoration: BoxDecoration(
          //             color: Colors.grey.shade200,
          //             borderRadius:
          //                 const BorderRadius.all(Radius.circular(7)),
          //             border:
          //                 Border.all(color: Colors.black12, width: 1),
          //           ),
          //           child: Row(
          //             children: [
          //               const Icon(
          //                 LineIcons.planeDeparture,
          //                 size: 29,
          //               ),
          //               FxSpacing.width(10),
          //               Column(
          //                 mainAxisAlignment:
          //                     MainAxisAlignment.spaceEvenly,
          //                 crossAxisAlignment:
          //                     CrossAxisAlignment.start,
          //                 children: [
          //                   FxText.labelMedium('FROM'),
          //                   Row(
          //                     crossAxisAlignment:
          //                         CrossAxisAlignment.center,
          //                     mainAxisAlignment:
          //                         MainAxisAlignment.start,
          //                     children: [
          //                       FxText.labelLarge(
          //                         'New Delhi',
          //                         fontWeight: 900,
          //                         fontSize: 15,
          //                         color: Colors.black,
          //                       ),
          //                       FxSpacing.width(10),
          //                       FxText.labelMedium('DEL')
          //                     ],
          //                   ),
          //                   FxText.labelMedium(
          //                       'Chhatrapati Sivaji International Airport'),
          //                 ],
          //               )
          //             ],
          //           ),
          //         ),
          //         FxSpacing.height(20),

          //         //to
          //         Container(
          //           margin:
          //               const EdgeInsets.symmetric(horizontal: 20),
          //           // height: 70,
          //           padding: const EdgeInsets.symmetric(
          //               vertical: 5, horizontal: 10),
          //           width: double.infinity,
          //           decoration: BoxDecoration(
          //             color: Colors.grey.shade200,
          //             borderRadius:
          //                 const BorderRadius.all(Radius.circular(7)),
          //             border:
          //                 Border.all(color: Colors.black12, width: 1),
          //           ),
          //           child: Row(
          //             children: [
          //               const Icon(
          //                 LineIcons.planeArrival,
          //                 size: 29,
          //               ),
          //               FxSpacing.width(10),
          //               Column(
          //                 mainAxisAlignment:
          //                     MainAxisAlignment.spaceEvenly,
          //                 crossAxisAlignment:
          //                     CrossAxisAlignment.start,
          //                 children: [
          //                   FxText.labelMedium('TO'),
          //                   Row(
          //                     crossAxisAlignment:
          //                         CrossAxisAlignment.center,
          //                     mainAxisAlignment:
          //                         MainAxisAlignment.start,
          //                     children: [
          //                       FxText.labelLarge(
          //                         'New Delhi',
          //                         fontWeight: 900,
          //                         fontSize: 15,
          //                         color: Colors.black,
          //                       ),
          //                       FxSpacing.width(10),
          //                       FxText.labelMedium('DEL')
          //                     ],
          //                   ),
          //                   FxText.labelMedium(
          //                       'Chhatrapati Sivaji International Airport'),
          //                 ],
          //               )
          //             ],
          //           ),
          //         ),

          //         FxSpacing.height(20),
          //       ],
          //     ),
          //     Positioned(
          //       // alignment: const Alignment(0, 0.5),
          //       top: 50,
          //       child: SizedBox(
          //         // width: size.width,
          //         width: 40,
          //         height: size.height * 0.06,
          //         child: Card(
          //           elevation: 12,
          //           color: Colors.white,
          //           child: Center(
          //               child: Text('C',
          //                   style: Theme.of(context)
          //                       .textTheme
          //                       .displayMedium)),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          Container(
            // margin: const EdgeInsets.symmetric(horizontal: 20),
            // color: Colors.grey.shade200,
            // borderColor: Colors.amber,
            // border: Border.all(
            //     // color: Colors.grey.shade800,
            //     color: Colors.black,
            //     width: 1),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            // height: 70,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              border: Border.all(color: Colors.black12, width: 1),
            ),
            child: Row(
              children: [
                const Icon(
                  LineIcons.planeDeparture,
                  size: 29,
                ),
                FxSpacing.width(10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.labelMedium('FROM'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FxText.labelLarge(
                          'New Delhi',
                          fontWeight: 900,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        FxSpacing.width(10),
                        FxText.labelMedium('DEL')
                      ],
                    ),
                    FxText.labelMedium(
                        'Chhatrapati Sivaji International Airport'),
                  ],
                )
              ],
            ),
          ),
          FxSpacing.height(20),

          //to
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            // height: 70,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              border: Border.all(color: Colors.black12, width: 1),
            ),
            child: Row(
              children: [
                const Icon(
                  LineIcons.planeArrival,
                  size: 29,
                ),
                FxSpacing.width(10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.labelMedium('TO'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FxText.labelLarge(
                          'New Delhi',
                          fontWeight: 900,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        FxSpacing.width(10),
                        FxText.labelMedium('DEL')
                      ],
                    ),
                    FxText.labelMedium(
                        'Chhatrapati Sivaji International Airport'),
                  ],
                )
              ],
            ),
          ),

          FxSpacing.height(20),

          //departure
          SizedBox(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: controller.showdate,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      // height: 70,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      // width: MediaQuery.of(context).size.width,
                      width: customwidth,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                        border: Border.all(color: Colors.black12, width: 1),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            LineIcons.calendar,
                            size: 29,
                          ),
                          FxSpacing.width(10),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FxText.labelMedium('DEPARTURE DATE'),
                                SizedBox(
                                  // height: 200,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child:
                                            controller.selectedDateRange == null
                                                ? FxText.labelLarge(
                                                    formattedDate,
                                                    fontWeight: 900,
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  )
                                                : FxText.labelLarge(
                                                    // '30 Mar',
                                                    // formattedStartDate,
                                                    // '${controller.selectedDateRange?.start.toString().split(' ')[0]}',
                                                    '${controller.selectedDateRange?.start.monthName.substring(0, 3)} ${controller.selectedDateRange?.start.day}',
                                                    fontWeight: 900,
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                      ),
                                      FxSpacing.width(10),
                                      Expanded(
                                          flex: 1,
                                          child: controller.selectedDateRange ==
                                                  null
                                              ? FxText.labelMedium(
                                                  formattedYear)
                                              : FxText.labelMedium(
                                                  '${controller.selectedDateRange?.start.day} ${controller.selectedDateRange?.start.year}',
                                                ))
                                    ],
                                  ),
                                ),
                                // RichText(
                                //   text: const TextSpan(
                                //     style: TextStyle(
                                //         color: Colors.black,
                                //         fontSize: 36),
                                //     children: <TextSpan>[
                                //       TextSpan(
                                //           text: '30 Mar ',
                                //           style: TextStyle(
                                //               fontWeight:
                                //                   FontWeight.w900,
                                //               fontSize: 15,
                                //               color: Colors.black)),
                                //       TextSpan(
                                //           text: 'Thu, 2023',
                                //           style: TextStyle(
                                //               fontWeight:
                                //                   FontWeight.w500,
                                //               fontSize: 15,
                                //               color: Colors.grey))
                                //     ],
                                //   ),
                                //   // textScaleFactor: 0.5,
                                // )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // FxSpacing.width(10),
                Expanded(
                  child: controller.selectedDateRange == null
                      ? GestureDetector(
                          // onTap: () {
                          //   controller.returndate == '1';
                          //   setState(() {});
                          //   log('return1:${controller.returndate}');
                          // },
                          onTap: controller.showdate,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 20),
                            // height: 70,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            // width: MediaQuery.of(context).size.width,
                            width: customwidth,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7)),
                              border:
                                  Border.all(color: Colors.black12, width: 1),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      color: Colors.blue,
                                      size: 15,
                                    ),
                                    FxText.labelMedium(
                                      'ADD RETURN DATE',
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                                FxText.labelMedium(
                                    'Save more on round trips!!'),
                              ],
                            ),
                          ),
                        )
                      : GestureDetector(
                          // onTap: () {
                          //   controller.returndate == '2';
                          //   setState(() {});
                          //   log('return 2:${controller.returndate}');
                          // },
                          onTap: controller.showdate,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 10, right: 20),
                                // height: 70,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                // width: MediaQuery.of(context).size.width,
                                width: customwidth,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7)),
                                  border: Border.all(
                                      color: Colors.black12, width: 1),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FxText.labelMedium('RETURN DATE'),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        FxText.labelLarge(
                                          '${controller.selectedDateRange?.end.monthName.substring(0, 3)} ${controller.selectedDateRange?.end.day}',
                                          fontWeight: 900,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                        FxSpacing.width(10),
                                        FxText.labelMedium(
                                          '${controller.selectedDateRange?.end.day} ${controller.selectedDateRange?.end.year}',
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Align(
                                    alignment: Alignment.topRight,
                                    child: CircleAvatar(
                                      key: Key('closeIconKey'),
                                      radius: 10,
                                      backgroundColor: Colors.grey,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.indigo,
                                        size: 15,
                                      ),
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
          ),
          FxSpacing.height(20),

          GestureDetector(
            onTap: () async {
              var data = await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext buildContext) {
                    return TravellerclassSheet(
                        // categoryplace: widget.place,
                        );
                  });
              setState(() {
                // controller.allattractionList = [];
                // controller.allattractionList = [data];
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              // height: 70,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: Colors.black12, width: 1),
              ),
              child: Row(
                children: [
                  const Icon(
                    LineIcons.user,
                    size: 29,
                  ),
                  FxSpacing.width(10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText.labelMedium('TRAVELLERS & CLASS'),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FxText.labelLarge(
                            '1',
                            fontWeight: 900,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          FxSpacing.width(10),
                          FxText.labelMedium('Economy/Premium Economy')
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          FxSpacing.height(20),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xff1529e8),
                  Color(0xff5c69e0),
                ],
              ),
            ),
            child: Center(
              child: FxText.bodyMedium(
                'Search Flights',
                color: Colors.white,
                // color: customTheme.estateOnPrimary,
                fontWeight: 700,
                fontSize: 20,
              ),
            ),
          ),

          UpcomingFlights()

          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //       horizontal: 20.0, vertical: 15),
          //   child: FxButton.block(
          //     onPressed: () {},
          //     backgroundColor: const Color(0xff1529e8),
          //     // backgroundColor: customTheme.estatePrimary,
          //     borderRadiusAll: 12,

          //     elevation: 0,
          //     child: FxText.bodyMedium(
          //       'Search Flights',
          //       color: Colors.white,
          //       // color: customTheme.estateOnPrimary,
          //       fontWeight: 700,
          //     ),
          //   ),
          // ),
        ]);
  }
}
