import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:hotel_travel/extensions/extensions.dart';

class Product {
  String name, image, description, location, types, id, status;
  double price, rating;
  int review, person;
  Color color;
  bool favorite;
  // List<String> interests;

  Product(
      this.name,
      this.image,
      this.description,
      this.rating,
      this.price,
      this.review,
      this.person,
      this.color,
      this.favorite,
      this.location,
      this.types,
      // this.interests
      this.id,
      this.status);

  static Future<List<Product>> getDummyList() async {
    dynamic data = json.decode(await getData());
    return getListFromJson(data);
  }

  static Future<Product> getOne() async {
    return (await getDummyList())[0];
  }

  static Product fromJson(Map<String, dynamic> jsonObject) {
    String name = jsonObject['name'].toString();
    String image = jsonObject['image'].toString();
    String description = jsonObject['description'].toString();
    double rating = double.parse(jsonObject['rating'].toString());
    double price = double.parse(jsonObject['price'].toString());
    int review = int.parse(jsonObject['review'].toString());
    int person = int.parse(jsonObject['person'].toString());
    Color color = jsonObject['review'].toString().toColor;
    bool favorite = jsonObject['favorite'].toString().toBool();
    String location = jsonObject['location'].toString();
    String types = jsonObject['types'].toString();
    String id = jsonObject['id'].toString();
    String status = jsonObject['status'].toString();
    // List<String> interests = [];
    // for (dynamic interest in jsonObject['interests']) {
    //   interests.add(interest.toString());
    // }

    return Product(name, image, description, rating, price, review, person,
        color, favorite, location, types, id, status
        // interests
        );
  }

  static List<Product> getListFromJson(List<dynamic> jsonArray) {
    List<Product> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Product.fromJson(jsonArray[i]));
    }
    return list;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('lib/dummy_data/data/products.json');
    // .loadString('lib/full_apps/shopping/data/products.json');
  }
}
