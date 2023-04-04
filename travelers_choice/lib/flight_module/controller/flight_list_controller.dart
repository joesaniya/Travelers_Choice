import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../../models/tickets.dart';
import '../../views/hotel_travel_constants.dart';

class FlightListController extends FxController {
  TickerProvider ticker;
  FlightListController(this.ticker);
  bool uiLoading = true;
  late AnimationController animationController;
  List<Tickets>? tickets;
  late AnimationController cartController;
  late Animation<double> cartAnimation, fadeAnimation;

  void goBack({bool? canRefresh}) {
    Navigator.pop(context, canRefresh);
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
    fetchData();
    fetchloader();
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: ticker,
    );
    cartController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));

    cartAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 24, end: 28), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 28, end: 24), weight: 50)
    ]).animate(cartController);

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );

    animationController.forward();
  }

  void fetchData() {
    tickets = HotelTravelCache.tickets;

    log('selectedtickets:$tickets');

    update();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  String getTag() {
    return "FlightList-Controller";
  }
}
