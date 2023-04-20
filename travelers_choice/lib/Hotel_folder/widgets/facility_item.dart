import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class FacilityItem extends StatelessWidget {
  final String svgPath;

  const FacilityItem({Key? key, required this.svgPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: const Color(0xff3f3f3f),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: SvgPicture.asset(
          svgPath,
        ),
      ),
    );
  }
}
