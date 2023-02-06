import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hotel_travel/models/Country_modal.dart';
import 'package:hotel_travel/services/auth_service.dart';

class AuthController {
  Future<bool> register(
      String name,
      String email,
      // int countryid,
      String countryid,
      String phoneNumber,
      String Password,
      BuildContext context) async {
    try {
      var data = await AuthService()
          .register(name, email, countryid, phoneNumber, Password, context);
      if (data != null) {
        log(data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      var data = await AuthService().login(email, password, context);
      if (data != null) {
        log(data);
        // log('token');
        // log(data['jwtToken'].toString());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  List<CountryModal> countryList = <CountryModal>[];
  bool isCountryListLoading = true;
  Future getCountryList() async {
    // isCountryListLoading = true;
    try {
      var data = await AuthService().getCountry();
      countryList.clear();
      if (data != null) {
        countryList.add(data);
        // isCountryListLoading = false;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
