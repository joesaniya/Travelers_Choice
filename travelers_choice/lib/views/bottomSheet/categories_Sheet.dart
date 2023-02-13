import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import '../../controllers/search_Home_controller.dart';
import '../../models/Country_modal.dart';
import '../../models/all_attraction_modal.dart';
import '../../models/search_categories_modal.dart';
import '../../services/Search_Service.dart';
import '../../theme/app_theme.dart';

class CategoriesBottomSheet extends StatefulWidget {
  Destination? categoryplace;
  CategoriesBottomSheet({this.categoryplace});

  @override
  State<CategoriesBottomSheet> createState() => _CategoriesBottomSheetState();
}

class _CategoriesBottomSheetState extends State<CategoriesBottomSheet>
    with TickerProviderStateMixin {
  late ThemeData theme, theme1;

  late HomeSearchController controller;

  @override
  void initState() {
    log('sheet');
    log('Category Place:${widget.categoryplace!.name.toString()}');
    super.initState();
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(HomeSearchController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });

    controller.getcategoryAttraction(
        // widget.productid,
        setState);
  }

  List<AllattractionModal> allattractionList = <AllattractionModal>[];
  bool isAllAttractionListLoading = true;
  Future<AllattractionModal?> getAllattractionList(
      String place, String categoryId) async {
    // isCountryListLoading = true;
    try {
      var data = await SearchService().getAllAttraction(place, categoryId);
      allattractionList.clear();
      if (data != null) {
        allattractionList.add(data);
        // isCountryListLoading = false;
        return data; //removed true
      } else {
        return null; //falseremoved
      }
    } catch (e) {
      rethrow;
    }
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
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Column(
                children: [
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
                  FxSpacing.height(10),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          // color: customTheme.card,
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(13),
                              topRight: Radius.circular(13))),
                      padding: FxSpacing.xy(6, 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: ListView(
                              padding: FxSpacing.all(20),
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FxText.bodyMedium(
                                        "Type",
                                        color: theme.colorScheme.onBackground,
                                        fontWeight: 600,
                                      ),
                                      // FxText.bodySmall(
                                      //   "${controller.selectedChoices.length} selected",
                                      //   color: theme.colorScheme.onBackground,
                                      //   fontWeight: 600,
                                      //   xMuted: true,
                                      // ),
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
                                  child: (controller.categoryattraction.isEmpty)
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      :
                                      // _categoryCard()
                                      Wrap(
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
                                  onTap: () async {
                                    // controller.closeEndDrawer();
                                    // Navigator.pop(context);
                                    if (controller.categoryid != null) {
                                      //todo
                                      AllattractionModal? temp =
                                          await getAllattractionList(
                                              widget.categoryplace!.name,
                                              controller.categoryid!);

                                      setState(() {
                                        controller.allattractionList = [];

                                        controller.allattractionList!
                                            .add(temp!);
                                      });
                                      Navigator.pop(context, temp);
                                    } else {
                                      print("Data search Null");
                                    }
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
            ),
          );
        });
  }

  Widget _categoryCard() {
    log(
      'category:${controller.categoryattraction.length}',
    );
    List<Widget> choices = [];
    return SizedBox(
      height: 600,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return FxContainer.none(
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
                  // controller.removeChoice(item.id.toString());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                        height: 24,
                        width: 24,
                        image: NetworkImage(
                            'https://a.walletbot.online${controller.categoryattraction.first.icon}')),
                    FxSpacing.width(20),
                    FxText.bodySmall(
                      controller.categoryattraction.first.categoryName
                          .toString(),
                      color: theme.colorScheme.onBackground,
                      fontSize: 16,
                    ),
                  ],
                ));
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 5,
            );
          },
          itemCount: controller.categoryattraction.length),
    );
  }

  List<Widget> _buildType() {
    log(
      'category:${controller.categoryattraction.length}',
    );
    List<Widget> choices = [];
    for (SearchCategoriesModal item in controller.categoryattraction) {
      bool selected = controller.selectedChoices == item;
      if (selected) {
        choices.add(FxContainer.none(
          // color: theme.colorScheme.primary.withAlpha(28),
          // color: const Color(0xff1529e8).withAlpha(28),
          color: const Color(0xff1529e8),
          splashColor: Colors.lightBlue,

          bordered: true,
          borderRadiusAll: 20,
          paddingAll: 8,
          // border: Border.all(
          //   // color: theme.colorScheme.primary
          //   color: const Color(0xff1529e8),
          // ),
          onTap: () {
            controller.removeChoice(item);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                  height: 24,
                  width: 24,
                  image:
                      NetworkImage('https://a.walletbot.online/${item.icon}')),
              FxSpacing.width(20),
              FxText.bodySmall(
                item.categoryName![0].toUpperCase() +
                    item.categoryName!.substring(1).toLowerCase(),
                // color: theme.colorScheme.onBackground,
                color: Colors.white,
                fontSize: 16,
              ),
            ],
          ),
          // child: Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     const Icon(
          //       Icons.check,
          //       size: 14,
          //       color: Color(0xff1529e8),
          //       // color: theme.colorScheme.primary,
          //     ),
          //     FxSpacing.width(6),
          //     FxText.bodySmall(
          //       item.categoryName.toString(),
          //       fontSize: 11,
          //       color: const Color(0xff1529e8),
          //       // color: theme.colorScheme.primary,
          //     )
          //   ],
          // )
        ));
      } else {
        choices.add(FxContainer.none(
          color: Colors.blueGrey.shade100,
          borderRadiusAll: 20,
          padding: FxSpacing.xy(12, 8),
          onTap: () {
            log('selected id:${item.id}');
            controller.addChoice(item);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ImageIcon(
              //   NetworkImage('https://a.walletbot.online/${item.icon}'),
              //   // color: Colors.red,
              //   size: 24,
              // ),

              Image(
                  height: 24,
                  width: 24,
                  image:
                      NetworkImage('https://a.walletbot.online/${item.icon}')),
              FxSpacing.width(20),
              FxText.bodySmall(
                item.categoryName![0].toUpperCase() +
                    item.categoryName!.substring(1).toLowerCase(),
                color: theme.colorScheme.onBackground,
                fontSize: 16,
              ),
            ],
          ),
        ));
      }
    }
    return choices;
  }
}
