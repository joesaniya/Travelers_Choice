import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:line_icons/line_icons.dart';

import '../../models/tickets.dart';
import '../../views/hotel_travel_constants.dart';

class ViewOptionsController extends FxController {
  TickerProvider ticker;
  ViewOptionsController(this.ticker);
  bool uiLoading = true;
  List<Tickets>? tickets;
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late TextEditingController SearchTE;
  late Tween<Offset> offset;
  late AnimationController searchController;
  late Animation<Offset> searchAnimation;
  late Animation<Offset> animation, dateAnimation;
  late Animation<double> sizeAnimation, cartAnimation, paddingAnimation;
  late AnimationController fadeController, cartController, dateController;
  bool addCart = false;

  int searchCounter = 0;
  List<Map<String, dynamic>> featuresList = [
    {
      'title': 'Free wifi',
      'icon': LineIcons.wifi,
    },
    {
      'title': 'view',
      'icon': LineIcons.eye,
    },
    {
      'title': 'Air conditioning',
      'icon': LineIcons.snowflake,
    },
    {
      'title': 'Private bathroom',
      'icon': LineIcons.bath,
    },
    {
      'title': 'Flast-screen TV',
      'icon': LineIcons.television,
    },
  ];

  String? selectedroom;
  final List<String> roomCodes = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];

  bool? check1 = false;

  void fetchloader() async {
    await Future.delayed(const Duration(seconds: 4));

    uiLoading = false;
    log('fetchloader');
    log(uiLoading.toString());
    update();
  }

  void goBack() {
    Navigator.pop(context);
  }

  void fetchData() {
    tickets = HotelTravelCache.tickets;

    log('selectedtickets:$tickets');

    update();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchloader();
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: ticker,
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    SearchTE = TextEditingController();
    searchController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    searchAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: searchController,
      curve: Curves.easeIn,
    ));

    offset = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));
    searchController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        searchController.reverse();
      }
      if (status == AnimationStatus.dismissed && searchCounter < 2) {
        searchController.forward();
        searchCounter++;
      }
    });
    animationController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: ticker,
    );
    cartController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: ticker,
    );
    animation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(15, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    cartAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 24, end: 28), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 28, end: 24), weight: 50)
    ]).animate(cartController);
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: fadeController,
        curve: Curves.easeIn,
      ),
    );
    paddingAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 16, end: 14), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 14, end: 16), weight: 50)
    ]).animate(cartController);
    fadeController.forward();
    cartController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        addCart = true;
        update();
      }
      if (status == AnimationStatus.dismissed) {
        addCart = false;
        update();
      }
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    searchController.dispose();
    fadeController.dispose();
    cartController.dispose();
    super.dispose();
  }

  @override
  String getTag() {
    return "Search-Hotel-Controller";
  }
}
