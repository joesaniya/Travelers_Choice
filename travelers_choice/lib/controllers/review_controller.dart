import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutx/flutx.dart';

import '../models/get_reviews.dart';
import '../views/hotel_travel_constants.dart';
import 'review_api_controller.dart';

class ReviewController extends FxController {
  TickerProvider ticker;
  ReviewController(this.ticker);
  List<GetReview>? reviewsget;

  bool uiLoading = true, isLoading = true;
  late Animation<double> fadeAnimation;
  late AnimationController fadeController;

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<Widget> newCategories = [];
  late Intro intro;
  getReviews(id, setState) {
    log('getDetail Attraction function called');

    Future.delayed(Duration.zero, () async {
      await ReviewAPIController().getReviewList(productid: id).then((value) {
        log('Details => $value');
        if (value != null) {
          isLoading = false;
          reviewsget = [];
          // reviewsget!.add(value as GetReview);
          // detailattraction = value;
          setState(() {
            reviewsget = value;
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchloader();
    fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: ticker,
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: fadeController,
        curve: Curves.easeIn,
      ),
    );
    fadeController.forward();

    intro = Intro(
      stepCount: 2,
      maskClosable: true,
      onHighlightWidgetTap: (introStatus) {
        // log(introStatus);
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
    fadeController.dispose();

    super.dispose();
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
