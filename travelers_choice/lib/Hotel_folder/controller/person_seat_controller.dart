import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class RoomsList {
  int? adults;
  List? children;
  List? ages;
  RoomsList({this.adults, this.children, this.ages});
}

class PersonSeatController extends FxController {
  TickerProvider ticker;
  PersonSeatController(this.ticker);

  int? defaultChoiceIndex;
  int roomscount = 1;
  String? selectedage;
  final List<String> ageCodes = [
    '<1',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11'
  ];

  List<RoomsList> roomsList = [];

  List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  List<String> dropdownValues = List.generate(3, (index) => 'Option 1');
  void roomsincrement() {
    if (roomscount >= 0 && roomscount < 100) {
      roomscount++;
      for (var i = 0; i < roomscount; i++) {
        roomsList.add(RoomsList(adults: 0, children: [], ages: []));
      }
    }
    update();
  }

  void roomsdecrement() {
    if (roomscount > 1) {
      roomscount--;
      for (var i = 0; i < roomscount; i++) {
        roomsList.removeLast();
      }
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

  void adultsincrement(int index) {
    if (adultscount >= 0 && adultscount < 100) {
      adultscount++;
      roomsList[index].adults = adultscount;
    }
    update();
  }

  void adultsdecrement(int index) {
    if (adultscount > 1) {
      adultscount--;
        roomsList[index].adults = adultscount;
    }
    update();
  }

  @override
  String getTag() {
    return "Traveller-Class-Controller";
  }
}
