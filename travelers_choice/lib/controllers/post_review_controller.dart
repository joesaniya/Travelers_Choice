import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/get_reviews.dart';
import '../services/app_constants.dart';
import '../services/review_Service.dart';

class PostReviewController extends FxController {
  TickerProvider ticker;
  PostReviewController(this.ticker);
  late Animation<double> fadeAnimation;
  late AnimationController animationController, reqController, titleController;
  late Animation<Offset> reqAnimation, titleANimation;
  int reqCounter = 0;
  int titleCounter = 0;
  late TextEditingController reqTE, titleTE;
  double? ratingValue;
  String? token;
  List<GetReview>? reviewsget;

  Future<GetReview?> ReviewAdd(String place, String title, String description,
      String rating, String token) async {
    // isCountryListLoading = true;
    try {
      var data = await ReviewService()
          .ReviewPost(place, title, description, rating, context, token);
      reviewsget!.clear();
      if (data != null) {
        reviewsget!.add(data);

        return data; //removed true
      } else {
        return null; //falseremoved
      }
    } catch (e) {
      rethrow;
    }
  }

  //todo
  List<GetReview> allreview = <GetReview>[];
  bool isAllAttractionListLoading = true;
  Future<GetReview?> FilterattractionList(
      place, title, description, rating, token) async {
    // isCountryListLoading = true;
    try {
      var data = await ReviewService()
          .ReviewPost(place, title, description, rating, context, token);
      allreview.clear();
      if (data != null) {
        allreview.add(data);
        // isCountryListLoading = false;
        log('Controller:$data');
        return data; //removed true
      } else {
        return null; //falseremoved
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPrefValue) {
      token = sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN);
      log(token.toString());
    });
    reqTE = TextEditingController();
    titleTE = TextEditingController();
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: ticker,
    );
    titleController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    reqController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    reqAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: reqController,
      curve: Curves.easeIn,
    ));
    titleANimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: reqController,
      curve: Curves.easeIn,
    ));
    animationController.forward();
    reqController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        reqController.reverse();
      }
      if (status == AnimationStatus.dismissed && reqCounter < 2) {
        reqController.forward();
        reqCounter++;
      }
    });
    titleController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        titleController.reverse();
      }
      if (status == AnimationStatus.dismissed && titleCounter < 2) {
        titleController.forward();
        titleCounter++;
      }
    });
  }

  @override
  void dispose() {
    reqController.dispose();
    titleController.dispose();
    animationController.dispose();

    super.dispose();
  }

  void Upload(Attractionplace) async {
    log('upload clicked');
    if (reqTE.text != null || titleTE.text != null || ratingValue != null) {
      //todo
      log('not equal');
      GetReview? temp = await ReviewAdd(
        Attractionplace.toString(),
        titleTE.text,
        reqTE.text,
        ratingValue.toString(),
        token.toString(),
      );

      reviewsget = [];

      reviewsget!.add(temp!);

      Navigator.pop(context, temp);
      // await ReviewAPIController()
      //     .postReview(Attractionplace, 'hh', 'hhh', '1', context, token!)
      //     .then((value) {
      //   if (value) {
      //     log('if');
      //   }
      // });
      // Navigator.pop(context);
    } else {
      print("Data search Null");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Fill All Fields')));
    }
  }

  @override
  String getTag() {
    return "post_review_controller";
  }
}
