import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/views/bottomSheet/Filter_Sheet.dart';
import 'package:hotel_travel/views/bottomSheet/categories_Sheet.dart';

import '../controllers/attraction_Controller.dart';
import '../controllers/search_Home_controller.dart';
import '../loading_effect.dart';
import '../models/all_attraction_modal.dart';
import '../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  String? place;
  // final BuildContext rootContext;
  SearchScreen({required this.place});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late ThemeData theme, theme1;

  late HomeSearchController controller;
  bool isLoading = true;
  List<AllattractionModal> allattractionList = <AllattractionModal>[];

  getAttraction() {
    log('getAttraction function called');
    Future.delayed(Duration.zero, () async {
      await AttractionController().getAllattractionList().then((value) {
        if (value != null) {
          isLoading = false;
          allattractionList.add(value);

          setState(() {});
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAttraction();
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;

    controller = FxControllerStore.put(HomeSearchController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<HomeSearchController>(
        controller: controller,
        builder: (controller) {
          return Theme(
            data: theme.copyWith(
                colorScheme: theme.colorScheme.copyWith(
                    secondary: theme.colorScheme.primary.withAlpha(40))),
            child: _buildBody(),
          );
        });
  }

  Widget _buildBody() {
    // if (controller.uiLoading)
    if (allattractionList.isEmpty) {
      return Scaffold(
          body: Padding(
        padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
        child: LoadingEffect.getHomeLoadingScreen(
          context,
          // theme, theme.colorScheme
        ),
      ));
    } else {
      return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        //   backgroundColor: Colors.red,
        key: controller.scaffoldKey,
        endDrawer: endDrawer(),
        body: ListView(
          padding: FxSpacing.fromLTRB(
              20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: FxTextStyle.bodyMedium(),
                    cursorColor: theme.colorScheme.primary,
                    decoration: InputDecoration(
                      hintText: "Search your place ...",
                      hintStyle: FxTextStyle.bodySmall(
                          color: theme.colorScheme.onBackground),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      filled: true,
                      // fillColor: const Color(0xffcfd2ff),
                      fillColor: theme.cardTheme.color,
                      prefixIcon: Icon(
                        FeatherIcons.search,
                        size: 16,
                        color: theme.colorScheme.onBackground.withAlpha(150),
                      ),
                      isDense: true,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                // FxSpacing.width(20),
                // FxContainer(
                //   paddingAll: 12,
                //   borderRadiusAll: 4,
                //   onTap: () {
                //     controller.openEndDrawer();
                //   },
                //   color: const Color(0xffcfd2ff),
                //   // color: theme.colorScheme.primaryContainer,
                //   child: Icon(
                //     FeatherIcons.sliders,
                //     color: theme1.colorScheme.onSecondaryContainer,
                //     // color: theme.colorScheme.primary,
                //     size: 20,
                //   ),
                // ),
              ],
            ),
            // Text(
            //   widget.place.toString(),
            //   style: const TextStyle(color: Colors.red),
            // ),
            FxSpacing.height(20),
            //btn
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext buildContext) {
                          return const CategoriesBottomSheet();
                        });
                  },
                  child: FxContainer(
                    borderRadiusAll: 10,
                    // padding: FxSpacing.xy(8, 4),
                    padding: FxSpacing.xy(6, 9),
                    color: const Color(0xff1529e8),
                    child: FxText.bodySmall(
                      'Categories',
                      fontWeight: 300,
                      color: Colors.white,
                      // color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // showModalBottomSheet(
                    //     context: context,
                    //     builder: (BuildContext buildContext) {
                    //       return const FilterSheet();
                    //     });
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      isScrollControlled: true,
                      builder: (context) {
                        return const FilterSheet();
                      },
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                        color: const Color(0xff1529e8),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: FxText.bodySmall(
                        'Filter',
                        fontWeight: 300,
                        color: Colors.white,
                        // color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            FxSpacing.height(20),
            //content
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              // child: _buildProductList(),
              child: _buildProductListUi(),
            ),
          ],
        ),
      );
    }
  }

  //topatt
  Widget _buildProductListUi() {
    List<Widget> list = [];

    // for (Product product in controller.products!)
    for (var product in allattractionList.first.attractions.data) {
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: InkWell(
          onTap: () {
            log('clicked');
            controller.goToSingleProduct(product);
          },
          child: Container(
            // onTap: () {
            //   controller.goToSingleProduct(product);
            // },
            // borderRadiusAll: 4,
            // // paddingAll: 16,
            // height: 120,
            height: 132,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey.shade300, width: 1)),
            margin: const EdgeInsets.only(
              bottom: 20,
            ),
            // //margin: EdgeInsets.all(8),
            // // color: Colors.green,
            // margin: FxSpacing.bottom(20),

            child: Container(
              margin: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Container(
                    // margin: EdgeInsets.all(8),
                    // paddingAll: 0,
                    // borderRadiusAll: 4,
                    // margin: EdgeInsets.all(8),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    // child: Image(image: NetworkImage(product.images.first)),
                    child: Hero(
                      tag: "product_image_${product.images}",
                      child: Image(
                        // image: AssetImage(product.image),
                        image: NetworkImage(
                            'https://a.walletbot.online/${product.images.first}'),
                        // image: AssetImage(product.images.first),
                        // height: 100,
                        height: 132,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  FxSpacing.width(20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: FxContainer(
                                borderRadiusAll: 10,
                                // padding: FxSpacing.xy(8, 4),
                                padding: FxSpacing.xy(6, 2),
                                // color: Color(0xff1529e8),
                                color: Colors.blueGrey,
                                child: FxText.bodySmall(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  // 'Theme Park',
                                  product.category.categoryName.name,
                                  // 'Park',
                                  fontWeight: 300,
                                  color: Colors.white,
                                  // color: theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            FxContainer(
                              borderRadiusAll: 10,
                              // padding: FxSpacing.xy(8, 4),
                              padding: FxSpacing.xy(6, 2),
                              // color: Color(0xff1529e8),
                              color: Colors.blueGrey,
                              child: FxText.bodySmall(
                                'Ticket',
                                fontWeight: 300,
                                color: Colors.white,
                                // color: theme.colorScheme.onPrimary,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            FxContainer(
                              borderRadiusAll: 10,
                              // padding: FxSpacing.xy(8, 4),
                              padding: FxSpacing.xy(6, 2),
                              // color: Color(0xff1529e8),
                              color: Colors.blueGrey,
                              child: FxText.bodySmall(
                                'Offer',
                                fontWeight: 300,
                                color: Colors.white,
                                // color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                        FxSpacing.height(8),
                        Hero(
                          tag: "product_${product.title}",
                          // child: FxText.bodyLarge(
                          //   product.name,
                          //   // fontWeight: 500,
                          // ),
                          child: FxText.bodyLarge(
                            product.title,
                            fontWeight: 800,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        FxSpacing.height(4),
                        Hero(
                          tag: "${product.duration}_${product.durationType}",
                          child: FxText.labelLarge(
                            // '\$' + product.price.toString(),
                            "${product.duration} AED",
                            // "\$" + product.price.toString() + "/hour",
                            fontWeight: 700,
                          ),
                        ),
                        FxSpacing.height(6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Hero(
                              tag:
                                  "${product.averageRating}_${product.totalReviews}",
                              child: Row(
                                children: [
                                  const Icon(
                                    // FeatherIcons.star,
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 12,
                                  ),
                                  FxSpacing.width(4),
                                  FxText.bodySmall(
                                    '4.5',
                                    fontWeight: 600,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            // FxContainer.bordered(
                            //   paddingAll: 4,
                            //   borderRadiusAll: 4,
                            //   child: Icon(
                            //     FeatherIcons.plus,
                            //     size: 14,
                            //     color: theme.colorScheme.onBackground,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
    }

    return Column(
      children: list,
    );
  }

  // Widget _buildProductList() {
  //   String f = FxTextUtils.randomString(10); //new page nav
  //   List<Widget> list = [];

  //   for (Product product in controller.products!) {
  //     log(product.name);
  //     log(controller.products!.length.toString());
  //     list.add(FadeTransition(
  //       opacity: controller.fadeAnimation,
  //       child: InkWell(
  //         onTap: () {
  //           controller.goToSingleProduct(product);
  //           // Navigator.push(
  //           //     context,
  //           //     PageRouteBuilder(
  //           //         transitionDuration: Duration(milliseconds: 500),
  //           //         pageBuilder: (_, __, ___) =>
  //           //             GrocerySingleProductScreen(product, heroKey)));
  //         },
  //         child: Container(
  //           // borderRadiusAll: 4,
  //           // // paddingAll: 16,
  //           // height: 120,
  //           height: 132,
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: const BorderRadius.all(Radius.circular(10)),
  //               border: Border.all(color: Colors.grey.shade300, width: 1)),
  //           margin: const EdgeInsets.only(
  //             bottom: 20,
  //           ),
  //           // //margin: EdgeInsets.all(8),
  //           // // color: Colors.green,
  //           // margin: FxSpacing.bottom(20),

  //           child: Container(
  //             margin: const EdgeInsets.all(8),
  //             child: Row(
  //               children: [
  //                 Container(
  //                   // margin: EdgeInsets.all(8),
  //                   // paddingAll: 0,
  //                   // borderRadiusAll: 4,
  //                   // margin: EdgeInsets.all(8),

  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                   clipBehavior: Clip.antiAliasWithSaveLayer,
  //                   child: Hero(
  //                     tag: "product_image_${product.name}",
  //                     child: Image(
  //                       image: AssetImage(product.image),
  //                       // height: 100,
  //                       height: 132,
  //                       width: 150,
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 ),
  //                 FxSpacing.width(20),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           FxContainer(
  //                             borderRadiusAll: 10,
  //                             // padding: FxSpacing.xy(8, 4),
  //                             padding: FxSpacing.xy(6, 2),
  //                             // color: Color(0xff1529e8),
  //                             color: Colors.blueGrey,
  //                             child: FxText.bodySmall(
  //                               overflow: TextOverflow.ellipsis,
  //                               maxLines: 1,
  //                               // 'Theme Park',
  //                               'Park',
  //                               fontWeight: 300,
  //                               color: Colors.white,
  //                               // color: theme.colorScheme.onPrimary,
  //                             ),
  //                           ),
  //                           const SizedBox(
  //                             width: 5,
  //                           ),
  //                           FxContainer(
  //                             borderRadiusAll: 10,
  //                             // padding: FxSpacing.xy(8, 4),
  //                             padding: FxSpacing.xy(6, 2),
  //                             // color: Color(0xff1529e8),
  //                             color: Colors.blueGrey,
  //                             child: FxText.bodySmall(
  //                               'Ticket',
  //                               fontWeight: 300,
  //                               color: Colors.white,
  //                               // color: theme.colorScheme.onPrimary,
  //                             ),
  //                           ),
  //                           const SizedBox(
  //                             width: 5,
  //                           ),
  //                           FxContainer(
  //                             borderRadiusAll: 10,
  //                             // padding: FxSpacing.xy(8, 4),
  //                             padding: FxSpacing.xy(6, 2),
  //                             // color: Color(0xff1529e8),
  //                             color: Colors.blueGrey,
  //                             child: FxText.bodySmall(
  //                               'Offer',
  //                               fontWeight: 300,
  //                               color: Colors.white,
  //                               // color: theme.colorScheme.onPrimary,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       FxSpacing.height(8),
  //                       Hero(
  //                         tag: "product_${product.name}",
  //                         // child: FxText.bodyLarge(
  //                         //   product.name,
  //                         //   // fontWeight: 500,
  //                         // ),
  //                         child: FxText.bodyLarge(
  //                           product.name,
  //                           fontWeight: 800,
  //                           overflow: TextOverflow.ellipsis,
  //                           maxLines: 2,
  //                         ),
  //                       ),
  //                       FxSpacing.height(4),
  //                       Hero(
  //                         tag: "${product.name}_${product.price}",
  //                         child: FxText.labelLarge(
  //                           // '\$' + product.price.toString(),
  //                           "${product.price} AED",
  //                           // "\$" + product.price.toString() + "/hour",
  //                           fontWeight: 700,
  //                         ),
  //                       ),
  //                       FxSpacing.height(6),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Hero(
  //                             tag: "${product.name}_${product.rating}",
  //                             child: Row(
  //                               children: [
  //                                 const Icon(
  //                                   // FeatherIcons.star,
  //                                   Icons.star,
  //                                   color: Colors.yellow,
  //                                   size: 12,
  //                                 ),
  //                                 FxSpacing.width(4),
  //                                 FxText.bodySmall(
  //                                   '4.5',
  //                                   fontWeight: 600,
  //                                   color: Colors.black,
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           // FxContainer.bordered(
  //                           //   paddingAll: 4,
  //                           //   borderRadiusAll: 4,
  //                           //   child: Icon(
  //                           //     FeatherIcons.plus,
  //                           //     size: 14,
  //                           //     color: theme.colorScheme.onBackground,
  //                           //   ),
  //                           // ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ));
  //   }

  //   return Column(
  //     children: list,
  //   );
  // }

  Widget endDrawer() {
    return Container(
      margin:
          FxSpacing.fromLTRB(20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: theme.scaffoldBackgroundColor,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Drawer(
        child: Container(
          color: theme.scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: FxSpacing.xy(16, 12),
                // color: theme.colorScheme.primary,
                color: const Color(0xff1529e8),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: FxText(
                          "Filter",
                          fontWeight: 700,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    FxContainer.rounded(
                        onTap: () {
                          controller.closeEndDrawer();
                        },
                        paddingAll: 6,
                        color: theme.colorScheme.onPrimary.withAlpha(80),
                        child: Icon(
                          FeatherIcons.x,
                          size: 12,
                          color: theme.colorScheme.onPrimary,
                        ))
                  ],
                ),
              ),
              Expanded(
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
                  Container(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _buildType(),
                    ),
                  ),
                  FxSpacing.height(24),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FxText.bodyMedium(
                          "Price Range",
                          color: theme.colorScheme.onBackground,
                          fontWeight: 600,
                        ),
                        FxText.bodySmall(
                          "\$${controller.selectedRange.start.toInt()} - \$${controller.selectedRange.end.toInt()}",
                          // color: theme.colorScheme.primary,
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
                          controller.onChangePriceRange(newRange);
                        }),
                  ),
                ],
              )),
              Container(
                child: Row(
                  children: [
                    Expanded(
                        child: FxContainer(
                      onTap: () {
                        controller.closeEndDrawer();
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
                        controller.closeEndDrawer();
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
    );
  }

  List<Widget> _buildType() {
    List<Widget> choices = [];
    for (var item in controller.categoryList) {
      bool selected = controller.selectedChoices.contains(item);
      if (selected) {
        choices.add(FxContainer.none(
            color: theme.colorScheme.primary.withAlpha(28),
            bordered: true,
            borderRadiusAll: 20,
            paddingAll: 8,
            border: Border.all(color: theme.colorScheme.primary),
            onTap: () {
              controller.removeChoice(item);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check,
                  size: 14,
                  color: theme.colorScheme.primary,
                ),
                FxSpacing.width(6),
                FxText.bodySmall(
                  item,
                  fontSize: 11,
                  color: theme.colorScheme.primary,
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
