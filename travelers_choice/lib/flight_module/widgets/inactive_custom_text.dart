import 'package:flutter/material.dart';



class InactiveInfoCustomText extends StatelessWidget {
  InactiveInfoCustomText({required this.text, this.height});

  final String text;
  final height;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        height: height,
        color:Colors.yellow,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
