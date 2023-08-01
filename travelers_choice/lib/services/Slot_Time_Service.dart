import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../card_widgets/customsnackbar.dart';
import '../models/Slot_Time.dart';

class SlotTimeService {
  Future getSlotTime(String productid, String productcode, String date,
      BuildContext context) async {
    try {
      var body = {
        "productId": productid,
        "productCode": productcode,
        "timeSlotDate": date
      };
      // var body = {
      //   "productId": "83",
      //   "productCode": "54",
      //   "timeSlotDate": "2023-08-20"
      // };

      log('Body Review:${body.toString()}');
      var response = await http.post(
          Uri.parse(
            'https://a.walletbot.online/api/v1/attractions/timeslot',
          ),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body));
      log('Body Review1:${response.body}');
      log('sts:${response.statusCode}');
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        log("Slot Data => $jsondata");
        return jsondata;
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        //snackbar
        CustomSnackbar.show(
          context: context,
          message: jsondata['error'],
          backgroundColor: const Color(0xff1529e8),
          duration: const Duration(seconds: 2),
        );
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(jsondata['error'])));
        return 'Failure';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SlotTime>?> getSlotTime1(String productid, String productcode,
      String date, BuildContext context) async {
    try {
      var body = {
        "productId": productid,
        "productCode": productcode,
        "timeSlotDate": date
      };
      var response = await http.post(
          Uri.parse('https://a.walletbot.online/api/v1/attractions/timeslot'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        log("https://a.walletbot.online/api/v1/attractions/timeslot"
            "Category LIst          ${response.body}");
        // List<dynamic> result = json.decode(response.body);
        // List<SlotTime> posts = List<SlotTime>.from(
        //     result['data'].map((dynamic row) => SlotTime.fromJson(row)));
        // log('Datas:$posts');

        return slotTimeFromJson(response.body);
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        return null;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
