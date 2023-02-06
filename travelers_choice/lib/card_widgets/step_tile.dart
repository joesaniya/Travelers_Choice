import 'package:flutter/material.dart';
import 'package:hotel_travel/models/product.dart';

class StepTile extends StatelessWidget {
  final Product data;

  const StepTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey.shade100, width: 1))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   data.interests.toString(),
          //   style: const TextStyle(
          //       color: Colors.black,
          //       fontFamily: 'inter',
          //       fontSize: 16,
          //       fontWeight: FontWeight.w600),
          // ),
          (data.description != null)
              ? Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    data.description,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                        height: 150 / 100),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
