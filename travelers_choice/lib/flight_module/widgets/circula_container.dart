import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  final bool? iscolorful;
  CircularContainer({this.iscolorful});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: Colors.white,
          border: Border.all(
              width: 3.5,
              color: iscolorful == null ? Colors.white : Color(0xFF8ACCF7))),
    );
  }
}
