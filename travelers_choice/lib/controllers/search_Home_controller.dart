import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/services/Search_Service.dart';

import 'package:intl/intl.dart';

import '../models/all_attraction_modal.dart';
import '../models/product.dart';
import '../models/search_categories_modal.dart';
import '../views/detail_screen/detail_Screen.dart';
import '../views/hotel_travel_constants.dart';

class HomeSearchController extends FxController {
  TickerProvider ticker;
  HomeSearchController(this.ticker);

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  SearchCategoriesModal? selectedChoices;
  RangeValues selectedRange = const RangeValues(200, 800);
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  List<Product>? products;
  late TextEditingController dateTE, SearchTE;
  bool uiLoading = true;

  late Tween<Offset> offset;
  late AnimationController dateController, searchController;
  late Animation<Offset> dateAnimation, searchAnimation;

  int dateCounter = 0;
  int searchCounter = 0;
  List<AllattractionModal> searchReasult = <AllattractionModal>[];
  List<AllattractionModal>? allattractionList;

  late List<AllattractionModal> foundrecipe;

  //categories
  List<SearchCategoriesModal> categoryattraction = <SearchCategoriesModal>[];

  bool isLoading = true;
  String? categoryid;

  getcategoryAttraction(productid, setState) {
    log('getDetail Attraction function called');
    Future.delayed(Duration.zero, () async {
      await SearchService()
          .getCategories()
          // (
          //   // productid: productid
          //   )
          .then((value) {
        log('Details => $value');
        if (value != null) {
          isLoading = false;
          // detailattraction = value;
          setState(() {
            categoryattraction = value;
          });
          log('Category Attraction:$categoryattraction');
        }
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
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

  void addChoice(SearchCategoriesModal item) {
    categoryid = item.id;
    selectedChoices = (item);
    update();
  }

  void removeChoice(SearchCategoriesModal item) {
    selectedChoices = (item);
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

  void attractFilter(String enteredKeyword) {
    print('runFilters');
    List results = [];
    if (enteredKeyword.isEmpty) {
      print('runFilters if');
      results = searchReasult.cast<Map<String, dynamic>>();
    } else {
      print('runFilters else');
      results = searchReasult
          .where((AllattractionModal) => AllattractionModal
              .attractions.data.first.title
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      print(results);
    }
    foundrecipe = results.cast<AllattractionModal>();

    // setState(() {
    //   print('set state');
    //   foundrecipe = results.cast<AllattractionModal>();

    // });
  }

  void runFilter1(String enteredKeyword) {
    print('runFilters');
    List results = [];
    if (enteredKeyword.isEmpty) {
      print('runFilters if');
      results = searchReasult.cast<Map<String, dynamic>>();
    } else {
      print('runFilters else');
      results = searchReasult
          .where((Recipe) => Recipe.attractions.data.first.title
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      print(results);
    }

    foundrecipe = results.cast<AllattractionModal>();
  }

  @override
  void initState() {
    super.initState();
    foundrecipe = searchReasult;
    fetchData();
    fetchloader();
    SearchTE = TextEditingController();
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: ticker,
    );
    searchController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    searchAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: searchController,
      curve: Curves.easeIn,
    ));

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
    searchController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        searchController.reverse();
      }
      if (status == AnimationStatus.dismissed && searchCounter < 2) {
        searchController.forward();
        searchCounter++;
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
        pageBuilder: (_, __, ___) => DetailScreen(
            product.id,
            //  _toggleFavorite, _isMealFavorite,
            product)));
  }

  final List<AllattractionModal> _favouriteMeals = [];
  final List<AllattractionModal> _availableMeals = <AllattractionModal>[];

  void _toggleFavorite(String mealId) {
    final existingIndex = _favouriteMeals
        .indexWhere((meal) => meal.attractions.data.first.id == mealId);
    if (existingIndex >= 0) {
      _favouriteMeals.removeAt(existingIndex);
      update();
      // setState(() {
      //   _favouriteMeals.removeAt(existingIndex);
      // });
    } else {
      _favouriteMeals.add(
        <AllattractionModal>[]
            .firstWhere((meal) => meal.attractions.data.first.id == mealId),
      );
      // setState(() {
      //   _favouriteMeals.add(
      //      <AllattractionModal>[].firstWhere((meal) => meal.id == mealId),
      //   );
      // });
    }
  }

  bool _isMealFavorite(String id) {
    return _favouriteMeals.any((meal) => meal.attractions.data.first.id == id);
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
