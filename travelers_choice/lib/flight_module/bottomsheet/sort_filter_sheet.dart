import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import '../../theme/app_theme.dart';
import '../controller/sort_filter_controller.dart';

class SortFilterSheet extends StatefulWidget {
  const SortFilterSheet({super.key});

  @override
  State<SortFilterSheet> createState() => _SortFilterSheetState();
}

class _SortFilterSheetState extends State<SortFilterSheet>
    with TickerProviderStateMixin {
  late SortFilterController controller;
  late ThemeData theme, theme1;
  late CustomTheme customTheme;
  int? defaultChoiceIndex;
  final List<String> _choicesList = [
    'Price:Cheapest First',
    'Price:Shortest First',
    'Departure Time:Earliest First',
    'Departure Time:Latest First',
    'Arrival Time:Earliest First',
    'Arrival Time:Latest First',
  ];

  @override
  void initState() {
    super.initState();
    // defaultChoiceIndex = 0;
    defaultChoiceIndex;
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    customTheme = AppTheme.customTheme;
    controller = FxControllerStore.put(SortFilterController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });
  }

  List<Widget> _buildType() {
    List<Widget> choices = [];
    for (var item in controller.stopsfromchennaiList) {
      bool selected = controller.selectedChoices.contains(item);
      if (selected) {
        choices.add(GestureDetector(
          onTap: () {
            controller.removeChoice(item);
            setState(() {});
          },
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
              width: 70,
              decoration: BoxDecoration(
                  color: const Color(0xff1529e8),
                  // color: Colors.red,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    width: 1,
                    color: const Color(0xff1529e8),
                  )),
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.center,
                child: FxText.bodySmall(
                  item,
                  fontSize: 17,
                  color: Colors.white,
                  // color: const Color(0xff1529e8),
                  // color: theme.colorScheme.primary,
                ),
              )),
        ));
      } else {
        choices.add(GestureDetector(
          onTap: () {
            controller.addChoice(item);
            setState(() {});
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            width: 70,
            decoration: BoxDecoration(
                // color: Color(0xff1529e8),
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.grey.shade300, width: 1)),
            padding: const EdgeInsets.all(8),
            child: Align(
              alignment: Alignment.center,
              child: FxText.bodySmall(
                item,
                color: Colors.black,
                fontSize: 17,
                // color: theme.colorScheme.onBackground,
                // fontSize: 11,
              ),
            ),
          ),
        ));
      }
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<SortFilterController>(
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
                'SORT & FILTER',
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

                        // FxSpacing.height(14),

                        // //cabinclass
                        // FxSpacing.height(24),
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
                        FxSpacing.height(24),

                        FxText.bodyLarge(
                          'Filters',
                          letterSpacing: 0,
                          fontWeight: 600,
                          decoration: TextDecoration.underline,
                        ),
                        FxSpacing.height(14),
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 8.0,
                          children: _buildType(),
                        )
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
