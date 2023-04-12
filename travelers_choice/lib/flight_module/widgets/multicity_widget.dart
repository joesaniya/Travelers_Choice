import 'dart:developer';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/flight_module/widgets/upcoming_flights.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import '../../theme/app_theme.dart';
import '../bottomsheet/Traveller_class_Sheet.dart';
import '../controller/Multi_city_controller.dart';
import 'add_city_widgets.dart';

class MultiCityWidgets extends StatefulWidget {
  const MultiCityWidgets({super.key});

  @override
  State<MultiCityWidgets> createState() => _MultiCityWidgetsState();
}

class _MultiCityWidgetsState extends State<MultiCityWidgets>
    with TickerProviderStateMixin {
  late CustomTheme customTheme;
  late ThemeData theme, theme1;
  late MultiCityController controller;
  // late RoundTripController controller;
  double? customwidth;

  final List<String> _textFields = [''];

  @override
  void initState() {
    super.initState();

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(MultiCityController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    customwidth = MediaQuery.of(context).size.width / 2;
    final size = MediaQuery.of(context).size;
    return FxBuilder<MultiCityController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  //demo

  List<Widget> containers = [];
  static List<String> friendsList = [];

  List<Widget> _getcity() {
    log('calling get city');
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < friendsList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(
                child: AddCityWidgets(
              index: i,
            )),
            const SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(i == friendsList.length - 1, i),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          friendsList.insert(0, '');
        } else {
          friendsList.removeAt(index);
        }
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.indigo,
        ),
      ),
    );
  }

  Widget _buildBody() {
    DateTime newdate = DateTime.now();
    String formattedDate2 = DateFormat.MMMd().format(newdate);
    DateTime newdate2 = controller.selectedValue;
    String calendarDate2 = DateFormat.MMMd().format(newdate2);
    String formattedYear = DateFormat('EEEE, yyyy').format(newdate);
    String formattedYeardate = DateFormat('EEEE, yyyy').format(newdate2);
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.start,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FxText.labelMedium('FROM'),
                  ),
                  FxSpacing.height(5),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    // height: 70,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      border: Border.all(color: Colors.black12, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.labelLarge(
                          'BLR',
                          fontWeight: 900,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        FxSpacing.height(5),
                        FxText.labelMedium('Bengaluru'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FxText.labelMedium('TO'),
                  ),
                  FxSpacing.height(5),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    // height: 70,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      border: Border.all(color: Colors.black12, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.labelLarge(
                          'BLR',
                          fontWeight: 900,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        FxSpacing.height(5),
                        FxText.labelMedium('Bengaluru'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.adddate
                      ? controller.cartController.reverse()
                      : controller.cartController.forward();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: FxText.labelMedium('DATE'),
                    ),
                    FxSpacing.height(5),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      // height: 70,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                        border: Border.all(color: Colors.black12, width: 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.selectedValue == null
                              ? FxText.labelLarge(
                                  formattedDate2,
                                  fontWeight: 900,
                                  fontSize: 15,
                                  color: Colors.black,
                                )
                              : FxText.labelLarge(
                                  calendarDate2,
                                  fontWeight: 900,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                          FxSpacing.height(5),
                          controller.selectedValue == null
                              ? FxText.labelMedium(formattedYear)
                              : FxText.labelMedium(formattedYeardate)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

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

        //dynamic
        // ..._getcity(),
        for (int i = 0; i < _textFields.length; i++)
          // TextField(
          //   decoration: InputDecoration(
          //     labelText: 'Text Field ${i + 1}',
          //     suffixIcon: IconButton(
          //       icon: const Icon(Icons.remove_circle_outline),
          //       onPressed: () {
          //         setState(() {
          //           // remove the text field from the list
          //           _textFields.removeAt(i);
          //         });
          //       },
          //     ),
          //   ),
          //   onChanged: (value) {
          //     // update the value of the text field in the list
          //     _textFields[i] = value;
          //   },
          // ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    // height: 70,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      border: Border.all(color: Colors.black12, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.labelLarge(
                          'BLR',
                          fontWeight: 900,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        // TextFormField(
                        //   keyboardType: TextInputType.none,
                        //   showCursor: false,
                        //   readOnly: true,
                        //   decoration: const InputDecoration(
                        //     isDense: true,
                        //     contentPadding: EdgeInsets.symmetric(
                        //         horizontal: 0, vertical: 0),
                        //     border: InputBorder.none,
                        //     focusedBorder: InputBorder.none,
                        //     enabledBorder: InputBorder.none,
                        //     errorBorder: InputBorder.none,
                        //     disabledBorder: InputBorder.none,
                        //     labelText: 'BLR',
                        //     labelStyle: TextStyle(
                        //       fontWeight: FontWeight.w900,
                        //       fontSize: 15,
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        //   onChanged: (value) {
                        //     // update the value of the text field in the list
                        //     _textFields[i] = value;
                        //   },
                        // ),

                        FxSpacing.height(5),
                        FxText.labelMedium('Bengaluru'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    // height: 70,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      border: Border.all(color: Colors.black12, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.labelLarge(
                          'BLR',
                          fontWeight: 900,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        FxSpacing.height(5),
                        FxText.labelMedium('Bengaluru'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.adddate
                          ? controller.cartController.reverse()
                          : controller.cartController.forward();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      // height: 70,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                        border: Border.all(color: Colors.black12, width: 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.selectedValue == null
                              ? FxText.labelLarge(
                                  formattedDate2,
                                  fontWeight: 900,
                                  fontSize: 15,
                                  color: Colors.black,
                                )
                              : FxText.labelLarge(
                                  calendarDate2,
                                  fontWeight: 900,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                          FxSpacing.height(5),
                          controller.selectedValue == null
                              ? FxText.labelMedium(formattedYear)
                              : FxText.labelMedium(formattedYeardate)
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    setState(() {
                      // remove the text field from the list
                      _textFields.removeAt(i);
                    });
                  },
                ),
              ],
            ),
          ),

        // Column(
        //   children: [
        //     GestureDetector(
        //       onTap: () {
        //         setState(() {
        //           containers.add(Container(
        //             height: 100,
        //             width: 100,
        //             color: Colors.blue,
        //             child: GestureDetector(
        //               onTap: () {
        //                 setState(() {
        //                   containers.removeAt(
        //                       containers.indexOf(containers as Widget));
        //                 });
        //               },
        //               child: const Icon(Icons.close),
        //             ),
        //           ));
        //         });
        //       },
        //       child: const Text('Add Container'),
        //     ),
        //     Column(children: containers),
        //   ],
        // ),

        FxSpacing.height(20),

        //add dotted
        GestureDetector(
          onTap: () {
            setState(() {
              // add a new text field to the list
              _textFields.add('');
            });
          },
          child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 20), //padding of outer Container
              child: DottedBorder(
                color: Colors.blue, //color of dotted/dash line
                strokeWidth: 2, //thickness of dash/dots
                dashPattern: const [5, 6],
                //dash patterns, 10 is dash width, 6 is space width
                child: Container(
                  //inner container
                  height: 40, //height of inner container
                  width: double
                      .infinity, //width to 100% match to parent container.
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                      FxSpacing.width(5),
                      FxText.labelLarge(
                        'ADD CITY',
                        fontWeight: 900,
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              )),
        ),

        FxSpacing.height(20),

        //BOOTOM
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
        ),

        // const TextField(
        //   keyboardType: TextInputType.none,
        //   showCursor: false,
        //   readOnly: true,
        // ),

        // TextFormField(
        //   showCursor: true,
        //   readOnly: true,
        // ),
        const UpcomingFlights()
      ],
    );
  }
}
