import 'package:flutter/material.dart';

class EmiratesLogo extends StatelessWidget {
  const EmiratesLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50.0,
      width: 50.0,
      child: Image(
          image: AssetImage('assets/other/logo.png'
              // 'assets/seat/images/flight_center_logo.png'
              )),
    );
  }
}
