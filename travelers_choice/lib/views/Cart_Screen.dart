import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import '../controllers/new_cart_controller.dart';
import '../loading_effect.dart';
import '../models/atteraction_model.dart';
import '../services/app_constants.dart';
import '../theme/app_theme.dart';
import 'package:hotel_travel/models/all_attraction_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'full_app.dart';

class NewCart extends StatefulWidget {
  final List<Activity> cartMeal;
  const NewCart(this.cartMeal, {super.key});

  @override
  _NewCartState createState() => _NewCartState();
}

class _NewCartState extends State<NewCart> with TickerProviderStateMixin {
  late ThemeData theme;

  late NewCartController controller;
  List<AllattractionModal>? allattractionList;
  SharedPreferences? sharedPreferences;

  bool isLoading = true;
  // getAttraction(BuildContext context) async {
  //   // await AuthService().getCountry();
  //   log('getAttraction function called');
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   Future.delayed(Duration.zero, () async {
  //     await AttractionController().getAllattractionList(context).then((value) {
  //       if (value != null) {
  //         isLoading = false;
  //         allattractionList = [];
  //         allattractionList!.add(value);
  //         log('All1:$allattractionList');
  //       }
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // getAttraction(context);
    log('saved:${favouriteListCart.length}');
    log("favoriteCartList $favouriteListCart");
    theme = AppTheme.shoppingTheme;
    initializingData();
    controller = FxControllerStore.put(NewCartController(this));
    log('Item:${favouriteListCart.map((e) => e.sId)}');
  }

  String? currencySymbol;
  double? conversionRate;
  void initializingData() {
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        conversionRate = sharedPrefValue.getDouble(AppConstants.rate);
        log('conversionRate:$conversionRate');
        currencySymbol = sharedPrefValue.getString(AppConstants.symbol);
        log('currencySymbol:$currencySymbol');
      });
    });
  }

  Widget _buildSingleProduct(Activity product) {
    String text = product.name!;

    print("product$product");
    text = text.replaceAll("_", " ");

    List<String> words = text.split(" ");

    for (int i = 0; i < words.length; i++) {
      words[i] =
          words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
    }

    text = words.join(" ");

    return FadeTransition(
      opacity: controller.fadeAnimation,
      child: FxContainer(
        borderRadiusAll: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FxSpacing.height(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Option',
                  fontWeight: 600,
                ),
                FxSpacing.width(20),
                // Expanded(child: Container()),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FxText.bodyMedium(
                      // '\$' + controller.order.precise,
                      product.name!,
                      fontWeight: 700,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Transfer',
                  fontWeight: 600,
                ),
                product.transferType == null
                    ? FxText.bodyMedium(
                        'without',
                        fontWeight: 700,
                      )
                    : FxText.bodyMedium(
                        product.transferType.toString(),
                        fontWeight: 700,
                      ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Date',
                  fontWeight: 600,
                ),
                FxText.bodyMedium(
                  product.selectedDate.toString(),
                  fontWeight: 700,
                ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Pax',
                  fontWeight: 600,
                ),
                Expanded(child: Container()),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FxContainer(
                      padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                      color: const Color(0xff1529e8).withAlpha(40),
                      child: Row(
                        children: [
                          FxText.bodyMedium(product.adultCount.toString(),
                              color: const Color(0xff1529e8),
                              // color: customTheme.groceryPrimary,
                              fontWeight: 500,
                              letterSpacing: -0.2),
                          FxSpacing.width(4),
                          FxText.bodyMedium('Adult',
                              color: const Color(0xff1529e8),
                              // color: customTheme.groceryPrimary,
                              fontWeight: 500,
                              letterSpacing: -0.2),
                        ],
                      ),
                    ),
                    FxSpacing.width(10),
                    FxContainer(
                      padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                      color: const Color(0xff1529e8).withAlpha(40),
                      child: Row(
                        children: [
                          FxText.bodyMedium(product.childCount.toString(),
                              color: const Color(0xff1529e8),
                              // color: customTheme.groceryPrimary,
                              fontWeight: 500,
                              letterSpacing: -0.2),
                          FxSpacing.width(4),
                          FxText.bodyMedium('child',
                              color: const Color(0xff1529e8),
                              // color: customTheme.groceryPrimary,
                              fontWeight: 500,
                              letterSpacing: -0.2),
                        ],
                      ),
                    ),
                    FxSpacing.width(10),
                    FxContainer(
                      padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                      color: const Color(0xff1529e8).withAlpha(40),
                      child: Row(
                        children: [
                          FxText.bodyMedium(product.infantCount.toString(),
                              color: const Color(0xff1529e8),
                              // color: customTheme.groceryPrimary,
                              fontWeight: 500,
                              letterSpacing: -0.2),
                          FxSpacing.width(4),
                          FxText.bodyMedium('Infant',
                              color: const Color(0xff1529e8),
                              // color: customTheme.groceryPrimary,
                              fontWeight: 500,
                              letterSpacing: -0.2),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Amount',
                  fontWeight: 600,
                ),
                FxText.bodyMedium(
                  '${((product.grandTotal * conversionRate!)).toStringAsFixed(2)} $currencySymbol',
                  // "${product.grandTotal}AED",
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
                  color: const Color(0xff1529e8),
                ),
                FxText.bodyMedium(
                  '${((product.grandTotal * conversionRate!)).toStringAsFixed(2)} $currencySymbol',
                  // "${product.grandTotal}AED",
                  fontWeight: 800,
                  color: const Color(0xff1529e8),
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
    return FxBuilder<NewCartController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
      return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        body: Container(
            padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
            child: LoadingEffect.getCartLoadingScreen(
              context,
            )),
      );
    } else {
      return Scaffold(
          backgroundColor: const Color(0xfff5f5f5),
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            title: FxText.titleMedium(
              'Cart',
              fontWeight: 700,
            ),
            centerTitle: true,
            backgroundColor: const Color(0xfff5f5f5),
          ),
          body: favouriteListCart.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // Lottie.asset('assets/lottie/confirmation.json',
                      //     height: 300, width: 300),
                      Text('You have no cart itmes - start adding some item!',
                          style: TextStyle(
                              fontFamily: 'inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 16))
                    ],
                  ),
                )
              : Column(
                  children: [
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      padding: FxSpacing.x(20),
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: favouriteListCart.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return _buildSingleProduct(
                            // widget.favouriteMeals.first.attractions.data.first
                            favouriteListCart[index]);
                      },
                    ),
                    // const SizedBox(
                    //   height: 50,
                    // ),
                    Container(
                      padding: FxSpacing.xy(12, 8),
                      child: PhysicalModel(
                        color: theme.cardTheme.color!.withAlpha(200),
                        elevation: 12,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32)),
                        shadowColor:
                            theme.colorScheme.onBackground.withAlpha(12),
                        shape: BoxShape.rectangle,
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.cardTheme.color!.withAlpha(200),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(32)),
                          ),
                          padding: FxSpacing.xy(16, 12),
                          child: Column(
                            children: <Widget>[
                              FadeTransition(
                                opacity: controller.fadeAnimation,
                                child: FxButton.block(
                                    onPressed: () {
                                      final grandTotal = favouriteListCart
                                          .map((e) => e.grandTotal)
                                          .reduce((value, element) =>
                                              value + element);

                                      controller.goToCheckout(
                                          favouriteListCart, grandTotal);
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
                                              color:
                                                  theme.colorScheme.onPrimary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    FxSpacing.height(60),
                  ],
                ));
    }
  }
}
