import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutx/flutx.dart';

import 'package:hotel_travel/models/all_attraction_modal.dart';
import '../models/product.dart';

import '../views/detail_screen/detail_Screen.dart';
import '../views/hotel_travel_constants.dart';

class HomeController extends FxController {
  TickerProvider ticker;
  HomeController(this.ticker);
  // List<Category>? categories;
  List<Product>? products;
  List<AllattractionModal> allattractionList = <AllattractionModal>[];
  bool uiLoading = true;
  // late Category selectedCategory;
  late AnimationController animationController;
  late AnimationController bellController;
  late Animation<double> scaleAnimation,
      slideAnimation,
      fadeAnimation,
      bellAnimation;
  late Tween<Offset> offset;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<Widget> newCategories = [];

  late Intro intro;
  String? selectedCountryCode;
  final focus = FocusNode();
  final scrollController = ScrollController();
  final itemsPerPage = 10;
  var loadedItems = 0;
  var items = <String>[];

  void scrollListener() {
    log('scroll listener calling');
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    await Future.delayed(
        const Duration(seconds: 1)); // simulate network latency
    log('loadmore items calling');
    items.addAll(_generateItems(loadedItems, itemsPerPage));
    loadedItems += itemsPerPage;
    update();
  }

  List<String> _generateItems(int start, int count) {
    return List.generate(count, (index) => 'Item ${start + index + 1}');
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    fetchData();
    fetchloader();
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: ticker,
    );
    bellController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: ticker,
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );

    bellAnimation = Tween<double>(begin: -0.04, end: 0.04).animate(
      CurvedAnimation(
        parent: bellController,
        curve: Curves.linear,
      ),
    );

    offset = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));

    animationController.forward();
    bellController.repeat(reverse: true);

    intro = Intro(
      stepCount: 2,
      maskClosable: true,
      onHighlightWidgetTap: (introStatus) {
        print(introStatus);
      },
      widgetBuilder: StepWidgetBuilder.useDefaultTheme(
        texts: [
          'Get your notifications from here',
          // 'Attractions of the hotel',
          'Search Your best Hotels',
        ],
        buttonTextBuilder: (currPage, totalPage) {
          return currPage < totalPage - 1 ? 'Next' : 'Finish';
        },
      ),
    );

    intro.setStepConfig(0, borderRadius: BorderRadius.circular(64));
    Timer(
      const Duration(milliseconds: 2000),
      () {
        if (HotelTravelCache.isFirstTime) {
          // intro.start(context);
          HotelTravelCache.isFirstTime = false;
        }
      },
    );
  }

  startIntro() {
    intro.start(context);
  }

  void goBack() {
    Navigator.pop(context);
  }

  String? currencies, countryCode;

  String? currency() {
    if (currencies != null) {
      List<dynamic> countriesList = jsonDecode(currencies!);
      String? isoCode;

      log("Country list => $countriesList");
      print('''
Country Code => $countryCode
''');
      for (var val in countriesList) {
        if (val['country']['_id'] == countryCode) {
          isoCode = val['isocode'];
          break;
        }
      }
      return isoCode;
    }
    return null;
  }

  Future<bool> onWillPop() async {
    IntroStatus introStatus = intro.getStatus();
    if (introStatus.isOpen) {
      intro.dispose();
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    scrollController.dispose();
    bellController.dispose();
    super.dispose();
  }

  void fetchData() {
    // categories = HotelTravelCache.categories!.cast<Category>();
    // // products = HotelTravelCache.products;
    // selectedCategory = categories!.first;
    log('selectedCategory');
    // log(selectedCategory.)
    // uiLoading = false;
    // log(uiLoading.toString());
    update();
  }

  // void changeSelectedCategory(Category category) {
  //   selectedCategory = category;
  //   update();
  // }

  void fetchloader() async {
    await Future.delayed(const Duration(seconds: 1));

    uiLoading = false;
    log('fetchloader');
    log(uiLoading.toString());
    update();
  }

  // void changeSelectedCategory(Category category) {
  //   selectedCategory = category;
  //   update();
  // }

  void goToSingleProduct(
    Datum product,
    // currencySymbol, conversionRate
  ) {
    log(product.id);
    log('Slug:${product.slug}');
    log('message');
    // print(currencySymbol);
    // print("utfyjhvbn  $conversionRate");
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
            product,
            product.slug
            //   currencySymbol:currencySymbol,
            // conversionRate: conversionRate
            )
        // SingleProductScreen(product.id)
        ));
  }

  // final List<AllattractionModal> favouriteMeals = [];
  // final List<AllattractionModal> availableMeals = <AllattractionModal>[];

  // void _toggleFavorite(String mealId) async {
  //   await AttractionController().getAllattractionList(context).then((value) {
  //     if (value != null) {
  //       // isLoading = false;
  //       allattractionList = [];
  //       allattractionList.add(value);
  //       log('data All1:$allattractionList');
  //     }
  //   });
  //   log('All Data:${allattractionList.first.attractions.data.length}');
  //   log('toggle');

  //   final existingIndex = _favouriteMeals
  //       .indexWhere((meal) => meal.attractions.data.first.id == mealId);
  //   if (existingIndex >= 0) {
  //     _favouriteMeals.removeAt(existingIndex);
  //     update();
  //   } else {
  //     // _favouriteMeals.add(
  //     //   _availableMeals
  //     //       .firstWhere((meal) => meal.attractions.data.first.id == mealId),
  //     // );
  //     log('All Data:${allattractionList.first.attractions.data.length}');
  //     // AllattractionModal objmodal=a
  //     _favouriteMeals.add(
  //       allattractionList
  //           .firstWhere((meal) => meal.attractions.data.first.id == mealId),
  //     );
  //   }
  // }

  // bool _isMealFavorite(String id) {
  //   return _favouriteMeals.any((meal) => meal.attractions.data.first.id == id);
  // }

  void goToSubscription() {
    // Navigator.of(context, rootNavigator: true).push(
    //   MaterialPageRoute(
    //     builder: (context) => SubscriptionScreen(),
    //   ),
    // );
  }

  void goToNotification() {
    // Navigator.of(context, rootNavigator: true).push(
    //   MaterialPageRoute(
    //     builder: (context) => NotificationScreen(),
    //   ),
    // );
  }

  @override
  String getTag() {
    return "home_controller";
  }
}
