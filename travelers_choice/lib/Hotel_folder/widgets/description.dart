import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/Hotel_folder/widgets/section_title.dart';

class Description extends StatelessWidget {
  const Description({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Description'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: FadeInUp(
            duration: const Duration(milliseconds: 1300),
            child: FxText.bodyMedium(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eu\ntincidunt nunc cras integer magna sapien, id egestas. Amet\nfacilisis ac in nunc sed convallis aenean mattis sit. Lacus\ndolor, integer vel suspendisse cum pellentesque ornare\nquis. Mattis ut viverra purus leo elit, et.',
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
