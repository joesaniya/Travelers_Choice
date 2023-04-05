import 'dart:convert';

import 'package:flutter/services.dart';

class Planes {
  String Destname;
  String Airportname;
  String Airportcode;
  Planes(this.Destname, this.Airportname, this.Airportcode);
  static Future<List<Planes>> getDummyList() async {
    dynamic data = json.decode(await getData());
    return getListFromJson(data);
  }

  static Future<Planes> getOne() async {
    return (await getDummyList())[0];
  }

  static Future<Planes> fromJson(Map<String, dynamic> jsonObject) async {
    String Destname = jsonObject['Destname'].toString();
    String Airportname = jsonObject['Airportname'].toString();
    String Airportcode = jsonObject['Airportcode'].toString();

    return Planes(Destname, Airportname, Airportcode);
  }

  static Future<List<Planes>> getListFromJson(List<dynamic> jsonArray) async {
    List<Planes> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(await Planes.fromJson(jsonArray[i]));
    }
    return list;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('lib/dummy_data/data/plane.json');
  }
}
