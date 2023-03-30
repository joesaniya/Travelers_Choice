import 'package:lottie/lottie.dart';

import '../controller/flight_splash_controller.dart';
import '/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class FlightSplash extends StatefulWidget {
  const FlightSplash({Key? key}) : super(key: key);

  @override
  _FlightSplashState createState() => _FlightSplashState();
}

class _FlightSplashState extends State<FlightSplash> {
  late ThemeData theme;

  late FlightSplashController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.putOrFind(FlightSplashController());
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<FlightSplashController>(
        controller: controller,
        builder: (controller) {
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
                    // child: Image.asset(
                    //   "assets/other/tctt-logo.png",
                    //   fit: BoxFit.fill,
                    //   width: 200,
                    //   height: 200,
                    // ),
                    child: Lottie.asset(
                      'assets/lottie/flight.json',
                      // fit: BoxFit.cover
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
