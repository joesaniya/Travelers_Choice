import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/home_controller.dart';
import '../models/TopAttraction.dart';
import '../models/product.dart';

class AttractionTile extends StatefulWidget {
  const AttractionTile({required this.data});
  final TopAttraction data;

  @override
  State<AttractionTile> createState() => _AttractionTileState();
}

class _AttractionTileState extends State<AttractionTile>
    with TickerProviderStateMixin {
  late HomeController controller;
  @override
  void initState() {
    super.initState();

    controller = FxControllerStore.put(HomeController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });
  }

  Widget _buildProductList() {
    List<Widget> list = [];

    for (Product product in controller.products!) {
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: InkWell(
          onTap: () {
            // controller.goToSingleProduct(product);
          },
          child: Container(
            margin: const EdgeInsets.all(5.0),
            // width: 800,
            // height: 155,
            height: 250,
            decoration: BoxDecoration(
                // color: Color(0xffe6e1e5),
                color: Colors.white,
                // color: Color(0xffe5fdfd),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey.shade300, width: 1)
                // color: theme!.colorScheme.onPrimaryContainer,
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(widget.data.image.toString()
                              // 'assets/images/apps/shopping2/images/Ferraiworld.jpg',
                              ),
                          fit: BoxFit.fill)),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                // 'Theme Park',
                                widget.data.types.toString(),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  // FeatherIcons.star,
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 12,
                                ),
                                FxSpacing.width(4),
                                FxText.bodySmall(
                                  // '4.5',
                                  widget.data.rating.toString(),
                                  fontWeight: 600,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                FxSpacing.height(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: FxText.bodyLarge(
                    // 'Ferrari world',
                    widget.data.titlename.toString(),
                    fontWeight: 800,
                  ),
                ),
                FxSpacing.height(10),
                Padding(
                  // padding: EdgeInsets.symmetric(horizontal: 0),
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FxContainer(
                            borderRadiusAll: 8,
                            padding: FxSpacing.xy(8, 4),
                            // color: theme.colorScheme.primary,
                            // color: Colors.yellow.shade400,
                            color: Colors.white,
                            child: Row(
                              children: [
                                const Icon(
                                  Iconsax.location,
                                  color: Colors.black,
                                  // color: theme.colorScheme.onPrimary,
                                  size: 12,
                                ),
                                FxSpacing.width(4),
                                FxText.labelLarge(
                                  // '\$' + product.price.toString(),
                                  widget.data.location.toString(),
                                  // product.price.toString() + " " + "AED",
                                  // "\$" + product.price.toString() + "/hour",
                                  // fontWeight: 700,
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
                      FxText(
                        widget.data.price.toString(),
                        color: const Color(0xff1529e8),
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

    return ListView(
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    // return _buildProductList();
    return InkWell(
      onTap: () {
        // controller.goToSingleProduct(product);
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        // width: 800,
        height: 155,
        decoration: BoxDecoration(
            // color: Color(0xffe6e1e5),
            color: Colors.white,
            // color: Color(0xffe5fdfd),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.grey.shade300, width: 1)
            // color: theme!.colorScheme.onPrimaryContainer,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(widget.data.image.toString()
                          // 'assets/images/apps/shopping2/images/Ferraiworld.jpg',
                          ),
                      fit: BoxFit.fill)),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            // 'Theme Park',
                            widget.data.types.toString(),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              // FeatherIcons.star,
                              Icons.star,
                              color: Colors.yellow,
                              size: 12,
                            ),
                            FxSpacing.width(4),
                            FxText.bodySmall(
                              // '4.5',
                              widget.data.rating.toString(),
                              fontWeight: 600,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FxSpacing.height(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FxText.bodyLarge(
                // 'Ferrari world',
                widget.data.titlename.toString(),
                fontWeight: 800,
              ),
            ),
            FxSpacing.height(10),
            Padding(
              // padding: EdgeInsets.symmetric(horizontal: 0),
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxContainer(
                        borderRadiusAll: 8,
                        padding: FxSpacing.xy(8, 4),
                        // color: theme.colorScheme.primary,
                        // color: Colors.yellow.shade400,
                        color: Colors.white,
                        child: Row(
                          children: [
                            const Icon(
                              Iconsax.location,
                              color: Colors.black,
                              // color: theme.colorScheme.onPrimary,
                              size: 12,
                            ),
                            FxSpacing.width(4),
                            FxText.labelLarge(
                              // '\$' + product.price.toString(),
                              widget.data.location.toString(),
                              // product.price.toString() + " " + "AED",
                              // "\$" + product.price.toString() + "/hour",
                              // fontWeight: 700,
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
                  FxText(
                    widget.data.price.toString(),
                    color: const Color(0xff1529e8),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // return FxBuilder<HomeController>(
    //     controller: controller,
    //     builder: (controller) {
    //       // return InkWell(
    //       //   onTap: () {
    //       //     controller.goToSingleProduct(product);
    //       //   },
    //       //   child: Container(
    //       //     margin: const EdgeInsets.all(5.0),
    //       //     // width: 800,
    //       //     height: 155,
    //       //     decoration: BoxDecoration(
    //       //         // color: Color(0xffe6e1e5),
    //       //         color: Colors.white,
    //       //         // color: Color(0xffe5fdfd),
    //       //         borderRadius: const BorderRadius.all(Radius.circular(10)),
    //       //         border: Border.all(color: Colors.grey.shade300, width: 1)
    //       //         // color: theme!.colorScheme.onPrimaryContainer,
    //       //         ),
    //       //     child: Column(
    //       //       crossAxisAlignment: CrossAxisAlignment.start,
    //       //       children: [
    //       //         Container(
    //       //           margin: const EdgeInsets.all(8),
    //       //           height: 150,
    //       //           decoration: BoxDecoration(
    //       //               borderRadius: BorderRadius.circular(10),
    //       //               image: DecorationImage(
    //       //                   image: AssetImage(widget.data.image.toString()
    //       //                       // 'assets/images/apps/shopping2/images/Ferraiworld.jpg',
    //       //                       ),
    //       //                   fit: BoxFit.fill)),
    //       //         ),
    //       //         Flexible(
    //       //           child: Padding(
    //       //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //       //             child: Row(
    //       //               crossAxisAlignment: CrossAxisAlignment.center,
    //       //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       //               children: [
    //       //                 Row(
    //       //                   children: [
    //       //                     FxContainer(
    //       //                       borderRadiusAll: 10,
    //       //                       // padding: FxSpacing.xy(8, 4),
    //       //                       padding: FxSpacing.xy(6, 2),
    //       //                       // color: Color(0xff1529e8),
    //       //                       color: Colors.blueGrey,
    //       //                       child: FxText.bodySmall(
    //       //                         // 'Theme Park',
    //       //                         widget.data.types.toString(),
    //       //                         fontWeight: 300,
    //       //                         color: Colors.white,
    //       //                         // color: theme.colorScheme.onPrimary,
    //       //                       ),
    //       //                     ),
    //       //                     const SizedBox(
    //       //                       width: 5,
    //       //                     ),
    //       //                     FxContainer(
    //       //                       borderRadiusAll: 10,
    //       //                       // padding: FxSpacing.xy(8, 4),
    //       //                       padding: FxSpacing.xy(6, 2),
    //       //                       // color: Color(0xff1529e8),
    //       //                       color: Colors.blueGrey,
    //       //                       child: FxText.bodySmall(
    //       //                         'Ticket',
    //       //                         fontWeight: 300,
    //       //                         color: Colors.white,
    //       //                         // color: theme.colorScheme.onPrimary,
    //       //                       ),
    //       //                     ),
    //       //                     const SizedBox(
    //       //                       width: 5,
    //       //                     ),
    //       //                     FxContainer(
    //       //                       borderRadiusAll: 10,
    //       //                       // padding: FxSpacing.xy(8, 4),
    //       //                       padding: FxSpacing.xy(6, 2),
    //       //                       // color: Color(0xff1529e8),
    //       //                       color: Colors.blueGrey,
    //       //                       child: FxText.bodySmall(
    //       //                         'Offer',
    //       //                         fontWeight: 300,
    //       //                         color: Colors.white,
    //       //                         // color: theme.colorScheme.onPrimary,
    //       //                       ),
    //       //                     ),
    //       //                   ],
    //       //                 ),
    //       //                 Row(
    //       //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       //                   children: [
    //       //                     Row(
    //       //                       children: [
    //       //                         const Icon(
    //       //                           // FeatherIcons.star,
    //       //                           Icons.star,
    //       //                           color: Colors.yellow,
    //       //                           size: 12,
    //       //                         ),
    //       //                         FxSpacing.width(4),
    //       //                         FxText.bodySmall(
    //       //                           // '4.5',
    //       //                           widget.data.rating.toString(),
    //       //                           fontWeight: 600,
    //       //                           color: Colors.black,
    //       //                         ),
    //       //                       ],
    //       //                     ),
    //       //                   ],
    //       //                 ),
    //       //               ],
    //       //             ),
    //       //           ),
    //       //         ),
    //       //         FxSpacing.height(20),
    //       //         Padding(
    //       //           padding: const EdgeInsets.symmetric(horizontal: 8),
    //       //           child: FxText.bodyLarge(
    //       //             // 'Ferrari world',
    //       //             widget.data.titlename.toString(),
    //       //             fontWeight: 800,
    //       //           ),
    //       //         ),
    //       //         FxSpacing.height(10),
    //       //         Padding(
    //       //           // padding: EdgeInsets.symmetric(horizontal: 0),
    //       //           padding: const EdgeInsets.only(right: 8),
    //       //           child: Row(
    //       //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       //             children: [
    //       //               Row(
    //       //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       //                 children: [
    //       //                   FxContainer(
    //       //                     borderRadiusAll: 8,
    //       //                     padding: FxSpacing.xy(8, 4),
    //       //                     // color: theme.colorScheme.primary,
    //       //                     // color: Colors.yellow.shade400,
    //       //                     color: Colors.white,
    //       //                     child: Row(
    //       //                       children: [
    //       //                         const Icon(
    //       //                           Iconsax.location,
    //       //                           color: Colors.black,
    //       //                           // color: theme.colorScheme.onPrimary,
    //       //                           size: 12,
    //       //                         ),
    //       //                         FxSpacing.width(4),
    //       //                         FxText.labelLarge(
    //       //                           // '\$' + product.price.toString(),
    //       //                           widget.data.location.toString(),
    //       //                           // product.price.toString() + " " + "AED",
    //       //                           // "\$" + product.price.toString() + "/hour",
    //       //                           // fontWeight: 700,
    //       //                         ),
    //       //                       ],
    //       //                     ),
    //       //                   ),
    //       //                   // FxContainer.bordered(
    //       //                   //   paddingAll: 4,
    //       //                   //   borderRadiusAll: 4,
    //       //                   //   child: Icon(
    //       //                   //     FeatherIcons.plus,
    //       //                   //     size: 14,
    //       //                   //     color: theme.colorScheme.onBackground,
    //       //                   //   ),
    //       //                   // ),
    //       //                 ],
    //       //               ),
    //       //               FxText(
    //       //                 widget.data.price.toString(),
    //       //                 color: const Color(0xff1529e8),
    //       //               ),
    //       //             ],
    //       //           ),
    //       //         ),
    //       //       ],
    //       //     ),
    //       //   ),
    //       // );
    //       return _buildProductList();
    //     });
  }
}
