import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class VisaEnquireBottomController extends FxController {
  TickerProvider ticker;
  VisaEnquireBottomController(this.ticker);
  late Animation<double> fadeAnimation;
  late AnimationController animationController,
      reqController,
      titleController,
      whatsappnumberController;
  late Animation<Offset> reqAnimation, titleANimation, whatsappnumberAnimation;
  int reqCounter = 0;
  int titleCounter = 0;
  int whatsappnumberCounter = 0;
  late TextEditingController reqTE, titleTE, whatsappnumberTE;
  String? selectedCountryName;
  @override
  initState() {
    super.initState();

    reqTE = TextEditingController();
    titleTE = TextEditingController();
    whatsappnumberTE = TextEditingController();
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: ticker,
    );
    whatsappnumberController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    titleController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    reqController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    whatsappnumberAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: whatsappnumberController,
      curve: Curves.easeIn,
    ));
    reqAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: reqController,
      curve: Curves.easeIn,
    ));
    titleANimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: reqController,
      curve: Curves.easeIn,
    ));
    animationController.forward();
    whatsappnumberController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        whatsappnumberController.reverse();
      }
      if (status == AnimationStatus.dismissed && whatsappnumberCounter < 2) {
        whatsappnumberController.forward();
        whatsappnumberCounter++;
      }
    });
    reqController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        reqController.reverse();
      }
      if (status == AnimationStatus.dismissed && reqCounter < 2) {
        reqController.forward();
        reqCounter++;
      }
    });
    titleController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        titleController.reverse();
      }
      if (status == AnimationStatus.dismissed && titleCounter < 2) {
        titleController.forward();
        titleCounter++;
      }
    });
  }

  @override
  void dispose() {
    reqController.dispose();
    titleController.dispose();
    animationController.dispose();
    whatsappnumberController.dispose();

    super.dispose();
  }

  @override
  String getTag() {
    return "Visa-Enquire-Bottom-Controller";
  }
}
