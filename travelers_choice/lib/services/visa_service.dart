
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/create_visa_modal.dart';
import '../models/select_visa_modal.dart';
import '../models/visa_country_modal.dart';
import 'package:http/http.dart' as http;


class VisaService{

  Future<List<VisaCountryModal>> getVisaCountry() async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://secure.mytravellerschoice.com/api/v1/visa/all',
        ),
        // headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        print("response${parsed}");
        return parsed.map<VisaCountryModal>((item) => VisaCountryModal.fromJson(item)).toList();

      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }


  Future<SelectVisaModal?> getSelectVisa(String id) async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://secure.mytravellerschoice.com/api/v1/visa/type/all/$id'
        ),
        // headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        log(response.body);
        // SharedPreferences sharedPreferences =
        // await SharedPreferences.getInstance();
        // sharedPreferences.setString(
        //     AppConstants.KEY_ACCESS_TOKEN_CurrenciesList,
        //     jsonEncode(jsondata['currencies']));
        // sharedPreferences.setString("countrycode", countryModalFromJson(response.body).toJson() );

        return selectVisaModalFromJson(response.body);
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }


  Future postCreateVisa(

      Map body
      ) async {
    print("bodycheck $body");
    try {
      var response = await http.post(

        Uri.parse(
            'https://secure.mytravellerschoice.com/api/v1/visa/application/create'
        ),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body)
      );

      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        log(response.body);
        // SharedPreferences sharedPreferences =
        // await SharedPreferences.getInstance();
        // sharedPreferences.setString(
        //     AppConstants.KEY_ACCESS_TOKEN_CurrenciesList,
        //     jsonEncode(jsondata['currencies']));
        // sharedPreferences.setString("countrycode", countryModalFromJson(response.body).toJson() );
        print("jsondata$response");

        return createVisaApplicationFromJson(response.body);
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

}