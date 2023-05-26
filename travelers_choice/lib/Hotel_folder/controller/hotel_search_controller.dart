import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:intl/intl.dart';

class HotelSearchController extends FxController {
  TickerProvider ticker;
  HotelSearchController(this.ticker);

  late TextEditingController checkInTE, checkOutTE, locationTE;
  GlobalKey<FormState> formKey = GlobalKey();
  late AnimationController arrowController,
      checkInController,
      checkOutController,
      locationController;
  late Animation<Offset> arrowAnimation,
      locationAnimation,
      checkInAnimation,
      checkOutAnimation;
  int emailCounter = 0;
  int passwordCounter = 0;
  int locationCounter = 0;
  final focus = FocusNode();
  DateTime selectedValue = DateTime.now();
  DateTime selectedCheckOut = DateTime.now();

  DateTime selectedDate = DateTime.now();

  var customFormat = DateFormat('dd-MM-yyyy');

  final List<Map<String, dynamic>> roles = [
    {"name": "Dubai", "desc": "Having full access rights", "role": 1},
    {
      "name": "Abu Dhabi",
      "desc": "Having full access rights of a Organization",
      "role": 2
    },
    {
      "name": "Sharjah",
      "desc": "Having Magenent access rights of a Organization",
      "role": 3
    },
    {
      "name": "Oman",
      "desc": "Having Technician Support access rights",
      "role": 4
    },
    {
      "name": "Customer Support",
      "desc": "Having Customer Support access rights",
      "role": 5
    },
    {"name": "User", "desc": "Having End User access rights", "role": 6},
  ];

  Future<void> showPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) selectedDate = picked;
    selectedValue = picked!;
    log('selected:$selectedValue');
    update();
  }

  // String? todaydate;
  String? formattedYear;
  @override
  void initState() {
    super.initState();
    // DateTime newdate = DateTime.now();
    // DateTime newdate2 = selectedValue;
    // log('Calener:${selectedValue.toString()}');
    // // String formattedYear = DateFormat('EEEE, yyyy').format(newdate);
    // formattedYear = DateFormat.MMMd().format(newdate);
    // // formattedYear = todaydate.toString();
    // // log('Today:$todaydate');
    // log('DateTime:$formattedYear');
    // String formattedYeardate = DateFormat.MMMd().format(newdate2);
    // log('year:$formattedYeardate');
    locationTE = TextEditingController();
    checkInTE = TextEditingController();
    checkOutTE = TextEditingController();
    locationController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
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
    locationAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: locationController,
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
    locationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        locationController.reverse();
      }
      if (status == AnimationStatus.dismissed && locationCounter < 2) {
        locationController.forward();
        locationCounter++;
      }
    });

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
    locationController.dispose();

    focus.dispose();
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
