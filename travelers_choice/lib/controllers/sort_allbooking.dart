import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class SortAllBookingController extends FxController {
  TickerProvider ticker;
  SortAllBookingController(this.ticker);

  int? defaultChoiceIndex;
  
  int radioValue = 0;

  
  @override
  String getTag() {
    return "Sort-sheet-Controller";
  }
}
