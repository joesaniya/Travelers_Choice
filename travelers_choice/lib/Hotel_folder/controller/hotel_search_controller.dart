import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:intl/intl.dart';

class HotelSearchController extends FxController {
  TickerProvider ticker;
  HotelSearchController(this.ticker);

  late TextEditingController checkInTE, checkOutTE;
  GlobalKey<FormState> formKey = GlobalKey();
  late AnimationController arrowController,
      checkInController,
      checkOutController;
  late Animation<Offset> arrowAnimation, checkInAnimation, checkOutAnimation;
  int emailCounter = 0;
  int passwordCounter = 0;
  DateTime selectedValue = DateTime.now();

  

  @override
  void initState() {
    super.initState();
    DateTime newdate = DateTime.now();
    DateTime newdate2 = selectedValue;
    log('Calener:${selectedValue.toString()}');
    String formattedYear = DateFormat('EEEE, yyyy').format(newdate);
    checkInTE = TextEditingController();
    checkOutTE = TextEditingController();
    arrowController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    checkOutController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    checkInController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));

    arrowAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    checkInAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: checkOutController,
      curve: Curves.easeIn,
    ));
    checkOutAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: checkInController,
      curve: Curves.easeIn,
    ));

    checkOutController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkOutController.reverse();
      }
      if (status == AnimationStatus.dismissed && emailCounter < 2) {
        checkOutController.forward();
        emailCounter++;
      }
    });

    checkInController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkInController.reverse();
      }
      if (status == AnimationStatus.dismissed && passwordCounter < 2) {
        checkInController.forward();
        passwordCounter++;
      }
    });
  }

  @override
  void dispose() {
    arrowController.dispose();
    checkOutController.dispose();
    checkInController.dispose();
    super.dispose();
  }

  String? validateCheckIn(String? text) {
    if (text == null || text.isEmpty) {
      checkOutController.forward();
      return "Please enter Checkin";
    }
    return null;
  }

  String? validateCheckOut(String? text) {
    if (text == null || text.isEmpty) {
      checkInController.forward();

      return "Please enter Checkout";
    }
    return null;
  }

  Future<void> login() async {
    emailCounter = 0;
    passwordCounter = 0;
    // if (checkInTE.text.isEmpty) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("Please enter name")));
    // } else if (checkInTE.text.isEmpty) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("Please enter email")));
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("success")));
    //   arrowController.forward();
    //   await Future.delayed(Duration(milliseconds: 500));
    //   await AuthController().login(checkInTE.text, checkOutTE.text).then(
    //       (value) => Navigator.of(context, rootNavigator: true).pushReplacement(
    //             MaterialPageRoute(
    //               builder: (context) => SplashScreen2(),
    //             ),
    //           ));
    //   // log(value));
    // }
    if (formKey.currentState!.validate()) {
      arrowController.forward();
      await Future.delayed(const Duration(milliseconds: 1000));
      log('validate');

      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text("Invalid Credentials")));

      // Navigator.of(context, rootNavigator: true).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const SplashScreen2(),
      //   ),
      // );
    }
  }

  void redirect() {
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) =>  PaymentCC(),
    //   ),
    // );
  }

  @override
  String getTag() {
    return "Hotel_search_controller";
  }
}
