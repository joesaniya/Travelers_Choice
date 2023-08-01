import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../card_widgets/customsnackbar.dart';

class PaymentService {
  Future PersonalInformation(
      String name,
      String email,
      String phoneNumber,
      String countryId,
      String paymentProcessor,
      List SelectedActivities,
       BuildContext context) async {
    log('Activities data');
    // log('Activities:$SelectedActivities');
    List<Map<String, dynamic>> ActivityList = [];
    for (var element in SelectedActivities) {
      log('Element:${element.sId}');
      log('Element Date:${element.selectedDate}');
      log('Element Type:${element.transferType}');
      log('Adult Count:${element.adultCount}');
      log('child Count:${element.childCount}');
      log('Infant Count:${element.infantCount}');
      var datas = {
        // "activity": element.sId,
        // "date": "2023-02-28",
        // // "date": element.selectedDate,
        // "adultsCount": element.adultCount,
        // "childrenCount": element.childCount,
        // "infantCount": element.infantCount,
        // "transferType": "private"
        "activity": "63e6317d20e0e01648630e6a",
        "date": "2023-02-28",
        "adultsCount": 19,
        "childrenCount": 0,
        "infantCount": 1,
        "transferType": "private"
      };
      ActivityList.add(datas);
      log('Data-->$datas');
    }
    SelectedActivities.map((e) =>
        // e,
        log('selected Activites:$e'));
    // return;
    try {
      var body = {
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "country": countryId,
        "paymentProcessor": paymentProcessor,
        // "selectedActivities": jsonEncode(ActivityList)
        "selectedActivities": ActivityList
      };
      log(body.toString());
      log('Body:${body.toString()}');
      var response = await http.post(
          Uri.parse(
            'https://secure.mytravellerschoice.com/api/v1/attractions/orders/create',
          ),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        log("Peyment/Personal Data => $jsondata");

        return response.body;
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        log(jsondata['error']);
        //snackbar
        CustomSnackbar.show(
          context: context,
          message: jsondata['error'],
          backgroundColor: Color(0xff1529e8),
          duration: Duration(seconds: 2),
        );
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(jsondata['error'])));
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
