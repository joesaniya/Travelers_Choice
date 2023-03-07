import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/views/detail_screen/Activity_screen.dart';
import 'package:intl/intl.dart';

import '../models/all_attraction_modal.dart';
import '../models/atteraction_model.dart';
import '../../controllers/attraction_Controller.dart';
import '../views/detail_screen/review_Screen.dart';

class ViewOrderController extends FxController {
  TickerProvider ticker;
  ViewOrderController(this.ticker);





 

  @override
  void initState() {
    super.initState();
    //new
   
  }

  @override
  void dispose() {
  
    super.dispose();
   
  }



  //revie
  // Future<void> REviewPage(
  //     // DetailattractionModal review
  //     String id) async {
  //   animationController.forward();
  //   await Future.delayed(const Duration(seconds: 1));
  //   Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
  //       transitionDuration: const Duration(milliseconds: 500),
  //       transitionsBuilder: (
  //         BuildContext context,
  //         Animation<double> animation,
  //         Animation<double> secondaryAnimation,
  //         Widget child,
  //       ) =>
  //           FadeTransition(
  //             opacity: animation,
  //             child: child,
  //           ),
  //       pageBuilder: (_, __, ___) => ReviewScreen(
  //           Id: id,
  //           // reviews: review.reviews
  //           rating: detailattraction!.first.averageRating,
  //           TotalRatingCount: detailattraction!.first.totalRating)
  //       // ActivityScreen(
  //       //   Excursions: widget.detailattraction
  //       //   )
  //       ));
  // }



  void goBack() {
    Navigator.pop(context);
  }

  

 

  @override
  String getTag() {
    return "Detail_controller";
  }
}
