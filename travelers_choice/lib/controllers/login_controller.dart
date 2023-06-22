import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../views/login_Screens/forgot_password_screen.dart';
import '../views/register_screen/register_screen.dart';
import '../views/splash_screens/splash_screen2.dart';
import 'auth_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogInController extends FxController {
  TickerProvider ticker;
  LogInController(this.ticker);
  late TextEditingController emailTE, passwordTE;
  GlobalKey<FormState> formKey = GlobalKey();
  late AnimationController arrowController, emailController, passwordController;
  late Animation<Offset> arrowAnimation, emailAnimation, passwordAnimation;
  int emailCounter = 0;
  int passwordCounter = 0;

  //google
  GoogleSignInAccount? _userObj;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String url = "";
  String name = "";
  String email = "";
  String accesstoken = "";

  @override
  void initState() {
    super.initState();
    emailTE = TextEditingController();
    passwordTE = TextEditingController();
    arrowController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    emailController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    passwordController = AnimationController(
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
    passwordAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: passwordController,
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

    passwordController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        passwordController.reverse();
      }
      if (status == AnimationStatus.dismissed && passwordCounter < 2) {
        passwordController.forward();
        passwordCounter++;
      }
    });
  }

  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  void googlesign() {
    _googleSignIn.signIn().then((userData) {
      _userObj = userData;
      url = _userObj!.photoUrl.toString();
      name = _userObj!.displayName.toString();
      email = _userObj!.email;
      ref.add({
        'name': name,
        'url': url,
        'email': email,
      });

      if (userData != null) {
        log('userdata:$userData');
        // Navigator.of(context, rootNavigator: true).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => const SplashScreen2(),
        //   ),
        // );
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => (second(
        //       url: url,
        //       name: name,
        //       email: email,
        //     )),
        //   ),
        // );
        log('signin');
      }
    }).catchError((e) {
      print(e);
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> googleSignIn() async {
    print('googe sign in');
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);
        log('user:${user.credential!.accessToken}');
        log('userData:$user');
        // ref.add({
        //   'name': user.additionalUserInfo!.username,
        //   'url': user.user!.photoURL,
        //   'email': user.user!.email,
        // });
        Map<String, dynamic> data = {
          'name': user.user!.displayName,
          'url': user.user!.photoURL,
          'email': user.user!.email,
          'accesstoken': user.credential!.accessToken
        };
        FirebaseFirestore.instance.collection("test").add(data).then((data) {
          print(data);
          log('Success data:$data');
          print("Success!!");
          print(data);
        }).catchError((onError) {
          print('error');
          log('Error:$onError');
        });

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => PageSwitcher(_favouriteMeals as List)),
        // );

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else {
      throw StateError('Sign in Aborted');
    }
  }

  @override
  void dispose() {
    arrowController.dispose();
    emailController.dispose();
    passwordController.dispose();
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

  void goToForgotPasswordScreen() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordScreen(),
      ),
    );
  }

  Future<void> login() async {
    emailCounter = 0;
    passwordCounter = 0;
    // if (emailTE.text.isEmpty) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("Please enter name")));
    // } else if (emailTE.text.isEmpty) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("Please enter email")));
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("success")));
    //   arrowController.forward();
    //   await Future.delayed(Duration(milliseconds: 500));
    //   await AuthController().login(emailTE.text, passwordTE.text).then(
    //       (value) => Navigator.of(context, rootNavigator: true).pushReplacement(
    //             MaterialPageRoute(
    //               builder: (context) => SplashScreen2(),
    //             ),
    //           ));
    //   // log(value));
    // }
    if (formKey.currentState!.validate()) {
      arrowController.forward();
      await Future.delayed(const Duration(milliseconds: 1000));
      await AuthController()
          .login(emailTE.text, passwordTE.text, context)
          .then((value) {
        if (value) {
          Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SplashScreen2(),
            ),
          );
        }
      });
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text("Invalid Credentials")));

      // Navigator.of(context, rootNavigator: true).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const SplashScreen2(),
      //   ),
      // );
    }
  }

  void goToRegisterScreen() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

  void redirect() {
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) =>  PaymentCC(),
    //   ),
    // );
  }

  @override
  String getTag() {
    return "login_controller";
  }
}
