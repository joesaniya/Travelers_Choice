import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import '../controllers/all_bookings.dart';
import '../loading_effect.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';

class AllBookings extends StatefulWidget {
  const AllBookings({Key? key}) : super(key: key);

  @override
  State<AllBookings> createState() => _AllBookingsState();
}

class _AllBookingsState extends State<AllBookings>
    with TickerProviderStateMixin {
  late AllBookingController controller;
  late ThemeData theme, theme1;
  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;

    controller = FxControllerStore.put(AllBookingController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
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
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: FxText.titleLarge(
            'All Bookings',
            fontWeight: 600,
          ),
          backgroundColor: Colors.transparent,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                FeatherIcons.chevronLeft,
                size: 20,
                color: Color(0xff1529e8),
              )),
        ),
        // body: ListView(
        //   padding: FxSpacing.fromLTRB(
        //       20, FxSpacing.safeAreaTop(context) + 20, 20, 0),
        //   children: const [

        //   ],
        // ),
        body: Padding(
          padding: FxSpacing.fromLTRB(
              20,
              // FxSpacing.safeAreaTop(context) + 20,
              FxSpacing.safeAreaTop(context) + 5,
              20,
              0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: _buildProductList(),
          ),
        ),
      );
    }
  }

  Widget _buildProductList() {
    List<Widget> list = [];

    for (Product product in controller.products!) {
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: InkWell(
          onTap: () {
            controller.goToSingleProduct(product);
          },
          child: Container(
            // onTap: () {
            //   controller.goToSingleProduct(product);
            // },
            // borderRadiusAll: 4,
            // // paddingAll: 16,
            // height: 120,
            // height: 132,
            height: 212,
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

            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(children: [
                              FxText.bodyLarge(
                                'Status:',

                                // textAlign: TextAlign.left,
                                letterSpacing: 0,
                                fontWeight: 600,
                              ),
                              FxSpacing.width(10),
                              FxText.bodyLarge(
                                product.status,
                                color: product.status == 'confirmed'
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: 600,
                                // color: const Color(0xff1529e8),
                              )
                            ]),
                          ),
                          Container(
                            child: Row(children: [
                              FxText.bodyLarge(
                                'Date:',

                                // textAlign: TextAlign.left,
                                letterSpacing: 0,
                                fontWeight: 600,
                              ),
                              FxSpacing.width(10),
                              FxText.bodyLarge(
                                '15-02-2023',
                                fontWeight: 600,
                                color: const Color(0xff1529e8),
                              )
                            ]),
                          )
                        ],
                      ),
                      FxSpacing.height(10),
                      FxDashedDivider(
                        dashSpace: 4,
                        dashWidth: 8,
                        color: theme.colorScheme.onBackground.withAlpha(180),
                        height: 1.2,
                      ),
                    ],
                  ),
                ),
                Container(
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
                        child: Hero(
                          tag: "product_image_${product.name}",
                          child: Image(
                            image: AssetImage(product.image),
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
                                FxContainer(
                                  borderRadiusAll: 10,
                                  // padding: FxSpacing.xy(8, 4),
                                  padding: FxSpacing.xy(6, 2),
                                  // color: Color(0xff1529e8),
                                  color: Colors.blueGrey,
                                  child: FxText.bodySmall(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    // 'Theme Park',
                                    'Park',
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
                              tag: "product_${product.name}",
                              // child: FxText.bodyLarge(
                              //   product.name,
                              //   // fontWeight: 500,
                              // ),
                              child: FxText.bodyLarge(
                                product.name,
                                fontWeight: 800,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            FxSpacing.height(4),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      FxText.bodySmall(
                                        'Adult:',
                                        fontWeight: 900,
                                        color: Colors.black,
                                      ),
                                      FxSpacing.width(10),
                                      FxText.bodySmall(
                                        '4',
                                        fontWeight: 600,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FxText.bodySmall(
                                        'Child:',
                                        fontWeight: 900,
                                        color: Colors.black,
                                      ),
                                      FxSpacing.width(10),
                                      FxText.bodySmall(
                                        '0',
                                        fontWeight: 600,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FxText.bodySmall(
                                        'Infant:',
                                        fontWeight: 900,
                                        color: Colors.black,
                                      ),
                                      FxSpacing.width(10),
                                      FxText.bodySmall(
                                        '0',
                                        fontWeight: 600,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            FxSpacing.height(4),
                            Hero(
                              tag: "${product.name}_${product.price}",
                              child: FxText.labelLarge(
                                // '\$' + product.price.toString(),
                                "${product.price} AED",
                                // "\$" + product.price.toString() + "/hour",
                                fontWeight: 700,
                              ),
                            ),
                            // FxSpacing.height(6),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Hero(
                            //       tag: "${product.name}_${product.rating}",
                            //       child: Row(
                            //         children: [
                            //           const Icon(
                            //             // FeatherIcons.star,
                            //             Icons.star,
                            //             color: Colors.yellow,
                            //             size: 12,
                            //           ),
                            //           FxSpacing.width(4),
                            //           FxText.bodySmall(
                            //             '4.5',
                            //             fontWeight: 600,
                            //             color: Colors.black,
                            //           ),
                            //         ],
                            //       ),
                            //     ),

                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    }

    return Column(
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<AllBookingController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }
}
