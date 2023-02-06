import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutx/flutx.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../views/hotel_travel_constants.dart';

class AllBookingController extends FxController {
  TickerProvider ticker;
  AllBookingController(this.ticker);
  List<Category>? categories;
  List<Product>? products;
  bool uiLoading = true;
  late Category selectedCategory;
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

  @override
  void initState() {
    super.initState();
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
    bellController.dispose();
    super.dispose();
  }

  void fetchData() {
    categories = HotelTravelCache.categories;
    products = HotelTravelCache.products;
    selectedCategory = categories!.first;
    // uiLoading = false;
    // log(uiLoading.toString());
    update();
  }

  void fetchloader() async {
    await Future.delayed(const Duration(seconds: 4));

    uiLoading = false;
    log('fetchloader');
    log(uiLoading.toString());
    update();
  }

  void changeSelectedCategory(Category category) {
    selectedCategory = category;
    update();
  }

  void goToSingleProduct(Product product) {
    log(product.name);
    log('message');
    // Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
    //         transitionDuration: const Duration(milliseconds: 500),
    //         transitionsBuilder: (
    //           BuildContext context,
    //           Animation<double> animation,
    //           Animation<double> secondaryAnimation,
    //           Widget child,
    //         ) =>
    //             FadeTransition(
    //               opacity: animation,
    //               child: child,
    //             ),
    //         pageBuilder: (_, __, ___) => SingleProductScreen(product))
    //     // PageRouteBuilder(
    //     //     transitionDuration: const Duration(seconds: 1),
    //     //     pageBuilder: (_, __, ___) => SingleProductScreen(product)),
    //     );
  }

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
    return "AllBooking Controller";
  }
}
