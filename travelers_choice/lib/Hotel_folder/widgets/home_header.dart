import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // FadeInUp(
        //   duration: const Duration(milliseconds: 500),
        //   child: Padding(
        //     padding: const EdgeInsets.only(
        //       top: 30,
        //       left: 24,
        //       right: 24,
        //     ),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         SvgPicture.asset('assets/hotel/icons/menu.svg'),
        //         Image.asset('assets/hotel/images/profile.png', scale: 4),
        //       ],
        //     ),
        //   ),
        // ),
        FxSpacing.height(11),
        // header text
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FxText.titleLarge(
                  'Find a perfect',
                  letterSpacing: 0,
                  fontWeight: 600,
                ),
                FxSpacing.height(5),
                FxText.bodyMedium(
                  'Hotel for you',
                  letterSpacing: 0,
                  fontWeight: 900,
                ),
                FxSpacing.height(9),
                // Row(
                //   children: [
                //     SvgPicture.asset('assets/icons/location.svg'),
                //     FxSpacing.width(5),
                //     FxText.bodyLarge(
                //       'United States',
                //       letterSpacing: 0,
                //       fontWeight: 600,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
        FxSpacing.height(15),
      ],
    );
  }
}
