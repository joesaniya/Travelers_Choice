import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../models/all_attraction_modal.dart';
import '../models/cart.dart';
import '../models/product.dart';
import '../views/hotel_travel_constants.dart';
import '../views/detail_screen/detail_Screen.dart';

class SavedController extends FxController {
  TickerProvider ticker;
  SavedController(this.ticker);
  bool showLoading = true, uiLoading = true;
  List<Cart>? carts;
  List<Product>? products;
  late double order, tax = 30, offer = 50, total;
  late AnimationController animationController, fadeController;
  late Animation<Offset> animation;
  late Animation<double> fadeAnimation;
  String? selectedtransfer;
  final List<String> TransferCodes = ['without'];
  String? selectedPax;
  final List<String> PaxCodes = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20'
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchloader();
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: ticker,
    );
    fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: ticker,
    );
    animation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(15, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: fadeController,
        curve: Curves.easeIn,
      ),
    );
    fadeController.forward();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    fadeController.dispose();
    super.dispose();
  }

  bool increaseAble(Cart cart) {
    return cart.person < cart.product.person;
  }

  bool decreaseAble(Cart cart) {
    return cart.person > 1;
  }

  void increment(Cart cart) {
    if (!increaseAble(cart)) return;
    cart.person++;
    calculateBilling();
    update();
  }

  void decrement(Cart cart) {
    if (!decreaseAble(cart)) return;
    cart.person--;
    calculateBilling();
    update();
  }

  void fetchData() async {
    // carts = HotelTravelCache.carts;
    // carts = HotelTravelCache.carts!.cast<Cart>();
    products = HotelTravelCache.products;
    log('fetch');
    // log(carts!.length.toString());
    calculateBilling();
    showLoading = false;
    // uiLoading = false;
    update();
  }

  void fetchloader() async {
    await Future.delayed(const Duration(seconds: 4));

    uiLoading = false;
    log('fetchloader');
    log(uiLoading.toString());
    update();
  }

  void calculateBilling() {
    order = 0;
    for (Cart cart in carts!) {
      order = order + (cart.product.price * cart.person);
    }

    total = order + tax - offer;
  }

  double findAspectRatio() {
    double width = MediaQuery.of(context).size.width;
    return ((width - 58) / 2) / (250);
  }

  void goToSingleProduct(Datum product) {
    log('Saved Detail:${product.id}');
    Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) =>
            FadeTransition(
              opacity: animation,
              child: child,
            ),
        pageBuilder: (_, __, ___) => DetailScreen(
            product.id,
            //  _toggleFavorite, _isMealFavorite,
            product)
        // SingleProductScreen(product.id)
        ));
  }

  @override
  String getTag() {
    return "saved_controller";
  }
}
