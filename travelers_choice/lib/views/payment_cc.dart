import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import '../models/all_attraction_modal.dart';
import '../models/atteraction_model.dart';
import '/theme/app_theme.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '/controllers/login_controller.dart';
import 'all_bookings.dart';

class PaymentCC extends StatefulWidget {
  String paymentdata;
  // double? totalAmount;
  String? totalAmount;
  PaymentCC({super.key, required this.paymentdata, this.totalAmount});
  // const PaymentCC({Key? key}) : super(key: key);

  @override
  _PaymentCCState createState() => _PaymentCCState();
}

class _PaymentCCState extends State<PaymentCC> with TickerProviderStateMixin {
  late ThemeData theme;
  late LogInController controller;
  late InAppWebViewController _webViewController;

  final List<AllattractionModal> _favouriteMeals = [];
  final List<Activity> _cartMeal = [];
  final List<AllattractionModal> _availableMeals = <AllattractionModal>[];

  void _toggleFavorite(String mealId) {
    final existingIndex = _favouriteMeals
        .indexWhere((meal) => meal.attractions.data.first.id == mealId);
    if (existingIndex >= 0) {
      _favouriteMeals.removeAt(existingIndex);
      setState(() {});
      // setState(() {
      //   _favouriteMeals.removeAt(existingIndex);
      // });
    } else {
      _favouriteMeals.add(
        _availableMeals
            .firstWhere((meal) => meal.attractions.data.first.id == mealId),
      );
      // setState(() {
      //   _favouriteMeals.add(
      //      <AllattractionModal>[].firstWhere((meal) => meal.id == mealId),
      //   );
      // });
    }
  }

  bool _isMealFavorite(String id) {
    return _favouriteMeals.any((meal) => meal.attractions.data.first.id == id);
  }

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    log('Payment cc:${widget.paymentdata}');
    log('Payment total:${widget.totalAmount}');
    controller = FxControllerStore.put(LogInController(this));
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<LogInController>(
        controller: controller,
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              log('onwillpop called');
              Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>
                        // const HistoryScreen()
                        const AllBookings()
                    // FullApp(_favouriteMeals, _cartMeal)
                    // const BookingSuccess(),
                    ),
              );
              return true;
            },
            child: Scaffold(
              body: Container(
                  child: Column(children: <Widget>[
                Expanded(
                  child: InAppWebView(
                    initialData: InAppWebViewInitialData(data: """
          <!DOCTYPE html>
          <html lang="en">
              <head>
                  <meta charset="UTF-8">
                  <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
              </head>
              <body>
                
                ${widget.paymentdata}
              </body>
          </html>
                    """),
                    initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                            // debuggingEnabled: true,
                            )),
                    onWebViewCreated: (InAppWebViewController controller) {
                      _webViewController = controller;

                      _webViewController.addJavaScriptHandler(
                          handlerName: 'handlerFoo',
                          callback: (args) {
                            // return data to JavaScript side!
                            log('back');
                            return {'bar': 'bar_value', 'baz': 'baz_value'};
                          });

                      _webViewController.addJavaScriptHandler(
                          handlerName: 'handlerFooWithArgs',
                          callback: (args) {
                            // print(args);
                            // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
                          });
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      // print(consoleMessage);
                      // it will print: {message: {"bar":"bar_value","baz":"baz_value"}, messageLevel: 1}
                    },
                  ),
                ),
              ])),
            ),
          );
        });
  }
}
