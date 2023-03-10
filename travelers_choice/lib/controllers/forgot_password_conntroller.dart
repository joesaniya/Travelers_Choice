import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../views/login_Screens/confrim_password.dart';
import '../views/register_screen/register_screen.dart';
import 'auth_controller.dart';

class ForgotPasswordController extends FxController {
  TickerProvider ticker;
  ForgotPasswordController(this.ticker);
  late TextEditingController emailTE;
  GlobalKey<FormState> formKey = GlobalKey();
  late AnimationController arrowController, emailController;
  late Animation<Offset> arrowAnimation, emailAnimation;
  int emailCounter = 0;

  @override
  void initState() {
    super.initState();
    emailTE = TextEditingController();
    arrowController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    emailController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));

    arrowAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    emailAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: emailController,
      curve: Curves.easeIn,
    ));
    emailController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        emailController.reverse();
      }
      if (status == AnimationStatus.dismissed && emailCounter < 2) {
        emailController.forward();
        emailCounter++;
      }
    });
  }

  @override
  void dispose() {
    arrowController.dispose();
    emailController.dispose();
    super.dispose();
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      emailController.forward();
      return "Please enter email";
    } else if (FxStringValidator.isEmail(text)) {
      emailController.forward();
      return "Please enter valid email";
    }
    return null;
  }

  Future<void> goToResetPasswordScreen(String email) async {
    emailCounter = 0;
    log('calling...goto resetpassword screen');
    log('email Fn:$email');
    if (formKey.currentState!.validate()) {
      arrowController.forward();
      await Future.delayed(const Duration(milliseconds: 500));
      await AuthController().ForgotpwdUpdate(email, context).then((value) {
        if (value) {
          Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ConfirmPasswordScreen(emailTE.text),
            ),
          );
        }
      });
      // ForgotpwdUpdate(email, context).then(
      //     (value) => Navigator.of(context, rootNavigator: true).pushReplacement(
      //           MaterialPageRoute(
      //             builder: (context) => ConfirmPasswordScreen(emailTE.text),
      //           ),
      //         ));
    }
  }

  void goToRegisterScreen() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

  @override
  String getTag() {
    return "forgot_password_controller";
  }
}
