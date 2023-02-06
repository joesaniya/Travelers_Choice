import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import '../../controllers/search_Home_controller.dart';
import '../../theme/app_theme.dart';

class CategoriesBottomSheet extends StatefulWidget {
  const CategoriesBottomSheet({Key? key}) : super(key: key);

  @override
  State<CategoriesBottomSheet> createState() => _CategoriesBottomSheetState();
}

class _CategoriesBottomSheetState extends State<CategoriesBottomSheet>
    with TickerProviderStateMixin {
  late ThemeData theme, theme1;

  late HomeSearchController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(HomeSearchController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<HomeSearchController>(
        controller: controller,
        builder: (controller) {
          return Container(
            color: Colors.transparent,
            child: Container(
              padding: FxSpacing.xy(24, 16),
              decoration: const BoxDecoration(
                  // color: customTheme.card,
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FxSpacing.height(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText.bodyLarge(
                        'Categories',
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
                  SizedBox(
                    height: 200,
                    child: ListView(
                      padding: FxSpacing.all(20),
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FxText.bodyMedium(
                                "Type",
                                color: theme.colorScheme.onBackground,
                                fontWeight: 600,
                              ),
                              FxText.bodySmall(
                                "${controller.selectedChoices.length} selected",
                                color: theme.colorScheme.onBackground,
                                fontWeight: 600,
                                xMuted: true,
                              ),
                            ],
                          ),
                        ),
                        FxSpacing.height(16),
                        // Container(
                        //   height: 400,
                        //   color: Colors.transparent,
                        //   child: ListView.separated(
                        //       itemBuilder: (context, index) {
                        //         return const Text('hi');
                        //         // return _buildType();
                        //       },
                        //       separatorBuilder: (context, index) {
                        //         return const SizedBox(
                        //           height: 3,
                        //         );
                        //       },
                        //       itemCount: 8),
                        // )
                        Container(
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: _buildType(),
                          ),
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
                          onTap: () {
                            // controller.closeEndDrawer();
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
          );
        });
  }

  List<Widget> _buildType() {
    List<Widget> choices = [];
    for (var item in controller.categoryList) {
      bool selected = controller.selectedChoices.contains(item);
      if (selected) {
        choices.add(FxContainer.none(
            // color: theme.colorScheme.primary.withAlpha(28),
            color: const Color(0xff1529e8).withAlpha(28),
            bordered: true,
            borderRadiusAll: 20,
            paddingAll: 8,
            border: Border.all(
              // color: theme.colorScheme.primary
              color: const Color(0xff1529e8),
            ),
            onTap: () {
              controller.removeChoice(item);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check,
                  size: 14,
                  color: Color(0xff1529e8),
                  // color: theme.colorScheme.primary,
                ),
                FxSpacing.width(6),
                FxText.bodySmall(
                  item,
                  fontSize: 11,
                  color: const Color(0xff1529e8),
                  // color: theme.colorScheme.primary,
                )
              ],
            )));
      } else {
        choices.add(FxContainer.none(
          color: theme.cardTheme.color,
          borderRadiusAll: 20,
          padding: FxSpacing.xy(12, 8),
          onTap: () {
            controller.addChoice(item);
          },
          child: FxText.bodySmall(
            item,
            color: theme.colorScheme.onBackground,
            fontSize: 11,
          ),
        ));
      }
    }
    return choices;
  }
}
