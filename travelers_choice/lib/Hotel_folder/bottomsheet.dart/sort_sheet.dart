import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import '../../theme/app_theme.dart';
import '../controller/sort_sheet_controller.dart';

class SortSeat extends StatefulWidget {
  const SortSeat({super.key});

  @override
  State<SortSeat> createState() => _SortSeatState();
}

class _SortSeatState extends State<SortSeat> with TickerProviderStateMixin {
  late SortSeatController controller;
  late ThemeData theme, theme1;
  late CustomTheme customTheme;
  int? defaultChoiceIndex;
  final List<String> _choicesList = [
    'Entire homes & apartments first',
    'Distance from city centre',
    'Popularity',
    'Stars(5 to 0)',
    'Stars(0 to 5)',
    'Guest review score',
    'Price (low to high)'
  ];

  @override
  void initState() {
    super.initState();
    defaultChoiceIndex = 0;
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    customTheme = AppTheme.customTheme;
    controller = FxControllerStore.put(SortSeatController(this));
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
    return FxBuilder<SortSeatController>(
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
                'SORT BY',
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
                        // FxSpacing.height(14),

                        //cabinclass
                        FxSpacing.height(24),
                        FxText.bodyLarge(
                          'SORT BY',
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
