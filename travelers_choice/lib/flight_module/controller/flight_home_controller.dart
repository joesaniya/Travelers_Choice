import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class FlightHomeController extends FxController {
  TickerProvider ticker;
  FlightHomeController(this.ticker);
  bool uiLoading = true;
  String tabbed = '1';

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
  void dispose() {
    
    super.dispose();
  }
  @override
  String getTag() {
    return "FlightHome-Controller";
  }
}
