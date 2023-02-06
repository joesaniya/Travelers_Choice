import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/views/detail_screen/single_product_screen.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../views/hotel_travel_constants.dart';

class ReviewController extends FxController {
  TickerProvider ticker;
  ReviewController(this.ticker);

  bool uiLoading = true;

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<Widget> newCategories = [];
  late Intro intro;

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchloader();

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

  void fetchData() {
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

  @override
  String getTag() {
    return "home_controller";
  }
}
