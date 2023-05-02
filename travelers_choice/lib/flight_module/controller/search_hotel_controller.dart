import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../../models/tickets.dart';
import '../../views/hotel_travel_constants.dart';

class SearchHotelController extends FxController {
  TickerProvider ticker;
  SearchHotelController(this.ticker);
  bool uiLoading = true;
  List<Tickets>? tickets;
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late TextEditingController SearchTE;
  late Tween<Offset> offset;
  late AnimationController searchController;
  late Animation<Offset> searchAnimation;

  int searchCounter = 0;

  void fetchloader() async {
    await Future.delayed(const Duration(seconds: 4));

    uiLoading = false;
    log('fetchloader');
    log(uiLoading.toString());
    update();
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
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  String getTag() {
    return "Search-Hotel-Controller";
  }
}
