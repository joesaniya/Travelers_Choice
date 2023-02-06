import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/views/full_app.dart';

class UpdatePasswordController extends FxController {
  TickerProvider ticker;
  UpdatePasswordController(this.ticker);
  late TextEditingController confirmPasswordTE, passwordTE, oldpasswordTE;
  GlobalKey<FormState> formKey = GlobalKey();
  late AnimationController arrowController,
      oldpasswordController,
      passwordController,
      resetPasswordController;
  late Animation<Offset> arrowAnimation,
      passwordAnimation,
      oldpasswordAnimation,
      resetPasswordAnimation;
  int passwordCounter = 0;
  int oldpasswordCounter = 0;
  int resetPasswordCounter = 0;

  @override
  void initState() {
    super.initState();
    confirmPasswordTE = TextEditingController(text: 'password123');
    passwordTE = TextEditingController(text: 'password');
    oldpasswordTE = TextEditingController(text: 'Shinchan123');
    oldpasswordController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    arrowController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    passwordController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    resetPasswordController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));

    arrowAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    oldpasswordAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    passwordAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: passwordController,
      curve: Curves.easeIn,
    ));
    resetPasswordAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: resetPasswordController,
      curve: Curves.easeIn,
    ));
    oldpasswordController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        oldpasswordController.reverse();
      }
      if (status == AnimationStatus.dismissed && oldpasswordCounter < 2) {
        oldpasswordController.forward();
        oldpasswordCounter++;
      }
    });

    passwordController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        passwordController.reverse();
      }
      if (status == AnimationStatus.dismissed && passwordCounter < 2) {
        passwordController.forward();
        passwordCounter++;
      }
    });
    resetPasswordController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        resetPasswordController.reverse();
      }
      if (status == AnimationStatus.dismissed && resetPasswordCounter < 2) {
        resetPasswordController.forward();
        resetPasswordCounter++;
      }
    });
  }

  @override
  void dispose() {
    arrowController.dispose();
    oldpasswordController.dispose();
    passwordController.dispose();
    resetPasswordController.dispose();
    super.dispose();
  }

  String? validateoldPassword(String? text) {
    if (text == null || text.isEmpty) {
      oldpasswordController.forward();
      return "Please enter password";
    } else if (!FxStringValidator.validateStringRange(
      text,
    )) {
      oldpasswordController.forward();
      return "Password length must between 8 and 20";
    }
    return null;
  }

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      passwordController.forward();
      return "Please enter password";
    } else if (!FxStringValidator.validateStringRange(
      text,
    )) {
      passwordController.forward();
      return "Password length must between 8 and 20";
    }
    return null;
  }

  String? validateConfirmPassword(String? text) {
    if (text == null || text.isEmpty) {
      resetPasswordController.forward();
      return "Please enter password";
    } else if (!FxStringValidator.validateStringRange(
      text,
    )) {
      resetPasswordController.forward();
      return "Password length must between 8 and 20";
    } else if (passwordTE.text != text) {
      resetPasswordController.forward();
      return "Both passwords are not same";
    }
    return null;
  }

  Future<void> resetPassword() async {
    resetPasswordCounter = 0;
    if (formKey.currentState!.validate()) {
      arrowController.forward();
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const FullApp(),
        ),
      );
    }
  }

  @override
  String getTag() {
    return "update_password_controller";
  }
}
