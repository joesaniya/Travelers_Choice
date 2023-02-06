import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import 'package:hotel_travel/extensions/extensions.dart';

import '../controllers/saved_controller.dart';
import '../loading_effect.dart';
import '../models/cart.dart';
import '../theme/app_theme.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late SavedController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(SavedController(this));
  }

  Widget _buildCartList() {
    List<Widget> list = [];

    for (Cart cart in controller.carts!) {
      bool increaseAble = controller.increaseAble(cart);
      bool decreaseAble = controller.decreaseAble(cart);
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Container()),
                InkWell(
                  onTap: () {
                    // Navigator.pop(context);
                  },
                  child: FxContainer.bordered(
                    paddingAll: 4,
                    color: theme.colorScheme.onPrimary,
                    borderColor: Colors.black,
                    child: Icon(
                      FeatherIcons.minus,
                      color: Colors.red.withAlpha(200),
                      size: 12,
                    ),
                  ),
                ),
                // FxContainer(
                //   onTap: () {
                //     // controller.decrement(cart);
                //   },
                //   paddingAll: 4,
                //   borderRadiusAll: 2,
                //   alignment: Alignment.centerRight,
                //   // bordered: decreaseAble,

                //   border: Border.all(color: Colors.grey.withAlpha(120)),
                //   color: Colors.grey,
                //   child: const Icon(
                //     FeatherIcons.minus,
                //     size: 12,
                //     color: Colors.indigo,
                //   ),
                // ),
              ],
            ),
            FxSpacing.height(10),
            FxContainer(
              margin: FxSpacing.bottom(20),
              borderRadiusAll: 4,
              paddingAll: 12,
              child: Column(
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     // Navigator.pop(context);
                  //   },
                  //   child: FxContainer.bordered(
                  //     paddingAll: 4,
                  //     child: Icon(
                  //       Icons.chevron_left_outlined,
                  //       color: theme.colorScheme.onBackground.withAlpha(200),
                  //     ),
                  //   ),
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(child: Container()),
                  //     InkWell(
                  //       onTap: () {
                  //         // Navigator.pop(context);
                  //       },
                  //       child: FxContainer.bordered(
                  //         paddingAll: 4,
                  //         color: theme.colorScheme.onPrimary,
                  //         borderColor: Colors.black,
                  //         child: Icon(
                  //           FeatherIcons.minus,
                  //           color: Colors.red.withAlpha(200),
                  //           size: 12,
                  //         ),
                  //       ),
                  //     ),
                  //     // FxContainer(
                  //     //   onTap: () {
                  //     //     // controller.decrement(cart);
                  //     //   },
                  //     //   paddingAll: 4,
                  //     //   borderRadiusAll: 2,
                  //     //   alignment: Alignment.centerRight,
                  //     //   // bordered: decreaseAble,

                  //     //   border: Border.all(color: Colors.grey.withAlpha(120)),
                  //     //   color: Colors.grey,
                  //     //   child: const Icon(
                  //     //     FeatherIcons.minus,
                  //     //     size: 12,
                  //     //     color: Colors.indigo,
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
                  // FxSpacing.height(10),
                  Row(
                    children: [
                      FxContainer(
                        paddingAll: 0,
                        borderRadiusAll: 4,
                        height: 80,
                        width: 80,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(cart.product.image),
                        ),
                      ),
                      FxSpacing.width(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FxText.titleMedium(
                              cart.product.name,
                              fontWeight: 700,
                            ),
                            FxSpacing.height(8),
                            FxText.bodyMedium(
                              '\$${cart.product.price}',
                              fontWeight: 700,
                            ),
                            FxSpacing.height(8),
                            // Row(
                            //   children: [
                            //     FxText.bodySmall(
                            //       'Size : ${cart.selectedSize}',
                            //       fontWeight: 600,
                            //     ),
                            //     FxSpacing.width(20),
                            //     FxText.bodySmall('Color : '),
                            //     FxContainer(
                            //         paddingAll: 8,
                            //         borderRadiusAll: 2,
                            //         color: cart.selectedColor,
                            //         child: Container()),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      FxSpacing.width(20),
                      // Column(
                      //   children: [
                      //     FxContainer(
                      //       onTap: () {
                      //         controller.increment(cart);
                      //       },
                      //       bordered: increaseAble,
                      //       paddingAll: 4,
                      //       borderRadiusAll: 2,
                      //       border: Border.all(color: theme.colorScheme.primary),
                      //       color: increaseAble
                      //           ? theme.colorScheme.primary
                      //           : theme.colorScheme.onBackground.withAlpha(200),
                      //       child: Icon(
                      //         FeatherIcons.plus,
                      //         size: 12,
                      //         color: increaseAble
                      //             ? theme.colorScheme.onPrimary
                      //             : theme.colorScheme.onPrimary,
                      //       ),
                      //     ),
                      //     FxSpacing.height(8),
                      //     FxText.bodyMedium(
                      //       cart.person.toString(),
                      //       fontWeight: 700,
                      //     ),
                      //     FxSpacing.height(8),
                      //     FxContainer(
                      //       onTap: () {
                      //         controller.decrement(cart);
                      //       },
                      //       paddingAll: 4,
                      //       borderRadiusAll: 2,
                      //       bordered: decreaseAble,
                      //       border: Border.all(
                      //           color: theme.colorScheme.primary.withAlpha(120)),
                      //       color: decreaseAble
                      //           ? theme.colorScheme.primary.withAlpha(28)
                      //           : theme.colorScheme.onBackground.withAlpha(200),
                      //       child: Icon(
                      //         FeatherIcons.minus,
                      //         size: 12,
                      //         color: decreaseAble
                      //             ? theme.colorScheme.primary
                      //             : theme.colorScheme.onPrimary,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
    }
    return Column(
      children: list,
    );
  }

  Widget _billingWidget() {
    return FadeTransition(
      opacity: controller.fadeAnimation,
      child: FxContainer(
        borderRadiusAll: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxText.bodyMedium(
              'Billing Information',
              muted: true,
              fontWeight: 700,
            ),
            FxSpacing.height(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Order Total',
                  fontWeight: 600,
                ),
                FxText.bodyMedium(
                  '\$${controller.order.precise}',
                  fontWeight: 700,
                ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Tax',
                  fontWeight: 600,
                ),
                FxText.bodyMedium(
                  '\$${controller.tax.precise}',
                  fontWeight: 700,
                ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Offer',
                  fontWeight: 600,
                ),
                FxText.bodyMedium(
                  '- \$${controller.offer.precise}',
                  fontWeight: 700,
                ),
              ],
            ),
            FxSpacing.height(12),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  child: FxDashedDivider(
                    dashSpace: 4,
                    dashWidth: 8,
                    color: theme.colorScheme.onBackground.withAlpha(180),
                    height: 1.2,
                  ),
                )
              ],
            ),
            FxSpacing.height(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Grand Total',
                  fontWeight: 700,
                ),
                FxText.bodyMedium(
                  '\$${controller.total.precise}',
                  fontWeight: 800,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<SavedController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
      return Scaffold(
        body: Container(
            padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
            child: LoadingEffect.getCartLoadingScreen(
              context,
            )),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: FxText.titleMedium(
            'Cart',
            fontWeight: 700,
          ),
          centerTitle: true,
        ),
        body: controller.carts!.isEmpty
            ? const Center(
                child: Text(
                  'Add in Your Cart',
                ),
              )
            : ListView(
                padding: FxSpacing.nTop(20),
                children: [
                  _buildCartList(),
                  _billingWidget(),
                  FxSpacing.height(20),
                  FadeTransition(
                    opacity: controller.fadeAnimation,
                    child: FxButton.block(
                        onPressed: () {
                          controller.goToCheckout();
                        },
                        backgroundColor: const Color(0xff1529e8),
                        // backgroundColor: theme.colorScheme.primary,
                        elevation: 0,
                        borderRadiusAll: 4,
                        child: Row(
                          children: [
                            SlideTransition(
                              position: controller.animation,
                              child: Image(
                                height: 22,
                                width: 22,
                                color: theme.colorScheme.onPrimary,
                                image: const AssetImage(
                                    'assets/images/apps/shopping2/icons/clear_cart_outline.png'),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: FxText.bodyMedium(
                                  'Checkout',
                                  fontWeight: 600,
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  FxSpacing.height(80),
                ],
              ),
      );
    }
  }
}
