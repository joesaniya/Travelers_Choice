import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Applayout {
  static getsize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static getscreenheight() {
    return Get.height;
  }

  static getscreenwidth() {
    return Get.width;
  }

  static getheight(double pixel) {
    double x = getscreenheight() / pixel;
    return getscreenheight() / x;
  }

  static getwidth(double pixel) {
    double x = getscreenwidth() / pixel;
    return getscreenwidth() / x;
  }
}
