import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../../models/tickets.dart';
import '../../views/hotel_travel_constants.dart';
import '../views/flight_list.dart';

class MultiCityController extends FxController {
  TickerProvider ticker;
  MultiCityController(this.ticker);

  bool adddate = false;
  late TextEditingController nameController;

  DateTimeRange? selectedDateRange;
  DatePickerController datetimecontroller = DatePickerController();
  List<Tickets>? tickets;
  DateTime selectedValue = DateTime.now();

  late AnimationController animationController;

  late AnimationController cartController;
  late Animation<double> cartAnimation, fadeAnimation;
  
  
  
  @override
  initState() {
    super.initState();
    fetchData();
    nameController = TextEditingController();
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

  void fetchData() {
    tickets = HotelTravelCache.tickets;

    log('selectedCategory:$tickets');

    update();
  }

  void searchflights() {
    log('calling search flights');
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   PageRouteBuilder(
    //       transitionDuration: const Duration(seconds: 2),
    //       pageBuilder: (_, __, ___) => const FlightList()),
    // );
      Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) =>
            FadeTransition(
              opacity: animation,
              child: child,
            ),
        pageBuilder: (_, __, ___) => const FlightList()));
  }

  @override
  void dispose() {
    animationController.dispose();
    cartController.dispose();
    super.dispose();
  }

  @override
  String getTag() {
    return "MultiCity-Controller";
  }
}
