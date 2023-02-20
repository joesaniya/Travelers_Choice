import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class PaymentService {
  Future PersonalInfo(String name, String email, String phoneNumber,
      String countryId, List SelectedActivities) async {
    log('Activities data');
    // log('Activities:$SelectedActivities');
    for (var element in SelectedActivities) {
      log('Element:${element.sId}');
    }
    return;
    try {
      var body = {
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "country": countryId,
        "SelectedActivities": SelectedActivities
      };
      log(body.toString());
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
