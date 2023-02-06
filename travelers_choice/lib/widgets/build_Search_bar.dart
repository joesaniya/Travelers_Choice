import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/themes/text_style.dart';
import 'package:searchfield/searchfield.dart';

Padding buildSearchBar(Size size, String length) {
  return Padding(
    padding: length == "long"
        ? const EdgeInsets.symmetric(horizontal: 5, vertical: 20)
        // EdgeInsets.symmetric(
        //     horizontal: size.width * 0.1, vertical: size.height * 0.04)
        : const EdgeInsets.all(0.0),
    child: Stack(
      children: <Widget>[
        Container(
          width: size.width,
          // width: size.width * 0.8,

          height: size.height * 0.06,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(114.0)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.05, top: size.height * 0.003),
            // padding: EdgeInsets.only(
            //     left: size.width * 0.05, top: size.height * 0.025),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                suffixIcon: const Icon(Icons.search),
                border: InputBorder.none,
                hintText: "Where Next?",
                hintStyle: FxTextStyle.bodyMedium(),
              ),
            ),
          ),
        ),

        // DropdownSearch<String>(

        //   mode: Mode.DIALOG,
        //   //to show search box
        //   showSearchBox: true,
        //   showSelectedItem: true,
        //   //list of dropdown items
        //   items: ["India", "USA", "Brazil", "Canada", "Australia", "Singapore"],
        //   label: "Country",
        //   onChanged: print,
        //   //show selected item
        //   selectedItem: "India",
        // ),
        // Positioned(
        //   right: 0.0,
        //   child: Container(
        //     width: size.width * 0.17,
        //     height: size.height * 0.06,
        //     decoration: BoxDecoration(
        //       color: Colors.black,
        //       borderRadius: BorderRadius.all(Radius.circular(114.0)),
        //     ),
        //     child: Icon(
        //       Icons.search,
        //       color: Colors.white,
        //     ),
        //   ),
        // )
      ],
    ),
  );
}
