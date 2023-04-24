import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

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
                // 'SELECT TRAVELLERS & CLASS',
                'SELECT Persons & Room Type',
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
                          'ADD NUMBER OF PERSONS',
                          letterSpacing: 0,
                          fontWeight: 600,
                          decoration: TextDecoration.underline,
                        ),

                        FxSpacing.height(14),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FxText.bodyMedium(
                              'Adult',
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
                                        controller.adultdecrement();
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
                                      controller.adultcount.toString(),
                                      fontWeight: 700,
                                      // style: const TextStyle(
                                      //     color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        controller.adultincrement();
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FxText.bodyMedium(
                              'Children',
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
                                        controller.childdecrement();
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
                                      controller.childcount.toString(),
                                      fontWeight: 700,
                                      // style: const TextStyle(
                                      //     color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        controller.childincrement();
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
                            FxText.bodyMedium(
                              'Infant',
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
                                        controller.infantdecrement();
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
                                      controller.infantcount.toString(),
                                      fontWeight: 700,
                                      // style: const TextStyle(
                                      //     color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        controller.infantincrement();
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
