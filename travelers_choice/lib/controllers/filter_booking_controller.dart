import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class FilterAllBookingController extends FxController {
  TickerProvider ticker;
  FilterAllBookingController(this.ticker);

  int? defaultChoiceIndex;

  int radioValue = 0;

  @override
  String getTag() {
    return "Filter-sheet-Controller";
  }
}
