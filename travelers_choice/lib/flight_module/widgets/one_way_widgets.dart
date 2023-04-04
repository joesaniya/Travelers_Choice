import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/models/tickets.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'dart:developer';
import '../../theme/app_theme.dart';
import '../bottomsheet/Traveller_class_Sheet.dart';
import '../controller/one_way_controller.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import '..//utils/app_layout.dart';
import '../utils/app_styles.dart';
import 'package:gap/gap.dart';

import 'circula_container.dart';

class OneWayWidgets extends StatefulWidget {
  const OneWayWidgets({super.key});

  @override
  State<OneWayWidgets> createState() => _OneWayWidgetsState();
}

class _OneWayWidgetsState extends State<OneWayWidgets>
    with TickerProviderStateMixin {
  late CustomTheme customTheme;
  late ThemeData theme, theme1;
  late OneWayController controller;
  // late OneWayController controller;
  double? customwidth;

  @override
  void initState() {
    super.initState();

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(OneWayController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    customwidth = MediaQuery.of(context).size.width / 2;
    final size = MediaQuery.of(context).size;
    return FxBuilder<OneWayController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  bool? iscolorful;
  Widget _buildProductList() {
    final size = Applayout.getsize(context);
    List<Widget> list = [];

    for (Tickets ticket1 in controller.tickets!) {
      list.add(FadeTransition(
          opacity: controller.fadeAnimation,
          child: SizedBox(
            // width: size.width * 0.85,
            width: MediaQuery.of(context).size.width,
            height: 169,
            child: Container(
              // margin: const EdgeInsets.only(left: 16),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(21),
                            topRight: Radius.circular(21)),
                        color: iscolorful == null
                            ? const Color(0xff1529e8).withAlpha(40)
                            // const Color(0xFF526799)
                            : Colors.white),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            FxText.bodyMedium(
                              // "${ticket_map["from"]["code"]}",
                              ticket1.fcode,
                              color: const Color(0xff1529e8),
                              fontWeight: 900,
                              // style: iscolorful == null
                              //     ? Styles.headlinestyle3
                              //         .copyWith(color: Colors.white)
                              //     : Styles.headlinestyle3,
                            ),
                            Expanded(child: Container()),
                            CircularContainer(
                              iscolorful: true,
                            ),
                            Expanded(
                                child: Stack(
                              children: [
                                SizedBox(
                                    height: 24,
                                    child: LayoutBuilder(
                                      builder: (BuildContext context,
                                          BoxConstraints constraints) {
                                        return Flex(
                                          direction: Axis.horizontal,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: List.generate(
                                              (constraints.constrainWidth() / 6)
                                                  .floor(),
                                              (index) => Text(
                                                    "-",
                                                    style: TextStyle(
                                                        color:
                                                            iscolorful == null
                                                                ? Colors.black
                                                                // Colors.white
                                                                : Colors.grey
                                                                    .shade300),
                                                  )),
                                        );
                                      },
                                    )),
                                Center(
                                  child: Transform.rotate(
                                    angle: 1.5,
                                    child: Icon(
                                      Icons.local_airport_outlined,
                                      color: iscolorful == null
                                          ? Colors.black
                                          // Colors.white
                                          : const Color(0xFF8ACCF7),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            CircularContainer(
                              iscolorful: true,
                            ),
                            const Spacer(),
                            FxText.bodyMedium(
                              // "${ticket_map["to"]["code"]}",
                              ticket1.fcode,
                              color: const Color(0xff1529e8),
                              fontWeight: 900,
                              // style: iscolorful == null
                              //     ? Styles.headlinestyle3
                              //         .copyWith(color: Colors.white)
                              //     : Styles.headlinestyle3,
                            )
                          ],
                        ),
                        const Gap(3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FxText.bodyMedium(
                              // "${ticket_map["from"]["name"]}",
                              ticket1.fname,
                              color: const Color(0xff1529e8),
                              fontWeight: 900,
                              // style: iscolorful == null
                              //     ? Styles.headlinestyle4
                              //         .copyWith(color: Colors.white)
                              //     : Styles.headlinestyle4,
                            ),
                            FxText.bodyMedium(
                              // "${ticket_map["flying_time"]}",
                              // ticket1.flyingtime,
                              '8h 40m',
                              color: const Color(0xff1529e8),
                              fontWeight: 900,
                              // style: iscolorful == null
                              //     ? Styles.headlinestyle4
                              //         .copyWith(color: Colors.white)
                              //     : Styles.headlinestyle4,
                            ),
                            FxText.bodyMedium(
                              // "${ticket_map["to"]["name"]}",
                              ticket1.fname,
                              color: const Color(0xff1529e8),
                              fontWeight: 900,
                              // style: iscolorful == null
                              //     ? Styles.headlinestyle4
                              //         .copyWith(color: Colors.white)
                              //     : Styles.headlinestyle4,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: iscolorful == null
                        ? const Color(0xff1529e8)
                        // Styles.orangecolor
                        : Colors.white,
                    child: Row(
                      children: [
                        const SizedBox(
                          height: 20,
                          width: 10,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                    (constraints.constrainWidth() / 15).floor(),
                                    (index) => SizedBox(
                                          height: 1,
                                          width: 5,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: iscolorful == null
                                                    ? Colors.white
                                                    : Colors.grey.shade300),
                                          ),
                                        )),
                              );
                            },
                          ),
                        )),
                        const SizedBox(
                          height: 20,
                          width: 10,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: iscolorful == null
                                ? const Radius.circular(21)
                                : const Radius.circular(0),
                            bottomRight: iscolorful == null
                                ? const Radius.circular(21)
                                : const Radius.circular(0)),
                        color: iscolorful == null
                            ? const Color(0xff1529e8)
                            // Styles.orangecolor
                            : Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              // "${ticket_map["date"]}",
                              ticket1.dateflight,
                              style: iscolorful == null
                                  ? Styles.headlinestyle3
                                      .copyWith(color: Colors.white)
                                  : Styles.headlinestyle3,
                            ),
                            Text("Date",
                                style: iscolorful == null
                                    ? Styles.headlinestyle4
                                        .copyWith(color: Colors.white)
                                    : Styles.headlinestyle4),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                                // "${ticket_map["departure_time"]}",
                                ticket1.departuretime,
                                style: iscolorful == null
                                    ? Styles.headlinestyle3
                                        .copyWith(color: Colors.white)
                                    : Styles.headlinestyle3),
                            Text("Departure Time",
                                style: iscolorful == null
                                    ? Styles.headlinestyle4
                                        .copyWith(color: Colors.white)
                                    : Styles.headlinestyle4),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                                // "${ticket_map["number"]}",
                                ticket1.number.toString(),
                                style: iscolorful == null
                                    ? Styles.headlinestyle4
                                        .copyWith(color: Colors.white)
                                    : Styles.headlinestyle3),
                            Text("Number",
                                style: iscolorful == null
                                    ? Styles.headlinestyle4
                                        .copyWith(color: Colors.white)
                                    : Styles.headlinestyle4),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )));
    }

    return Column(
      children: list,
    );
  }

  Widget _buildBody() {
    DateTime newdate = DateTime.now();
    DateTime newdate2 = controller.selectedValue;
    String formattedYear = DateFormat('EEEE, yyyy').format(newdate);
    String formattedDate2 = DateFormat.MMMd().format(newdate);
    log('date$formattedDate2');
    String formattedYear2 = DateFormat('EEEE, yyyy').format(newdate);

    log('Calener:${controller.selectedValue.toString()}');
    String calendarDate2 = DateFormat.MMMd().format(newdate2);
    String formattedYeardate = DateFormat('EEEE, yyyy').format(newdate2);
    log('date:$calendarDate2');
    log('year:$formattedYeardate');

    return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        // mainAxisAlignment: MainAxisAlignment.start,

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

          GestureDetector(
            onTap: () {
              controller.fromairport();
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
                    // onTap: controller.showdate,
                    onTap: () {
                      // Navigator.of(context, rootNavigator: true)
                      //     .pushReplacement(
                      //   PageRouteBuilder(
                      //       transitionDuration: const Duration(seconds: 2),
                      //       pageBuilder: (_, __, ___) =>
                      //           const CustomDateRange()),
                      // );
                      controller.adddate
                          ? controller.cartController.reverse()
                          : controller.cartController.forward();
                    },
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
                                        child: controller.selectedValue == null
                                            ? FxText.labelLarge(
                                                formattedDate2,
                                                // controller.selectedValue.day
                                                //     .toString(),
                                                // calendarDate2,
                                                fontWeight: 900,
                                                fontSize: 15,
                                                color: Colors.black,
                                              )
                                            : FxText.labelLarge(
                                                // '30 Mar',
                                                // formattedDate2,
                                                calendarDate2,
                                                // '${controller.selectedDateRange?.start.toString().split(' ')[0]}',
                                                // '${controller.selectedDateRange?.start.monthName.substring(0, 3)} ${controller.selectedDateRange?.start.day}',
                                                fontWeight: 900,
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                      ),
                                      FxSpacing.width(10),
                                      Expanded(
                                          flex: 1,
                                          child:
                                              controller.selectedValue == null
                                                  ? FxText.labelMedium(
                                                      formattedYear)
                                                  : FxText.labelMedium(
                                                      formattedYeardate))
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

                // ),
              ],
            ),
          ),
          FxSpacing.height(20),

          //atetime
          // const Text("You Selected:"),
          // const Padding(
          //   padding: EdgeInsets.all(10),
          // ),
          // Text(controller.selectedValue.toString()),
          // const Padding(
          //   padding: EdgeInsets.all(20),
          // ),
          controller.adddate
              ? Container(
                  child: DatePicker(
                    DateTime.now(),
                    width: 60,
                    height: 80,
                    controller: controller.datetimecontroller,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: const Color(0xff1529e8),
                    selectedTextColor: Colors.white,
                    // inactiveDates: [
                    //   DateTime.now().add(const Duration(days: 3)),
                    //   DateTime.now().add(const Duration(days: 4)),
                    //   DateTime.now().add(const Duration(days: 7))
                    // ],
                    onDateChange: (date) {
                      // New date selected
                      setState(() {
                        controller.selectedValue = date;
                        controller.adddate
                            ? controller.cartController.reverse()
                            : controller.cartController.forward();
                        log('value:${controller.selectedValue}');
                      });
                    },
                  ),
                )
              : const SizedBox(),
          controller.adddate ? FxSpacing.height(20) : const SizedBox(),
          GestureDetector(
            onTap: () async {
              var data = await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext buildContext) {
                    return const TravellerclassSheet(
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

          GestureDetector(
            onTap: () {
              controller.searchflights();
            },
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
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
          ),

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

          //flight list
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //       children: ticketList
          //           .map((ticketinfomap) =>
          //               TicketView(ticket_map: ticketinfomap))
          //           .toList()),
          // ),

          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: FxText.bodyLarge(
                'UPCOMING FLIGHTS',
                fontWeight: 900,
              )),
          FxSpacing.height(7),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: _buildProductList(),
          ),
        ]);
  }
}
