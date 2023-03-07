import 'package:flutter/material.dart';
import 'package:flutx/core/state_management/controller.dart';
import 'package:hotel_travel/models/cart.dart';

import '../models/all_attraction_modal.dart';
import '../models/atteraction_model.dart';
import '../models/product.dart';
import '../views/full_app.dart';
import '../views/hotel_travel_constants.dart';

class SplashScreen2Controller extends FxController {
  @override
  void initState() {
    super.initState();
    goToFullApp();
  }

  final List<AllattractionModal> _favouriteMeals = [];
  final List<Activity> _cartMeal = [];
  final List<AllattractionModal> _availableMeals = <AllattractionModal>[];

  void _toggleFavorite(String mealId) {
    final existingIndex = _favouriteMeals
        .indexWhere((meal) => meal.attractions.data.first.id == mealId);
    if (existingIndex >= 0) {
      _favouriteMeals.removeAt(existingIndex);
      update();
      // setState(() {
      //   _favouriteMeals.removeAt(existingIndex);
      // });
    } else {
      _favouriteMeals.add(
        _availableMeals
            .firstWhere((meal) => meal.attractions.data.first.id == mealId),
      );
      // setState(() {
      //   _favouriteMeals.add(
      //      <AllattractionModal>[].firstWhere((meal) => meal.id == mealId),
      //   );
      // });
    }
  }

  bool _isMealFavorite(String id) {
    return _favouriteMeals.any((meal) => meal.attractions.data.first.id == id);
  }

  goToFullApp() async {
    HotelTravelCache.products = await Product.getDummyList();
    // HotelTravelCache.categories = await Category.getDummyList();
    HotelTravelCache.carts = await Cart.getDummyList();
    // ShoppingCache.carts = await Cart.getDummyList();
    await Future.delayed(const Duration(seconds: 1));

    Navigator.of(context, rootNavigator: true).pushReplacement(
      PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (_, __, ___) => FullApp(_favouriteMeals, _cartMeal)),
    );
  }

  @override
  String getTag() {
    return "splash_screen_2";
  }
}
