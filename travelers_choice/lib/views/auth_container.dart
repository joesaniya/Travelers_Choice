import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hotel_travel/views/login_Screens/login_screen.dart';
import 'package:hotel_travel/views/splash_screens/splash_screen2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/app_constants.dart';

class AuthContainer extends StatefulWidget {
  @override
  _AuthContainerState createState() => _AuthContainerState();
}

class _AuthContainerState extends State<AuthContainer> {
  String? token;
  bool initial = true;

  @override
  Widget build(BuildContext context) {
    if (initial) {
      SharedPreferences.getInstance().then((sharedPrefValue) {
        setState(() {
          initial = false;
          token = sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN);
          log(token.toString());
        });
      });
      return const CircularProgressIndicator();
    } else {
      if (token == null) {
        return const LogInScreen();
      } else {
        // return const FullApp();
        return const SplashScreen2();
      }
    }
  }
}
