import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class PaymentService {
  Future PersonalInfo(
      String name,
      String email,
      String phoneNumber,
      String countryId,
      String paymentProcessor,
      List SelectedActivities) async {
    log('Activities data');
    // log('Activities:$SelectedActivities');
    List<Map<String, dynamic>> ActivityList = [];
    for (var element in SelectedActivities) {
      print('Element:${element.sId}');
      print('Element Date:${element.selectedDate}');
      print('Element Type:${element.transferType}');
      print('Adult Count:${element.adultCount}');
      print('child Count:${element.childCount}');
      print('Infant Count:${element.infantCount}');
      var datas = {
        // "activity": element.sId,
        // "date": "2023-02-21T09:40:14.078Z",
        // // "date": element.selectedDate,
        // "adultsCount": element.adultCount,
        // "childrenCount": element.childCount,
        // "infantCount": element.infantCount,
        // "transferType": "private"
        "activity": "63e6317d20e0e01648630e6a",
        "date": "2023-02-21T09:40:14.078Z",
        "adultsCount": 19,
        "childrenCount": 0,
        "infantCount": 1,
        "transferType": "private"
      };
      ActivityList.add(datas);
      print('Data-->$datas');
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
        "SelectedActivities": jsonEncode(ActivityList)
      };
      log(body.toString());
      print('Body:${body.toString()}');
      var response = await http.post(
          Uri.parse(
            'https://secure.mytravellerschoice.com/api/v1/attractions/orders/create',
          ),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        print("Peyment/Personal Data => $jsondata");

        return response.body;
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        print(jsondata['error']);
        //snackbar
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(jsondata['error'])));
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
