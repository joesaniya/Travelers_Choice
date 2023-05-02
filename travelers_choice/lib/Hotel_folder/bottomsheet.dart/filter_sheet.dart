import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import '../../theme/app_theme.dart';
import '../controller/filter_sheet_controller.dart';

class HotelFilterSheet extends StatefulWidget {
  const HotelFilterSheet({super.key});

  @override
  State<HotelFilterSheet> createState() => _HotelFilterSheetState();
}

class _HotelFilterSheetState extends State<HotelFilterSheet>
    with TickerProviderStateMixin {
  late FilterSheetController controller;
  late ThemeData theme, theme1;
  late CustomTheme customTheme;
  int? defaultChoiceIndex;
  int? defaultStarIndex;
  int? defaultFacilityIndex;
  int? defaultMealsIndex;
  final List<String> _choicesList = [
    '5 Stars',
    'Swimming Pool',
    'Hotels',
    'Apartments',
    'Free WiFi',
    'Breakfast included',
    'Free cancellation'
  ];
  final List<String> starrating = [
    'Unrated',
    '2 Stars',
    '3 Stars',
    '4 Stars',
    '5 Stars',
  ];
  final List<String> FacilityList = [
    'Private Bathroom',
    'Air Conditioning',
  ];

  final List<String> MealsList = [
    'Breakfast included',
    'All meals included',
    'Breakfast & dinner included',
    'Breakfast & lunch included',
    'Self catering'
  ];

  @override
  void initState() {
    super.initState();
    // defaultChoiceIndex = 0;
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    customTheme = AppTheme.customTheme;
    controller = FxControllerStore.put(FilterSheetController(this));
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
    return FxBuilder<FilterSheetController>(
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
                // 'SELECT Persons & Room Type',
                'Filter',
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
                          'YOUR BUDGET(for 1 night)',
                          letterSpacing: 0,
                          fontWeight: 600,
                          decoration: TextDecoration.underline,
                        ),

                        FxSpacing.height(24),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FxText.bodyLarge(
                                'Price Range',
                                letterSpacing: 0,
                                fontWeight: 600,
                              ),
                              FxText.bodySmall(
                                // 'AED 140'
                                // "\$${controller.selectedRange.start.toInt()} - \$${controller.selectedRange.end.toInt()}",
                                "AED ${controller.selectedRange.start.toInt()} - ${controller.selectedRange.end.toInt()} AED",
                                color: const Color(0xff1529e8),
                                fontWeight: 600,
                                letterSpacing: 0.35,
                              )
                            ],
                          ),
                        ),
                        FxSpacing.height(16),
                        Container(
                          child: RangeSlider(
                              activeColor: const Color(0xff1529e8),
                              inactiveColor: const Color(0xff5563e8),
                              // activeColor: theme.colorScheme.primary,
                              // inactiveColor: theme.colorScheme.primary.withAlpha(100),
                              max: 10000,
                              min: 0,
                              values: controller.selectedRange,
                              onChanged: (RangeValues newRange) {
                                log('Start Value${newRange.start}');
                                log('End Value${newRange.end}');
                                controller.onChangePriceRange(newRange);
                              }),
                        ),

                        //cabinclass
                        FxSpacing.height(24),
                        FxText.bodyLarge(
                          'POPULAR FILTERS',
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

                        //star rating
                        FxSpacing.height(24),
                        FxText.bodyLarge(
                          'STAR RATING',
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
                                starrating.length,
                                (index) {
                                  return ChoiceChip(
                                    labelPadding: const EdgeInsets.all(2.0),
                                    label: FxText.bodySmall(starrating[index],
                                        color: defaultStarIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14

                                        // ),
                                        ),
                                    selected: defaultStarIndex == index,
                                    selectedColor: const Color(0xff1529e8),
                                    // Colors.deepPurple,
                                    onSelected: (value) {
                                      setState(() {
                                        defaultStarIndex =
                                            value ? index : defaultStarIndex;
                                        //  log('index:${_choicesList}');
                                        log('index:${defaultStarIndex.toString()}');
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
                        //room facilities
                        FxSpacing.height(24),
                        FxText.bodyLarge(
                          'ROOM FACILITIES',
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
                                FacilityList.length,
                                (index) {
                                  return ChoiceChip(
                                    labelPadding: const EdgeInsets.all(2.0),
                                    label: FxText.bodySmall(FacilityList[index],
                                        color: defaultFacilityIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14

                                        // ),
                                        ),
                                    selected: defaultFacilityIndex == index,
                                    selectedColor: const Color(0xff1529e8),
                                    onSelected: (value) {
                                      setState(() {
                                        defaultFacilityIndex = value
                                            ? index
                                            : defaultFacilityIndex;
                                        //  log('index:${_choicesList}');
                                        log('index:${defaultFacilityIndex.toString()}');
                                      });
                                    },
                                    elevation: 1,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10
                                        // horizontal: SizeConfig.widthMultiplier * 4
                                        ),
                                  );
                                },
                              )),
                        ),

                        //meals
                        FxSpacing.height(24),
                        FxText.bodyLarge(
                          'Meals',
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
                                MealsList.length,
                                (index) {
                                  return ChoiceChip(
                                    labelPadding: const EdgeInsets.all(2.0),
                                    label: FxText.bodySmall(MealsList[index],
                                        color: defaultMealsIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14

                                        // ),
                                        ),
                                    selected: defaultMealsIndex == index,
                                    selectedColor: const Color(0xff1529e8),
                                    onSelected: (value) {
                                      setState(() {
                                        defaultMealsIndex =
                                            value ? index : defaultMealsIndex;
                                        //  log('index:${_choicesList}');
                                        log('index:${defaultMealsIndex.toString()}');
                                      });
                                    },
                                    elevation: 1,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10
                                        // horizontal: SizeConfig.widthMultiplier * 4
                                        ),
                                  );
                                },
                              )),
                        ),

                        FxSpacing.height(24),
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
