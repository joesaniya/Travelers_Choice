import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class RoundTripController extends FxController {
  TickerProvider ticker;
  RoundTripController(this.ticker);

  String returndate = '1';
   bool adddate = false;

  DateTimeRange? selectedDateRange;
  late AnimationController animationController;

  late AnimationController cartController;
  late Animation<double> cartAnimation, fadeAnimation;
  

  // // This function will be triggered when the floating button is pressed
  void showdate() async {
    final DateTimeRange? result = await showDateRangePicker(
        context: context,
        // firstDate: DateTime(2022, 1, 1),
        // lastDate: DateTime(2030, 12, 31),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 40),
        currentDate: DateTime.now(),
        saveText: 'Done',
        builder: (context, child) {
          log('data');
          return Theme(
            data: Theme.of(context).copyWith(
              cardColor: Colors.yellow,
              colorScheme: const ColorScheme.light(
                background: Colors.white,

                primary: Color(0xff1529e8), // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                onSurface: Colors.grey, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });

    if (result != null) {
      // Rebuild the UI
      log(result.start.toString());

      selectedDateRange = result;
      update();
    }
  }

   @override
  initState() {
    super.initState();
    
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

    cartController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        adddate = true;
        update();
      }
      if (status == AnimationStatus.dismissed) {
        adddate = false;
        update();
      }
    });
    animationController.forward();
  }
  @override
  void dispose() {
    animationController.dispose();
    cartController.dispose();
    super.dispose();
  }

  @override
  String getTag() {
    return "OneWay-Controller";
  }
}
