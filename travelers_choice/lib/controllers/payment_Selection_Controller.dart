import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class payemtSelectionController extends FxController {
  TickerProvider ticker;
  payemtSelectionController(this.ticker);

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool selected = true;

  @override
  void dispose() {
    super.dispose();
  }

  // void goToSingleProduct(Product product) {
  //   Navigator.of(context, rootNavigator: true).push(
  //     PageRouteBuilder(
  //         transitionDuration: const Duration(seconds: 1),
  //         pageBuilder: (_, __, ___) => SingleProductScreen(product)),
  //   );
  // }

  void openEndDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void closeEndDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  String getTag() {
    return "payment_Selection_Controller";
  }
}
