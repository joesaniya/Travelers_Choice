import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class DestinationController extends FxController {
  TickerProvider ticker;
  DestinationController(this.ticker);
  late TextEditingController toTE, FromTE;
  late Tween<Offset> offset;
  late AnimationController toController, fromController;
  late Animation<Offset> fromAnimation, toAnimation;
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  int fromCounter = 0;
  int toCounter = 0;
  bool uiLoading = true;

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
    FromTE = TextEditingController();
    toTE = TextEditingController();
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: ticker,
    );
    fromController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    fromAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: fromController,
      curve: Curves.easeIn,
    ));

    offset = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));

    animationController.forward();
    toController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));

    toAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: toController,
      curve: Curves.easeIn,
    ));
    fromController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        fromController.reverse();
      }
      if (status == AnimationStatus.dismissed && fromCounter < 2) {
        fromController.forward();
        fromCounter++;
      }
    });
    toController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        toController.reverse();
      }
      if (status == AnimationStatus.dismissed && toCounter < 2) {
        toController.forward();
        toCounter++;
      }
    });
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  @override
  String getTag() {
    return "Destination-Controller";
  }
}
