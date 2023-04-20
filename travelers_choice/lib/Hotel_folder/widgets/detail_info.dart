import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class DetailInfo extends StatefulWidget {
  final String title;
  final String rawRating;
  final String price;

  const DetailInfo({
    Key? key,
    required this.title,
    required this.rawRating,
    required this.price,
  }) : super(key: key);

  @override
  _DetailInfoState createState() => _DetailInfoState();
}

class _DetailInfoState extends State<DetailInfo> {
  @override
  Widget build(BuildContext context) {
    var rating = widget.rawRating.split(" ");

    return FadeInUp(
      duration: const Duration(milliseconds: 900),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.bodySmall(
                      widget.title,
                      fontWeight: 900,
                      color: Colors.black,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Hero(
                          tag: "product_raing",
                          child: FxText.bodyMedium('5.00', fontWeight: 700),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 4),
                            child: FxStarRating(rating: 2.55))
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.bodyMedium(widget.price, fontWeight: 500),
                    FxText.bodyMedium("Per Night", fontWeight: 500),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 17),
        ],
      ),
    );
  }
}
