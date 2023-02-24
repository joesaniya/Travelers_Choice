import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../services/auth_service.dart';

class EditProfileController extends FxController {
  bool showLoading = true, uiLoading = true;

  late TextEditingController  nameTE,addressTE, emailTE,
      mobileTE, ageTE;
  Gender gender = Gender.male;
  String? token;
  String? countryId;
   String? name, email;
  double? balanceamount;

  @override
  void initState() {
    super.initState();
    nameTE = TextEditingController();
    mobileTE = TextEditingController();
    emailTE = TextEditingController();
    addressTE = TextEditingController();
    ageTE = TextEditingController();
    fetchData();
  }

  void fetchData() async {
    await Future.delayed(Duration(seconds: 1));
    showLoading = false;
    uiLoading = false;
    update();
  }

  void changeGender(Gender gender) {
    this.gender = gender;
    update();
  }

  Future<bool> patchEdit(
      String name,
      String email,
      String countryId,
      String phoneNumber,
      String token,
      BuildContext context
      ) async {
    try {
      var data = await AuthService()
          .patchUpdateProfile(name, email, countryId, phoneNumber, token, context
      );
      if (data != null) {
        // log(data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  void goBack({bool? canRefresh}) {
    Navigator.pop(context, canRefresh);
  }

  @override
  String getTag() {
    return "edit_profile_controller";
  }
}

enum Gender { male, female }
