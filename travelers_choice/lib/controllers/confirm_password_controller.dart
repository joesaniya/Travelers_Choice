import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/views/login_Screens/login_screen.dart';

import '../views/register_screen/register_screen.dart';

class ConfirmPasswordController extends FxController {
  TickerProvider ticker;
  ConfirmPasswordController(this.ticker);
  late TextEditingController newPasswordTE, confirmPasswordTE, otpTE;
  GlobalKey<FormState> formKey = GlobalKey();
  late AnimationController arrowController, newPasswordController,confirmPasswordController,otpController;
  late Animation<Offset> arrowAnimation, newPasswordAnimation, confirmPasswordAnimation,otpAnimation;
  int newCounter = 0;
  int confirmCounter = 0;
  int otpCounter = 0;

  @override
  void initState() {
    super.initState();
    // this.emailTE = TextEditingController(text: 'shinchan@gmail.com');
    newPasswordTE = TextEditingController();
    confirmPasswordTE = TextEditingController();
    otpTE = TextEditingController();
    arrowController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 500));
    newPasswordController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 50));
    confirmPasswordController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 50));
    otpController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 50));

    arrowAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(8, 0))
        .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    newPasswordAnimation =
        Tween<Offset>(begin: Offset(-0.01, 0), end: Offset(0.01, 0))
            .animate(CurvedAnimation(
          parent: newPasswordController,
          curve: Curves.easeIn,
        ));
    confirmPasswordAnimation =
        Tween<Offset>(begin: Offset(-0.01, 0), end: Offset(0.01, 0))
            .animate(CurvedAnimation(
          parent: confirmPasswordController,
          curve: Curves.easeIn,
        ));
    otpAnimation =
        Tween<Offset>(begin: Offset(-0.01, 0), end: Offset(0.01, 0))
            .animate(CurvedAnimation(
          parent: otpController,
          curve: Curves.easeIn,
        ));
    newPasswordController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        newPasswordController.reverse();

      }
      if (status == AnimationStatus.dismissed && newCounter < 2) {
        newPasswordController.forward();
        newCounter++;
      }
    });   confirmPasswordController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        confirmPasswordController.reverse();

      }
      if (status == AnimationStatus.dismissed && confirmCounter < 2) {
        confirmPasswordController.forward();
        confirmCounter++;
      }
    });
    otpController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        otpController.reverse();

      }
      if (status == AnimationStatus.dismissed && otpCounter < 2) {
        otpController.forward();
        otpCounter++;
      }
    });
  }

  @override
  void dispose() {
    arrowController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    super.dispose();
  }

  String? validateOtp(String? text) {
    if (text == null || text.isEmpty) {
      otpController.forward();
      return "Please enter OTP";
    } else if (FxStringValidator.isOTP(text)) {
      otpController.forward();
      return "Please enter valid OTP";
    }
    return null;
  }
  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      newPasswordController.forward();

      return "Please enter password";
    } else if (!FxStringValidator.validateStringRange(
      text,
    )) {
      newPasswordController.forward();

      return "Password length must between 8 and 20";
    }
    return null;
  }
  String? validatePassword2(String? text) {
    if (text == null || text.isEmpty) {
      confirmPasswordController.forward();

      return "Please enter password";
    } else if (!FxStringValidator.validateStringRange(
      text,
    )) {
      confirmPasswordController.forward();

      return "Password length must between 8 and 20";
    }
    return null;
  }

  Future<void> goToLoginScreen() async {
    newCounter = 0;
    confirmCounter = 0;
    otpCounter = 0;
    if (formKey.currentState!.validate()) {
      arrowController.forward();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Password Changed")));
      await Future.delayed(Duration(milliseconds: 500));
      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LogInScreen(),
        ),
      );
    }
  }

  void goToRegisterScreen() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      ),
    );
  }

  @override
  String getTag() {
    return "forgot_password_controller";
  }
}
