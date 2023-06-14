import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../views/hotel_checkout.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FadeInUp(
          duration: const Duration(milliseconds: 1500),
          child: SizedBox(
            height: 52,
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.indigo,
                // textStyle: nunitoRegular17,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
              child: const Text('Book Now'),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
