import 'package:flutter/material.dart';
import 'package:flutx/core/state_management/controller.dart';
import 'package:hotel_travel/Hotel_folder/views/hotel_Home.dart';
import 'package:hotel_travel/models/cart.dart';

import '../../models/plane.dart';
import '../../models/product.dart';
import '../../models/tickets.dart';
import '../../views/hotel_travel_constants.dart';

class HotelSplashController extends FxController {
  @override
  void initState() {
    super.initState();
    goToFullApp();
  }

  goToFullApp() async {
    HotelTravelCache.products = await Product.getDummyList();
    // HotelTravelCache.categories = await Category.getDummyList();
    HotelTravelCache.carts = await Cart.getDummyList();
    HotelTravelCache.tickets = await Tickets.getDummyList();
    HotelTravelCache.planes = await Planes.getDummyList();
    await Future.delayed(const Duration(seconds: 1));

    Navigator.of(context, rootNavigator: true).pushReplacement(
      PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (_, __, ___) => const HotelHome()),
    );
  }

  @override
  String getTag() {
    return "hotel_splash_screen_2";
  }
}
