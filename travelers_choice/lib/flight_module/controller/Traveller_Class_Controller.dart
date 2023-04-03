import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class TravellerClassController extends FxController {
  TickerProvider ticker;
  TravellerClassController(this.ticker);

  int? defaultChoiceIndex;
  int adultcount = 1;

  void adultincrement() {
    if (adultcount >= 0 && adultcount < 100) {
      adultcount++;
    }
    update();
  }

  void  adultdecrement() {
    if (adultcount > 1) {
      adultcount--;
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

  int infantcount = 0;

  void infantincrement() {
    if (infantcount >= 0 && infantcount < 100) {
      infantcount++;
    }
    update();
  }

  void infantdecrement() {
    if (infantcount > 1) {
      infantcount--;
    }
    update();
  }

  @override
  String getTag() {
    return "Traveller-Class-Controller";
  }
}
