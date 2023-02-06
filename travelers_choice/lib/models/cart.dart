import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:hotel_travel/extensions/extensions.dart';

import 'product.dart';

class Cart {
  Product product;
  String selectedSize;
  int person;
  Color selectedColor;

  Cart(this.product, this.selectedSize, this.person, this.selectedColor);

  static Future<List<Cart>> getDummyList() async {
    dynamic data = json.decode(await getData());
    return getListFromJson(data);
  }

  static Future<Cart> getOne() async {
    return (await getDummyList())[0];
  }

  static Future<Cart> fromJson(Map<String, dynamic> jsonObject) async {
    Product product = Product.fromJson(jsonObject['product']);
    String selectedSize = jsonObject['selectedSize'].toString();
    int person = int.parse(jsonObject['person'].toString());
    Color selectedColor = jsonObject['selectedColor'].toString().toColor;

    return Cart(product, selectedSize, person, selectedColor);
  }

  static Future<List<Cart>> getListFromJson(List<dynamic> jsonArray) async {
    List<Cart> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(await Cart.fromJson(jsonArray[i]));
    }
    return list;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('lib/dummy_data/data/cart.json');
  }
}
