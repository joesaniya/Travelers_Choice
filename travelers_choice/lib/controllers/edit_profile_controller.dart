import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../services/auth_service.dart';

class EditProfileController extends FxController {
  bool showLoading = true, uiLoading = true;

  late TextEditingController nameTE, addressTE, emailTE, mobileTE, ageTE;
  Gender gender = Gender.male;
  String? token;
  String? countryId;
  String? name, email, phoneNumber;
  double? balanceamount;
  String? selectedCountryCode, countryCode;

  String? validatePhone(String? text) {
    if (text == null || text.isEmpty) {
      // nameController.forward();
      return "Please enter PhoneNumber";
    }
    return null;
  }

  String? validateName(String? text) {
    if (text == null || text.isEmpty) {
      // nameController.forward();
      return "Please enter Name";
    }
    return null;
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      // emailController.forward();
      return "Please enter email";
    }
    //else if (FxStringValidator.isEmail(text)) {
    //   emailController.forward();
    //   return "Please enter valid email";
    // }
    return null;
  }

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
    await Future.delayed(const Duration(seconds: 1));
    showLoading = false;
    uiLoading = false;
    update();
  }

  void changeGender(Gender gender) {
    this.gender = gender;
    update();
  }

  //  Future<void> updateProfile(String email) async {
  //   emailCounter = 0;
  //   log('calling...goto resetpassword screen');
  //   log('email Fn:$email');
  //   if (formKey.currentState!.validate()) {
  //     arrowController.forward();
  //     await Future.delayed(const Duration(milliseconds: 500));
  //     await AuthController().ForgotpwdUpdate(email, context).then((value) {
  //       if (value) {
  //         Navigator.of(context, rootNavigator: true).pushReplacement(
  //           MaterialPageRoute(
  //             builder: (context) => ConfirmPasswordScreen(emailTE.text),
  //           ),
  //         );
  //       }
  //     });

  //   }
  // }

  Future<bool> patchEdit(String name, String email, String countryId,
      String phoneNumber, String token, BuildContext context) async {
    try {
      var data = await AuthService().patchUpdateProfile(
          name, email, countryId, phoneNumber, token, context);
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
