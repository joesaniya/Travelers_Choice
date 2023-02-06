import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import 'package:intl/intl.dart';

import '../models/all_attraction_modal.dart';
import '../models/product.dart';
import '../views/detail_screen/detail_Screen.dart';
import '../views/hotel_travel_constants.dart';

class HomeSearchController extends FxController {
  TickerProvider ticker;
  HomeSearchController(this.ticker);

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> selectedChoices = [];
  RangeValues selectedRange = const RangeValues(200, 800);
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  List<Product>? products;
  late TextEditingController dateTE;
  bool uiLoading = true;

  late Tween<Offset> offset;
  late AnimationController dateController;
  late Animation<Offset> dateAnimation;

  int dateCounter = 0;

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  List<String> categoryList = [
    "Theme Park",
    "Theme Park 1",
    "Theme Park 2",
    "Theme Park 3",
    "Theme Park 4",
    "Theme Park 5",
  ];

  void addChoice(String item) {
    selectedChoices.add(item);
    update();
  }

  void removeChoice(String item) {
    selectedChoices.remove(item);
    update();
  }

  void onChangePriceRange(RangeValues newRange) {
    selectedRange = newRange;
    update();
  }

  void fetchData() {
    // categories = HotelTravelCache.categories;
    products = HotelTravelCache.products;
    // selectedCategory = categories!.first;
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

    offset = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));

    animationController.forward();

    dateTE = TextEditingController();

    dateController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));

    dateAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: dateController,
      curve: Curves.easeIn,
    ));

    dateController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        dateController.reverse();
      }
      if (status == AnimationStatus.dismissed && dateCounter < 2) {
        dateController.forward();
        dateCounter++;
      }
    });
  }

  Future<void> dateselect() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            1900), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate);
      dateTE.text = formattedDate;

      // setState(() {
      //   dateinput.text = formattedDate; //set output date to TextField value.
      // });
    } else {
      print("Date is not selected");
    }
  }

  void goToSingleProduct(Datum product) {
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
        pageBuilder: (_, __, ___) => DetailScreen(product.id)));
  }

  void openEndDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void closeEndDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  String getTag() {
    return "search_controller";
  }
}
