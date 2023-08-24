import 'dart:ui';
import 'package:flutter/material.dart';

class BlurryDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback continueCallBack;
  final TextStyle textStyle = const TextStyle(color: Colors.black);

  const BlurryDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.continueCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          // This line is added
          borderRadius: BorderRadius.circular(
              12), // Change this value to change the corner radius
        ),
        title: Text(
          title,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
        content: Text(
          content,
          style: textStyle,
        ),
        actions: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
              onPressed: () {
                continueCallBack();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 54, 139, 244),
                foregroundColor: Colors.black,
              ),
              child: Text('Yes', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 54, 139, 244),
                foregroundColor: Colors.black,
              ),
              child: Text('No', style: TextStyle(color: Colors.white)),
            ),
          ]),
        ],
      ),
    );
  }
}
