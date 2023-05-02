import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class FilterSheetController extends FxController {
  TickerProvider ticker;
  FilterSheetController(this.ticker);

  int? defaultChoiceIndex;
  int roomscount = 1;

  void roomsincrement() {
    if (roomscount >= 0 && roomscount < 100) {
      roomscount++;
    }
    update();
  }

  void roomsdecrement() {
    if (roomscount > 1) {
      roomscount--;
    }
    update();
  }

  int childcount = 0;

  void childincrement() {
    if (childcount >= 0 && childcount < 100) {
      childcount++;
    }
    update();
  }

  void childdecrement() {
    if (childcount > 1) {
      childcount--;
    }
    update();
  }

  int adultscount = 0;

  void adultsincrement() {
    if (adultscount >= 0 && adultscount < 100) {
      adultscount++;
    }
    update();
  }

  void adultsdecrement() {
    if (adultscount > 1) {
      adultscount--;
    }
    update();
  }

  RangeValues selectedRange = const RangeValues(80, 800);
void onChangePriceRange(RangeValues newRange) {
    selectedRange = newRange;
    update();
  }
  @override
  String getTag() {
    return "Filter-sheet-Controller";
  }
}
