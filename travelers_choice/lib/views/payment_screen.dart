import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import '/theme/app_theme.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '/controllers/login_controller.dart';

class PaymentCCVisa extends StatefulWidget {
  String visaPaymentData;
  PaymentCCVisa({super.key, required this.visaPaymentData});
  // const PaymentCCVisa({Key? key}) : super(key: key);

  @override
  _PaymentCCVisaState createState() => _PaymentCCVisaState();
}

class _PaymentCCVisaState extends State<PaymentCCVisa> with TickerProviderStateMixin {
  late ThemeData theme;
  late LogInController controller;
  late InAppWebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    log('Payment cc:${widget.visaPaymentData}');
    controller = FxControllerStore.put(LogInController(this));
  }

  /// [initPlatformState] this calls the [cCAvenueInit]
  // Platform messages are asynchronous, so we initialize in an async method.
  
  @override
  Widget build(BuildContext context) {
    return FxBuilder<LogInController>(
        controller: controller,
        builder: (controller) {
          return Scaffold(
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
      
      ${widget.visaPaymentData}
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
          );
        });
  }
}
