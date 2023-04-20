import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class HotelHomeController extends FxController {
  TickerProvider ticker;
  HotelHomeController(this.ticker);
  bool uiLoading = true;
  

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
  }

  @override
  String getTag() {
    return "Hotel_Home-Controller";
  }
}
