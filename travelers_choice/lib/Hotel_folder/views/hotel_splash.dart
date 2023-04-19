import '../controller/hotel_splash_controller.dart';
import '/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class HotelSplash extends StatefulWidget {
  const HotelSplash({Key? key}) : super(key: key);

  @override
  _HotelSplashState createState() => _HotelSplashState();
}

class _HotelSplashState extends State<HotelSplash> {
  late ThemeData theme;

  late HotelSplashController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.putOrFind(HotelSplashController());
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<HotelSplashController>(
        controller: controller,
        builder: (controller) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [CircularProgressIndicator()],
              ),
            ),
          );
        });
  }
}
