import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class SortFilterController extends FxController {
  TickerProvider ticker;
  SortFilterController(this.ticker);

  final List<String> stopsfromchennaiList = [
    'Non Stop',
    '1 Stop'
  ];
  List<String> selectedChoices = [];

  int? defaultChoiceIndex;
   void addChoice(String item) {
    selectedChoices.add(item);
    update();
  }

  void removeChoice(String item) {
    selectedChoices.remove(item);
    update();
  }
 
  @override
  String getTag() {
    return "Sort-Filter-Controller";
  }
}
