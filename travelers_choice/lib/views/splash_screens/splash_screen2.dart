import '../../controllers/splas_screen2-controllers.dart';
import '/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import 'dart:async';

import 'package:connectivity/connectivity.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  _SplashScreen2State createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  late ThemeData theme;

  late SplashScreen2Controller controller;

  late StreamSubscription subscription;
  late StreamSubscription internetSubscription;
  bool hasInternet = false;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.putOrFind(SplashScreen2Controller());
    // subscription =
    //     Connectivity().onConnectivityChanged.listen(_showConnectivitySnackBar);
    // internetSubscription =
    //     InternetConnectionChecker().onStatusChange.listen((status) {
    //   final hasInternet = status == InternetConnectionStatus.connected;
    //   setState(() {
    //     this.hasInternet = hasInternet;
    //   });
    // });
    // hasInternet ? controller.goToFullApp() : controller.noInternet();
  }

  void _showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? result == ConnectivityResult.mobile
            ? 'You are connected to Mobile Network'
            : 'You are connected to Mobile wifi'
        : 'You have no Internet';
    final color = hasInternet ? Colors.green : Colors.red;
    _showSnackBar(context, message, color);
  }

  void _showSnackBar(BuildContext context, String? message, Color color) {
    final snackBar = SnackBar(
      content: Text(message!),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<SplashScreen2Controller>(
        controller: controller,
        builder: (controller) {
          // return Scaffold(
          //   body: hasInternet
          //       ? controller.goToFullApp()
          //       : const Text('No Internet'),
          // );
          return Scaffold(
            body:
                // Container(
                //   child: Image.asset("assets/other/splash_screen.png",
                //     fit: BoxFit.fill,
                //     width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.height,
                //   ),
                // )
                Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      "assets/other/tctt-logo.png",
                      fit: BoxFit.fill,
                      width: 200,
                      height: 200,
                    ),
                  ),

                  // Hero(
                  //   tag: "splash_username",
                  //   child: FxText.titleLarge(
                  //     'Welcome To Travelers Choice App',
                  //     // "Hey Nency,",
                  //     fontWeight: 700,
                  //   ),
                  // ),
                  // FxText.bodySmall(
                  //   "Wait here, we are fetching data",
                  // ),
                ],
              ),
            ),
          );
        });
  }
}
