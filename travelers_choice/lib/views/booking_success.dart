import 'package:lottie/lottie.dart';

import '../controllers/booking_sucesss_controller.dart';
import '/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class BookingSuccess extends StatefulWidget {
  const BookingSuccess({Key? key}) : super(key: key);

  @override
  _BookingSuccessState createState() => _BookingSuccessState();
}

class _BookingSuccessState extends State<BookingSuccess> {
  late ThemeData theme;

  late BookingSuccessController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.putOrFind(BookingSuccessController());
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<BookingSuccessController>(
        controller: controller,
        builder: (controller) {
          return Scaffold(
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Lottie.asset('assets/lottie/confirmation.json',
                    height: 300, width: 300),
                FxSpacing.height(20),
                FxText.titleLarge(
                  'Booking Success!!',
                  fontWeight: 700,
                  textAlign: TextAlign.center,
                ),
                FxSpacing.height(8),
                FxText.labelLarge(
                  'Enjoy Your \nVaccation, thanks for Booking',
                  textAlign: TextAlign.center,
                  xMuted: true,
                ),
                FxSpacing.height(24),
                FxButton.block(
                  onPressed: () {
                    //  controller.goBack();
                  },
                  borderRadiusAll: 4,
                  elevation: 0,
                  splashColor: const Color(0xff1529e8).withAlpha(30),
                  backgroundColor: const Color(0xff1529e8),
                  child: FxText.labelLarge(
                    'Back To Home',
                    color: theme.colorScheme.onPrimary,
                    fontWeight: 600,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
