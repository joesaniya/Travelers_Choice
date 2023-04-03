import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

// class CustomSnackbar {
//   static void show(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }
// }
class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String message,
    IconData? iconData,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FxText.bodySmall(
          message,
          color: Colors.white,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
}
