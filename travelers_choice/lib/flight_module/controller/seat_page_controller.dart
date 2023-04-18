import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../views/flight_checkout.dart';
import '../views/ticket_screen.dart';

class SeatPageController extends FxController {
  TickerProvider ticker;
  SeatPageController(this.ticker);
  bool uiLoading = true;
  void ticketscreen() {
    log('calling ticket');
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   PageRouteBuilder(
    //       transitionDuration: const Duration(seconds: 2),
    //       pageBuilder: (_, __, ___) => Ticket_screen()),
    // );
     Navigator.of(context, rootNavigator: true).pushReplacement(
      PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (_, __, ___) => FlightCheckout()),
    );

    
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   PageRouteBuilder(
    //       transitionDuration: const Duration(seconds: 2),
    //       pageBuilder: (_, __, ___) => const BoardingPass()),
    // );
  }

  void fetchloader() async {
    await Future.delayed(const Duration(seconds: 4));

    uiLoading = false;
    log('fetchloader');
    log(uiLoading.toString());
    update();
  }

  @override
  void initState() {
    super.initState();
    fetchloader();
  }

  @override
  String getTag() {
    return "Seat-page-Controller";
  }
}
