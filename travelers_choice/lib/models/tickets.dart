import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Tickets {
  String fcode;
  String fname;
  String flyingtime;
  String dateflight;
  String departuretime;
  int number;
  Tickets(this.fcode, this.fname, this.flyingtime, this.dateflight,
      this.departuretime, this.number);

      static Future<List<Tickets>> getDummyList() async {
    dynamic data = json.decode(await getData());
    return getListFromJson(data);
  }

  static Future<Tickets> getOne() async {
    return (await getDummyList())[0];
  }

    static Future<Tickets> fromJson(Map<String, dynamic> jsonObject) async {
   String fcode= jsonObject['fcode'].toString();
    String fname= jsonObject['fname'].toString();
   String flyingtime = jsonObject['flyingtime'].toString();
    String date = jsonObject['date'].toString();
        String departure_time = jsonObject['departure_time'].toString();
    int number = int.parse(jsonObject['number'].toString());
    

    return Tickets(fcode,fname,flyingtime,date,departure_time,number);
  }

  static Future<List<Tickets>> getListFromJson(List<dynamic> jsonArray) async {
    List<Tickets> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(await Tickets.fromJson(jsonArray[i]));
    }
    return list;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('lib/dummy_data/data/ticket.json');
  }
}
