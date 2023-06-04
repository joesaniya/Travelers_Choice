import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import '../../card_widgets/customsnackbar.dart';
import '../../theme/app_theme.dart';
import '../controller/person_seat_controller.dart';

class PersonSeat extends StatefulWidget {
  const PersonSeat({super.key});

  @override
  State<PersonSeat> createState() => _PersonSeatState();
}

class _PersonSeatState extends State<PersonSeat> with TickerProviderStateMixin {
  late PersonSeatController controller;
  late ThemeData theme, theme1;
  late CustomTheme customTheme;
  int? defaultChoiceIndex;
  final List<String> _choicesList = [
    'Single',
    'Double',
    'Triple',
  ];

  List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  List<String> dropdownValues = List.generate(3, (index) => 'Option 1');

  @override
  void initState() {
    super.initState();
    defaultChoiceIndex = 0;

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    customTheme = AppTheme.customTheme;
    controller = FxControllerStore.put(PersonSeatController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });
    controller.roomsList.add(RoomsList(adults: 0, children: [], ages: []));
  }

  // List<Widget> _buildType() {
  //   List<String> categoryList = [
  //     "ECom",
  //     "Automobile",
  //     "Crimes",
  //     "Business",
  //     "Fitness",
  //     "Astro",
  //     "Politics",
  //     "Relationship",
  //     "Food",
  //     "Electronics",
  //     "Health",
  //     "Tech",
  //     "Entertainment",
  //     "World",
  //     "Sports",
  //     "Other",
  //   ];

  //   List<Widget> choices = [];
  //   for (var item in categoryList) {
  //     bool selected = searchController.selectedChoices.contains(item);
  //     if (selected) {
  //       choices.add(FxContainer.none(
  //           color: customTheme.homemadePrimary.withAlpha(28),
  //           bordered: true,
  //           borderRadiusAll: 12,
  //           paddingAll: 8,
  //           border: Border.all(color: customTheme.homemadePrimary),
  //           onTap: () {
  //             // searchController.removeChoice(item);
  //           },
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Icon(
  //                 Icons.check,
  //                 size: 14,
  //                 color: customTheme.homemadePrimary,
  //               ),
  //               FxSpacing.width(6),
  //               FxText.bodySmall(
  //                 item,
  //                 fontSize: 11,
  //                 color: customTheme.homemadePrimary,
  //               )
  //             ],
  //           )));
  //     } else {
  //       choices.add(FxContainer.none(
  //         color: customTheme.border,
  //         borderRadiusAll: 12,
  //         padding: FxSpacing.xy(12, 8),
  //         onTap: () {
  //           // searchController.addChoice(item);
  //         },
  //         child: FxText.bodySmall(
  //           item,
  //           color: theme.colorScheme.onBackground,
  //           fontSize: 11,
  //         ),
  //       ));
  //     }
  //   }
  //   return choices;
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<PersonSeatController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget RoomsListUI() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.roomscount,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                // color: Color(0xffe6e1e5),
                color: Colors.white,
                // color: Color(0xffe5fdfd),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey.shade300, width: 1)),
            child: Column(
              children: [
                Center(
                  child: FxText.bodyMedium(
                    'Room $index',
                    fontWeight: 900,
                  ),
                ),
                FxSpacing.height(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FxText.bodyMedium(
                      'Adults',
                      fontWeight: 900,
                    ),
                    Expanded(child: Container()),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xff1529e8)
                          // color:
                          //     Theme.of(context).colorScheme.secondary
                          ),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                controller.adultsdecrement(index);
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 16,
                              )),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            padding: const EdgeInsets.symmetric(
                                // horizontal: 3, vertical: 2
                                horizontal: 10,
                                vertical: 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.white),
                            child: FxText.bodyMedium(
                              controller.roomsList[index].adults.toString(),
                              fontWeight: 700,
                              // style: const TextStyle(
                              //     color: Colors.black, fontSize: 16),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                controller.adultsincrement(index);
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                //infant
                FxSpacing.height(14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.bodyMedium(
                          'Children',
                          fontWeight: 900,
                        ),
                        FxSpacing.height(5),
                        FxText.bodyMedium(
                          'Ages 0-11',
                          fontWeight: 900,
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    // Row(
                    //   children: const [],
                    // )
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xff1529e8)
                          // color:
                          //     Theme.of(context).colorScheme.secondary
                          ),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                controller.childdecrement(
                                  index,
                                );
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 16,
                              )),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            padding: const EdgeInsets.symmetric(
                                // horizontal: 3, vertical: 2
                                horizontal: 10,
                                vertical: 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.white),
                            child: FxText.bodyMedium(
                              controller.childcount.toString(),
                              fontWeight: 700,
                              // style: const TextStyle(
                              //     color: Colors.black, fontSize: 16),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                controller.childincrement(
                                  index,
                                );
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                FxSpacing.height(14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.bodyMedium(
                      'Age of Children',
                      fontWeight: 900,
                    ),
                    Expanded(child: Container()),
                    controller.childcount == 0
                        ? const SizedBox()
                        : Expanded(
                            child: Column(
                              children: [
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: List.generate(controller.childcount,
                                      (index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: theme.cardTheme.color,
                                          // color: const Color(0xff1529e8),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      // height: 45.0,
                                      // width: 80,
                                      height: 50,
                                      width: 100,
                                      margin: const EdgeInsets.only(right: 6),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          isExpanded: true,
                                          hint: Row(
                                            children: [
                                              Expanded(
                                                child: FxText.labelLarge(
                                                  " ",
                                                  fontWeight: 600,
                                                  color: Colors.black,
                                                  // color: theme.colorScheme.onPrimary,
                                                  letterSpacing: 0.4,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: controller.ageCodes
                                              .map((String value) {
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

                                          value: controller.selectedage,
                                          onChanged: (value) {
                                            setState(() {
                                              controller.selectedage =
                                                  value.toString();
                                            });
                                          },

                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          iconSize: 20,
                                          iconEnabledColor: Colors.black,
                                          iconDisabledColor: Colors.black,
                                          buttonHeight: 30,
                                          buttonWidth: 200,
                                          buttonPadding: const EdgeInsets.only(
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
                                          // itemWidth: 200,
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
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ],
            ),
          );
        });
    // return Column(
    //   children: List.generate(controller.roomscount, (index) {
    //     return Container(
    //       margin: const EdgeInsets.all(5.0),
    //       padding: const EdgeInsets.all(5.0),
    //       decoration: BoxDecoration(
    //           // color: Color(0xffe6e1e5),
    //           color: Colors.white,
    //           // color: Color(0xffe5fdfd),
    //           borderRadius: const BorderRadius.all(Radius.circular(10)),
    //           border: Border.all(color: Colors.grey.shade300, width: 1)),
    //       child: Column(
    //         children: [
    //           Center(
    //             child: FxText.bodyMedium(
    //               'Room $index',
    //               fontWeight: 900,
    //             ),
    //           ),
    //           FxSpacing.height(20),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               FxText.bodyMedium(
    //                 'Adults',
    //                 fontWeight: 900,
    //               ),
    //               Expanded(child: Container()),

    //               Container(
    //                 padding: const EdgeInsets.all(10),
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(5),
    //                     color: const Color(0xff1529e8)
    //                     // color:
    //                     //     Theme.of(context).colorScheme.secondary
    //                     ),
    //                 child: Row(
    //                   children: [
    //                     InkWell(
    //                         onTap: () {
    //                           controller.adultsdecrement();
    //                         },
    //                         child: const Icon(
    //                           Icons.remove,
    //                           color: Colors.white,
    //                           size: 16,
    //                         )),
    //                     Container(
    //                       margin: const EdgeInsets.symmetric(horizontal: 3),
    //                       padding: const EdgeInsets.symmetric(
    //                           // horizontal: 3, vertical: 2
    //                           horizontal: 10,
    //                           vertical: 7),
    //                       decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.circular(3),
    //                           color: Colors.white),
    //                       child: FxText.bodyMedium(
    //                         // '3',
    //                         controller.adultscount.toString(),
    //                         fontWeight: 700,
    //                         // style: const TextStyle(
    //                         //     color: Colors.black, fontSize: 16),
    //                       ),
    //                     ),
    //                     InkWell(
    //                         onTap: () {
    //                           controller.adultsincrement(index);
    //                         },
    //                         child: const Icon(
    //                           Icons.add,
    //                           color: Colors.white,
    //                           size: 16,
    //                         )),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),

    //           //infant
    //           FxSpacing.height(14),

    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   FxText.bodyMedium(
    //                     'Children',
    //                     fontWeight: 900,
    //                   ),
    //                   FxSpacing.height(5),
    //                   FxText.bodyMedium(
    //                     'Ages 0-11',
    //                     fontWeight: 900,
    //                   ),
    //                 ],
    //               ),
    //               Expanded(child: Container()),
    //               // Row(
    //               //   children: const [],
    //               // )
    //               Container(
    //                 padding: const EdgeInsets.all(10),
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(5),
    //                     color: const Color(0xff1529e8)
    //                     // color:
    //                     //     Theme.of(context).colorScheme.secondary
    //                     ),
    //                 child: Row(
    //                   children: [
    //                     InkWell(
    //                         onTap: () {
    //                           controller.childdecrement();
    //                         },
    //                         child: const Icon(
    //                           Icons.remove,
    //                           color: Colors.white,
    //                           size: 16,
    //                         )),
    //                     Container(
    //                       margin: const EdgeInsets.symmetric(horizontal: 3),
    //                       padding: const EdgeInsets.symmetric(
    //                           // horizontal: 3, vertical: 2
    //                           horizontal: 10,
    //                           vertical: 7),
    //                       decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.circular(3),
    //                           color: Colors.white),
    //                       child: FxText.bodyMedium(
    //                         controller.childcount.toString(),
    //                         fontWeight: 700,
    //                         // style: const TextStyle(
    //                         //     color: Colors.black, fontSize: 16),
    //                       ),
    //                     ),
    //                     InkWell(
    //                         onTap: () {
    //                           controller.childincrement();
    //                         },
    //                         child: const Icon(
    //                           Icons.add,
    //                           color: Colors.white,
    //                           size: 16,
    //                         )),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),

    //           FxSpacing.height(14),

    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               FxText.bodyMedium(
    //                 'Age of Children',
    //                 fontWeight: 900,
    //               ),
    //               Expanded(child: Container()),
    //               controller.childcount == 0
    //                   ? const SizedBox()
    //                   : Expanded(
    //                       child: Column(
    //                         children: [
    //                           Wrap(
    //                             spacing: 10,
    //                             runSpacing: 10,
    //                             children: List.generate(controller.childcount,
    //                                 (index) {
    //                               return Container(
    //                                 decoration: BoxDecoration(
    //                                     color: theme.cardTheme.color,
    //                                     // color: const Color(0xff1529e8),
    //                                     borderRadius: BorderRadius.circular(4)),
    //                                 // height: 45.0,
    //                                 // width: 80,
    //                                 height: 50,
    //                                 width: 100,
    //                                 margin: const EdgeInsets.only(right: 6),
    //                                 child: DropdownButtonHideUnderline(
    //                                   child: DropdownButton2(
    //                                     isExpanded: true,
    //                                     hint: Row(
    //                                       children: [
    //                                         Expanded(
    //                                           child: FxText.labelLarge(
    //                                             " ",
    //                                             fontWeight: 600,
    //                                             color: Colors.black,
    //                                             // color: theme.colorScheme.onPrimary,
    //                                             letterSpacing: 0.4,
    //                                           ),
    //                                         ),
    //                                       ],
    //                                     ),
    //                                     items: controller.ageCodes
    //                                         .map((String value) {
    //                                       return DropdownMenuItem<String>(
    //                                           value: value,
    //                                           child: Center(
    //                                             child: Text(
    //                                               value,
    //                                               style:
    //                                                   FxTextStyle.bodyMedium(),
    //                                             ),
    //                                           ));
    //                                     }).toList(),

    //                                     value: controller.selectedage,
    //                                     onChanged: (value) {
    //                                       setState(() {
    //                                         controller.selectedage =
    //                                             value.toString();
    //                                       });
    //                                     },

    //                                     icon: const Icon(Icons.arrow_drop_down),
    //                                     iconSize: 20,
    //                                     iconEnabledColor: Colors.black,
    //                                     iconDisabledColor: Colors.black,
    //                                     buttonHeight: 30,
    //                                     buttonWidth: 200,
    //                                     buttonPadding: const EdgeInsets.only(
    //                                         left: 14,
    //                                         right: 14,
    //                                         top: 4,
    //                                         bottom: 4),
    //                                     dropdownDecoration: BoxDecoration(
    //                                       borderRadius:
    //                                           BorderRadius.circular(4),
    //                                       color: Colors.white,
    //                                     ),
    //                                     buttonDecoration: BoxDecoration(
    //                                       borderRadius:
    //                                           BorderRadius.circular(10),
    //                                       color: theme.cardTheme.color,
    //                                     ),

    //                                     itemHeight: 40,
    //                                     // itemWidth: 200,
    //                                     itemPadding: const EdgeInsets.only(
    //                                         left: 14, right: 14),
    //                                     dropdownMaxHeight: 200,
    //                                     dropdownPadding: null,

    //                                     scrollbarRadius:
    //                                         const Radius.circular(40),
    //                                     scrollbarThickness: 2,
    //                                     scrollbarAlwaysShow: true,
    //                                     offset: const Offset(0, 0),
    //                                   ),
    //                                 ),
    //                               );
    //                             }),
    //                           ),
    //                         ],
    //                       ),
    //                     ),

    //               // controller.childcount == 0
    //               //     ? const SizedBox()
    //               //     : Container(
    //               //         decoration: BoxDecoration(
    //               //             color: theme.cardTheme.color,
    //               //             // color: const Color(0xff1529e8),
    //               //             borderRadius: BorderRadius.circular(4)),
    //               //         // height: 45.0,
    //               //         // width: 80,
    //               //         height: 50,
    //               //         width: 100,
    //               //         child: DropdownButtonHideUnderline(
    //               //           child: DropdownButton2(
    //               //             isExpanded: true,
    //               //             hint: Row(
    //               //               children: [
    //               //                 Expanded(
    //               //                   child: FxText.labelLarge(
    //               //                     " ",
    //               //                     fontWeight: 600,
    //               //                     color: Colors.black,
    //               //                     // color: theme.colorScheme.onPrimary,
    //               //                     letterSpacing: 0.4,
    //               //                   ),
    //               //                 ),
    //               //               ],
    //               //             ),
    //               //             items: controller.ageCodes
    //               //                 .map((String value) {
    //               //               return DropdownMenuItem<String>(
    //               //                   value: value,
    //               //                   child: Center(
    //               //                     child: Text(
    //               //                       value,
    //               //                       style:
    //               //                           FxTextStyle.bodyMedium(),
    //               //                     ),
    //               //                   ));
    //               //             }).toList(),

    //               //             value: controller.selectedage,
    //               //             onChanged: (value) {
    //               //               setState(() {
    //               //                 controller.selectedage =
    //               //                     value.toString();
    //               //               });
    //               //             },

    //               //             icon: const Icon(Icons.arrow_drop_down),
    //               //             iconSize: 20,
    //               //             iconEnabledColor: Colors.black,
    //               //             iconDisabledColor: Colors.black,
    //               //             buttonHeight: 30,
    //               //             buttonWidth: 200,
    //               //             buttonPadding: const EdgeInsets.only(
    //               //                 left: 14,
    //               //                 right: 14,
    //               //                 top: 4,
    //               //                 bottom: 4),
    //               //             dropdownDecoration: BoxDecoration(
    //               //               borderRadius:
    //               //                   BorderRadius.circular(4),
    //               //               color: Colors.white,
    //               //             ),
    //               //             buttonDecoration: BoxDecoration(
    //               //               borderRadius:
    //               //                   BorderRadius.circular(10),
    //               //               color: theme.cardTheme.color,
    //               //             ),

    //               //             itemHeight: 40,
    //               //             // itemWidth: 200,
    //               //             itemPadding: const EdgeInsets.only(
    //               //                 left: 14, right: 14),
    //               //             dropdownMaxHeight: 200,
    //               //             dropdownPadding: null,

    //               //             scrollbarRadius:
    //               //                 const Radius.circular(40),
    //               //             scrollbarThickness: 2,
    //               //             scrollbarAlwaysShow: true,
    //               //             offset: const Offset(0, 0),
    //               //           ),
    //               //         ),
    //               //       ),
    //               // //wrap
    //             ],
    //           ),
    //         ],
    //       ),
    //     );
    //   }),
    // );
  }

  Widget _buildBody() {
    return Container(
      height: MediaQuery.of(context).size.height * 85 / 100,
      padding: FxSpacing.xy(24, 16),
      decoration: const BoxDecoration(
          // color: customTheme.card,
          color: Color(0xfff5f5f5),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FxText.bodyLarge(
                'SELECT ROOMS AND GUESTS',
                fontWeight: 800,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  FeatherIcons.x,
                ),
              )
            ],
          ),
          FxSpacing.height(10),
          Expanded(
            child: Container(
              padding: FxSpacing.xy(10, 6),
              decoration: const BoxDecoration(
                  // color: customTheme.card,
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        FxSpacing.height(24),
                        FxText.bodyLarge(
                          'ADD GUESTS',
                          letterSpacing: 0,
                          fontWeight: 600,
                          decoration: TextDecoration.underline,
                        ),

                        FxSpacing.height(14),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FxText.bodyMedium(
                              'Rooms',
                              fontWeight: 900,
                            ),
                            Expanded(child: Container()),
                            // Row(
                            //   children: const [],
                            // )
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xff1529e8)
                                  // color:
                                  //     Theme.of(context).colorScheme.secondary
                                  ),
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        controller.roomsdecrement();
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 16,
                                      )),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    padding: const EdgeInsets.symmetric(
                                        // horizontal: 3, vertical: 2
                                        horizontal: 10,
                                        vertical: 7),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.white),
                                    child: FxText.bodyMedium(
                                      // '3',
                                      controller.roomscount.toString(),
                                      fontWeight: 700,
                                      // style: const TextStyle(
                                      //     color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        controller.roomsincrement();
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 16,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),

                        //children
                        FxSpacing.height(14),

                        RoomsListUI(),
//                         controller.childcount == 0
//                             ? const SizedBox()
//                             : Wrap(
//                                 spacing: 10,
//                                 runSpacing: 10,
//                                 children: List.generate(controller.childcount,
//                                     (index) {
//                                   return Container(
//                                     decoration: BoxDecoration(
//                                         color: theme.cardTheme.color,
//                                         // color: const Color(0xff1529e8),
//                                         borderRadius: BorderRadius.circular(4)),
//                                     // height: 45.0,
//                                     // width: 80,
//                                     height: 50,
//                                     width: 100,
//                                     margin: const EdgeInsets.only(right: 6),
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton2(
//                                         isExpanded: true,
//                                         hint: Row(
//                                           children: [
//                                             Expanded(
//                                               child: FxText.labelLarge(
//                                                 " ",
//                                                 fontWeight: 600,
//                                                 color: Colors.black,
//                                                 // color: theme.colorScheme.onPrimary,
//                                                 letterSpacing: 0.4,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         items: controller.ageCodes
//                                             .map((String value) {
//                                           return DropdownMenuItem<String>(
//                                               value: value,
//                                               child: Center(
//                                                 child: Text(
//                                                   value,
//                                                   style:
//                                                       FxTextStyle.bodyMedium(),
//                                                 ),
//                                               ));
//                                         }).toList(),

//                                         value: controller.selectedage,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             controller.selectedage =
//                                                 value.toString();
//                                           });
//                                         },

//                                         icon: const Icon(Icons.arrow_drop_down),
//                                         iconSize: 20,
//                                         iconEnabledColor: Colors.black,
//                                         iconDisabledColor: Colors.black,
//                                         buttonHeight: 30,
//                                         buttonWidth: 200,
//                                         buttonPadding: const EdgeInsets.only(
//                                             left: 14,
//                                             right: 14,
//                                             top: 4,
//                                             bottom: 4),
//                                         dropdownDecoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                         buttonDecoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           color: theme.cardTheme.color,
//                                         ),

//                                         itemHeight: 40,
//                                         // itemWidth: 200,
//                                         itemPadding: const EdgeInsets.only(
//                                             left: 14, right: 14),
//                                         dropdownMaxHeight: 200,
//                                         dropdownPadding: null,

//                                         scrollbarRadius:
//                                             const Radius.circular(40),
//                                         scrollbarThickness: 2,
//                                         scrollbarAlwaysShow: true,
//                                         offset: const Offset(0, 0),
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                               ),

// // //demo
// //                         controller.childcount == 0
// //                             ? const SizedBox()
// //                             : Wrap(
// //                                 spacing: 10,
// //                                 runSpacing: 10,
// //                                 children: List.generate(controller.childcount,
// //                                     (index) {
// //                                   return Container(
// //                                     decoration: BoxDecoration(
// //                                         color: theme.cardTheme.color,
// //                                         // color: const Color(0xff1529e8),
// //                                         borderRadius: BorderRadius.circular(4)),
// //                                     // height: 45.0,
// //                                     // width: 80,
// //                                     height: 50,
// //                                     width: 100,
// //                                     margin: const EdgeInsets.only(right: 6),
// //                                     child: DropdownButtonHideUnderline(
// //                                       child: DropdownButton2(
// //                                         isExpanded: true,
// //                                         hint: Row(
// //                                           children: [
// //                                             Expanded(
// //                                               child: FxText.labelLarge(
// //                                                 " ",
// //                                                 fontWeight: 600,
// //                                                 color: Colors.black,
// //                                                 // color: theme.colorScheme.onPrimary,
// //                                                 letterSpacing: 0.4,
// //                                               ),
// //                                             ),
// //                                           ],
// //                                         ),
// //                                         items: controller.ageCodes
// //                                             .map((String value) {
// //                                           return DropdownMenuItem<String>(
// //                                               value: value,
// //                                               child: Center(
// //                                                 child: Text(
// //                                                   value,
// //                                                   style:
// //                                                       FxTextStyle.bodyMedium(),
// //                                                 ),
// //                                               ));
// //                                         }).toList(),

// //                                         value: controller.selectedage,
// //                                         onChanged: (value) {
// //                                           setState(() {
// //                                             controller.selectedage =
// //                                                 value.toString();
// //                                           });
// //                                         },

// //                                         icon: const Icon(Icons.arrow_drop_down),
// //                                         iconSize: 20,
// //                                         iconEnabledColor: Colors.black,
// //                                         iconDisabledColor: Colors.black,
// //                                         buttonHeight: 30,
// //                                         buttonWidth: 200,
// //                                         buttonPadding: const EdgeInsets.only(
// //                                             left: 14,
// //                                             right: 14,
// //                                             top: 4,
// //                                             bottom: 4),
// //                                         dropdownDecoration: BoxDecoration(
// //                                           borderRadius:
// //                                               BorderRadius.circular(4),
// //                                           color: Colors.white,
// //                                         ),
// //                                         buttonDecoration: BoxDecoration(
// //                                           borderRadius:
// //                                               BorderRadius.circular(10),
// //                                           color: theme.cardTheme.color,
// //                                         ),

// //                                         itemHeight: 40,
// //                                         // itemWidth: 200,
// //                                         itemPadding: const EdgeInsets.only(
// //                                             left: 14, right: 14),
// //                                         dropdownMaxHeight: 200,
// //                                         dropdownPadding: null,

// //                                         scrollbarRadius:
// //                                             const Radius.circular(40),
// //                                         scrollbarThickness: 2,
// //                                         scrollbarAlwaysShow: true,
// //                                         offset: const Offset(0, 0),
// //                                       ),
// //                                     ),
// //                                   );
// //                                 }),
// //                               ),

// //demodrop
//                         controller.childcount == 0
//                             ? const SizedBox()
//                             : SizedBox(
//                                 height: 50,
//                                 child: ListView.builder(
//                                   itemCount: options.length,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return DropdownButton<String>(
//                                       value: dropdownValues[index],
//                                       onChanged: (String? newValue) {
//                                         setState(() {
//                                           dropdownValues[index] =
//                                               newValue.toString();
//                                         });
//                                       },
//                                       items: options
//                                           .map<DropdownMenuItem<String>>(
//                                               (String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: Text(value),
//                                         );
//                                       }).toList(),
//                                     );
//                                   },
//                                 ),
//                               ),
                        //cabinclass
                        FxSpacing.height(24),
                        FxText.bodyLarge(
                          // 'CHOOSE CABIN CLASS',
                          'SELECT ROOM TYPE',
                          letterSpacing: 0,
                          fontWeight: 600,
                          decoration: TextDecoration.underline,
                        ),
                        Container(
                          child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              // children: _buildType(),
                              children: List.generate(
                                _choicesList.length,
                                (index) {
                                  return ChoiceChip(
                                    labelPadding: const EdgeInsets.all(2.0),
                                    label: FxText.bodySmall(_choicesList[index],
                                        // style: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium!
                                        //     .copyWith(
                                        //         color:
                                        //             Colors.white ,
                                        //         fontSize: 14),
                                        // style: TextStyle(
                                        color: defaultChoiceIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14

                                        // ),
                                        ),
                                    selected: defaultChoiceIndex == index,
                                    selectedColor: const Color(0xff1529e8),
                                    // Colors.deepPurple,
                                    onSelected: (value) {
                                      setState(() {
                                        defaultChoiceIndex =
                                            value ? index : defaultChoiceIndex;
                                        //  log('index:${_choicesList}');
                                        log('index:${defaultChoiceIndex.toString()}');
                                      });
                                    },
                                    // backgroundColor: color,
                                    elevation: 1,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10
                                        // horizontal: SizeConfig.widthMultiplier * 4
                                        ),
                                  );
                                },
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: FxContainer(
                          onTap: () {
                            // controller.closeEndDrawer();
                            Navigator.pop(context);
                          },
                          color: Colors.transparent,
                          padding: FxSpacing.y(12),
                          child: Center(
                            child: FxText(
                              "Clear",
                              color: const Color(0xff1529e8),
                              // color: theme.colorScheme.primary,
                              fontWeight: 600,
                            ),
                          ),
                        )),
                        Expanded(
                            child: FxContainer.none(
                          // onTap: () {
                          //   // controller.closeEndDrawer();
                          //   Navigator.pop(context);
                          // },
                          onTap: () async {
                            log('filter apply clicked');
                            CustomSnackbar.show(
                              context: context,
                              message: '2 Rooms for 4 Adults and 2 Children',
                              backgroundColor: const Color(0xff1529e8),
                              duration: const Duration(seconds: 2),
                            );
                            Navigator.pop(context);
                          },
                          padding: FxSpacing.y(12),
                          // color: theme.colorScheme.primary,
                          color: const Color(0xff1529e8),
                          child: Center(
                            child: FxText(
                              "Apply",
                              color: theme.colorScheme.onPrimary,
                              fontWeight: 600,
                            ),
                          ),
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
