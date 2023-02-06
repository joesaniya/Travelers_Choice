import 'package:flutter/material.dart';
import 'package:flutx/core/state_management/controller.dart';
import 'package:hotel_travel/models/cart.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../views/full_app.dart';
import '../views/hotel_travel_constants.dart';

class SplashScreen2Controller extends FxController {
  @override
  void initState() {
    super.initState();
    goToFullApp();
  }

  goToFullApp() async {
    HotelTravelCache.products = await Product.getDummyList();
    HotelTravelCache.categories = await Category.getDummyList();
    HotelTravelCache.carts = await Cart.getDummyList();
    // ShoppingCache.carts = await Cart.getDummyList();
    await Future.delayed(const Duration(seconds: 1));

    Navigator.of(context, rootNavigator: true).pushReplacement(
      PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (_, __, ___) => const FullApp()),
    );
  }

  @override
  String getTag() {
    return "splash_screen_2";
  }
}
