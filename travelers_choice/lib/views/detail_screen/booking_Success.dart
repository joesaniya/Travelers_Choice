import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/home_controller.dart';
import '../../models/all_attraction_modal.dart';
import '../../theme/app_theme.dart';
import '../all_bookings.dart';

class BookingSuccess extends StatefulWidget {
  const BookingSuccess({super.key});

  @override
  State<BookingSuccess> createState() => _BookingSuccessState();
}

class _BookingSuccessState extends State<BookingSuccess>
    with TickerProviderStateMixin {
  late HomeController controller;
  late ThemeData theme;
  final List<AllattractionModal> _favouriteMeals = [];
  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    controller = FxControllerStore.put(HomeController(this));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<HomeController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    return Scaffold(
      body: Padding(
        padding: FxSpacing.x(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // physics: const BouncingScrollPhysics(),
          children: [
            // Container(
            //     margin: FxSpacing.all(20),
            //     child: Image(
            //       image: AssetImage(Images.shoppingOrderSuccess),
            //     )),
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
                controller.goBack();
                // Navigator.of(context, rootNavigator: true).pushReplacement(
                //   PageRouteBuilder(
                //       transitionDuration: const Duration(seconds: 2),
                //       pageBuilder: (_, __, ___) => const AllBookings()
                //       // FullApp(_favouriteMeals)
                //       ),
                // );
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
      ),
    );
  }
}
