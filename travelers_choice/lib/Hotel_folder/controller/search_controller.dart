import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class HotelSearchController extends FxController {
  TickerProvider ticker;
  HotelSearchController(this.ticker);
  bool uiLoading = true;
 late TextEditingController SearchTE;
  late AnimationController arrowController,
      searchController;
  late Animation<Offset> arrowAnimation,
      SearchAnimation;
  int SearchCounter = 0;
  GlobalKey<FormState> formKey = GlobalKey();

  

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
    fetchloader();
    SearchTE = TextEditingController();
    arrowController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    searchController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
        arrowAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    SearchAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: searchController,
      curve: Curves.easeIn,
    ));

     searchController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        searchController.reverse();
      }
      if (status == AnimationStatus.dismissed && SearchCounter < 2) {
        searchController.forward();
        SearchCounter++;
      }
    });
  }

    String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      searchController.forward();
      return "Please enter email";
    }
    //else if (FxStringValidator.isEmail(text)) {
    //   emailController.forward();
    //   return "Please enter valid email";
    // }
    return null;
  }

   @override
  void dispose() {
    arrowController.dispose();
    searchController.dispose();
    
    super.dispose();
  }


  @override
  String getTag() {
    return "Hotel_saerxh-Controller";
  }
}
