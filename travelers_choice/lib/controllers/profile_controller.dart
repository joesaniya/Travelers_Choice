import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/views/login_Screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class ProfileController extends FxController {
  bool showLoading = true, uiLoading = true;
  bool notification = true, offlineReading = false;
  late User user;
  String? name, email;

  @override
  initState() {
    super.initState();

    fetchData();
    skeletonloader();
  }

  void skeletonloader() async {
    await Future.delayed(const Duration(seconds: 4));

    uiLoading = false;
    log('skeletonloader');
    log(uiLoading.toString());
    update();
  }

  Future logout(BuildContext context) async {
    log('logout');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear().then((value) {
      log('log then');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LogInScreen()),
          (route) => false);
    });
  }

  // void logout(BuildContext context) async {
  //   log('logout');
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.clear().then((value) {
  //     log('log then');
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (context) => const LogInScreen()),
  //         (route) => false);
  //   });
  // }

  void fetchData() async {
    user = await User.getOne();
    await Future.delayed(const Duration(seconds: 1));

    // showLoading = false;
    // uiLoading = false;
    update();
  }

  // void logout() {
  //   Navigator.pop(context);
  // }

  @override
  String getTag() {
    return "profile_controller";
  }
}
