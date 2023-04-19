import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import '../dummy.dart';
import 'chips_item.dart';

class Chips extends StatelessWidget {
  const Chips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      margin: const EdgeInsets.only(bottom: 25),
      child: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: FadeInUp(
          duration: const Duration(milliseconds: 700),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: chip.length,
            itemBuilder: (context, index) {
              return ChipsItem(
                label: chip[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
