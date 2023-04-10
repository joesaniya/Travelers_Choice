import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../../models/tickets.dart';
import '../../views/hotel_travel_constants.dart';
import '../views/flight_home_screen.dart';

class FlightListController extends FxController {
  TickerProvider ticker;
  FlightListController(this.ticker);
  bool uiLoading = true;
  late AnimationController animationController;
  List<Tickets>? tickets;
  bool adddate = false;
  String tabbed = '1';
  late AnimationController cartController;
  late Animation<double> cartAnimation, fadeAnimation;

  //customdate
  DateTime selectedDate = DateTime.now(); // TO tracking date

  int currentDateSelectedIndex = 0; //For Horizontal Date
  ScrollController scrollController =
      ScrollController(); //To Track Scroll of ListView

  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  //

  final List<String> flightnameList = [
    'Non Stop',
    'Morning Departures',
    'Indigo',
    'Vistara',
    'Air India',
    'Go First',
    'Air Asia',
    'Late Departures',
    '1 Stop'
  ];
  List<String> selectedChoices = [];
  int? defaultChoiceIndex;

  void goBack({bool? canRefresh}) {
    Navigator.pop(context, canRefresh);
  }

  void addChoice(String item) {
    selectedChoices.add(item);
    update();
  }

  void removeChoice(String item) {
    selectedChoices.remove(item);
    update();
  }

  void Edit() {
    log('Edit Calling');
    Navigator.of(context, rootNavigator: true).pushReplacement(
      PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (_, __, ___) => const FlightHomeScreen()),
    );
  }

  void fetchloader() async {
    await Future.delayed(const Duration(seconds: 4));

    uiLoading = false;
    log('fetchloader');
    log(uiLoading.toString());
    update();
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      // Load more data
    }
  }

  @override
  void initState() {
    fetchData();
    fetchloader();
    defaultChoiceIndex = 0;
    scrollController.addListener(scrollListener);
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

    log('selectedtickets:$tickets');

    update();
  }

  @override
  void dispose() {
    animationController.dispose();
    cartController.dispose();
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  String getTag() {
    return "FlightList-Controller";
  }
}
