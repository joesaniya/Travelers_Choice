import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class RoundTripController extends FxController {
  TickerProvider ticker;
  RoundTripController(this.ticker);

  String returndate = '1';

  DateTimeRange? selectedDateRange;

  // // This function will be triggered when the floating button is pressed
  void showdate() async {
    final DateTimeRange? result = await showDateRangePicker(
        context: context,
        // firstDate: DateTime(2022, 1, 1),
        // lastDate: DateTime(2030, 12, 31),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 40),
        currentDate: DateTime.now(),
        saveText: 'Done',
        builder: (context, child) {
          log('data');
          return Theme(
            data: Theme.of(context).copyWith(
              cardColor: Colors.yellow,
              colorScheme: const ColorScheme.light(
                background: Colors.white,

                primary: Color(0xff1529e8), // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                onSurface: Colors.grey, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });

    if (result != null) {
      // Rebuild the UI
      print(result.start.toString());

      selectedDateRange = result;
      update();
    }
  }

  @override
  String getTag() {
    return "OneWay-Controller";
  }
}
