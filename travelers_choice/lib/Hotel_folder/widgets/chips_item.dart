import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class ChipsItem extends StatelessWidget {
  final String label;

  const ChipsItem({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Chip(
        elevation: 0,
        label: FxText.labelLarge(
          label,
          fontWeight: 600,
          color: Colors.white,
          // color: theme.colorScheme.onPrimary,
          letterSpacing: 0.4,
        ),
        // label: Text(label, style: FxTextStyle.bodyMedium()),
        labelStyle: FxTextStyle.bodyMedium(),
        backgroundColor: const Color(0xff1529e8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 7,
        ),
      ),
    );
  }
}
