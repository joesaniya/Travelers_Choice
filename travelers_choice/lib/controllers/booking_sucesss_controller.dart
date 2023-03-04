import 'package:flutter/material.dart';
import 'package:flutx/core/state_management/controller.dart';
import 'package:hotel_travel/models/cart.dart';

import '../models/all_attraction_modal.dart';
import '../models/product.dart';
import '../views/full_app.dart';
import '../views/hotel_travel_constants.dart';

class BookingSuccessController extends FxController {
  @override
  void initState() {
    super.initState();
    goToFullApp();
  }

  final List<AllattractionModal> _favouriteMeals = [];
  final List<AllattractionModal> _availableMeals = <AllattractionModal>[];

  void _toggleFavorite(String mealId) {
    final existingIndex = _favouriteMeals
        .indexWhere((meal) => meal.attractions.data.first.id == mealId);
    if (existingIndex >= 0) {
      _favouriteMeals.removeAt(existingIndex);
      update();
     
    } else {
      _favouriteMeals.add(
        _availableMeals
            .firstWhere((meal) => meal.attractions.data.first.id == mealId),
      );
     
    }
  }

  bool _isMealFavorite(String id) {
    return _favouriteMeals.any((meal) => meal.attractions.data.first.id == id);
  }

  goToFullApp() async {
    
    await Future.delayed(const Duration(seconds: 1));

    Navigator.of(context, rootNavigator: true).pushReplacement(
      PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (_, __, ___) => FullApp(_favouriteMeals)),
    );
  }

  @override
  String getTag() {
    return "booking_sucess_controller";
  }
}
