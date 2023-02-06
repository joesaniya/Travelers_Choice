import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../views/login_Screens/login_screen.dart';
import '../views/splash_screens/splash_screen2.dart';
import 'auth_controller.dart';

class RegisterController extends FxController {
  TickerProvider ticker;
  RegisterController(this.ticker);
  late TextEditingController nameTE, emailTE, passwordTE, phoneTE;
  GlobalKey<FormState> formKey = GlobalKey();
  String? selectedCountryCode;
  final List<String> countryCodes = ['+91', '+23', '+010'];
  late AnimationController arrowController,
      nameController,
      emailController,
      passwordController,
      phoneController;
  late Animation<Offset> arrowAnimation,
      nameAnimation,
      emailAnimation,
      passwordAnimation,
      phoneAnimation;
  int nameCounter = 0;
  int emailCounter = 0;
  int passwordCounter = 0;
  int phoneCounter = 0;

  // List categoryItemlist = [];

  // Future getAllCategory() async {
  //   var baseUrl = "https://gssskhokhar.com/api/classes/";
  //   var response=await http.get(Uri.parse(
  //           'https://a.walletbot.online/api/v1/home/initial-data',
  //         ));

  //   // http.Response response = await http.get(Uri.parse(baseUrl));

  //   if (response.statusCode == 200) {
  //     var jsonData = json.decode(response.body);
  //     setState(() {
  //       categoryItemlist = jsonData;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    nameTE = TextEditingController();
    emailTE = TextEditingController();
    passwordTE = TextEditingController();
    phoneTE = TextEditingController();

    arrowController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    nameController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    emailController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    passwordController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    phoneController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));

    arrowAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    nameAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: nameController,
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

    phoneAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: passwordController,
      curve: Curves.easeIn,
    ));

    nameController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        nameController.reverse();
      }
      if (status == AnimationStatus.dismissed && nameCounter < 2) {
        nameController.forward();
        nameCounter++;
      }
    });
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
    phoneController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        phoneController.reverse();
      }
      if (status == AnimationStatus.dismissed && phoneCounter < 2) {
        phoneController.forward();
        phoneCounter++;
      }
    });
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      emailController.forward();
      return "Please enter email";
    }
    //else if (FxStringValidator.isEmail(text)) {
    //   emailController.forward();
    //   return "Please enter valid email";
    // }
    return null;
  }

  String? validateMobile(String? text) {
    if (text == null || text.isEmpty) {
      emailController.forward();
      return "Please enter phone number";
    } else if (text != 10) {
      emailController.forward();
      return "Please enter 10digits";
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

  String? validateName(String? text) {
    if (text == null || text.isEmpty) {
      nameController.forward();
      return "Please enter name";
    } else if (!FxStringValidator.validateStringRange(text, 4, 20)) {
      nameController.forward();
      return "Password length must between 4 and 20";
    }
    return null;
  }

  // String? _selectedCountryCode;
  // final List<String> _countryCodes = ['+91', '+23'];

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  //A function that validate user entered password
  bool validatePassword1(String pass) {
    String password = pass.trim();
    if (pass_valid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    arrowController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    passwordCounter = 0;
    nameCounter = 0;
    emailCounter = 0;
    phoneCounter = 0;
    // if (formKey.currentState!.validate()) {
    //   arrowController.forward();
    //   await Future.delayed(const Duration(milliseconds: 500));
    //   await AuthController()
    //       .register(
    //           nameTE.text,
    //           emailTE.text,
    //           // int.parse(phoneTE.text)
    //           '63ac33c3ff04e5652a2583f1',
    //           phoneTE.text,
    //           passwordTE.text)
    //       .then((value) =>
    //           Navigator.of(context, rootNavigator: true).pushReplacement(
    //             MaterialPageRoute(
    //               builder: (context) => const SplashScreen2(),
    //             ),
    //           ));
    //   // log('message');
    //   // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   //   MaterialPageRoute(
    //   //     builder: (context) => SplashScreen2(),
    //   //   ),
    //   // );
    // }
    if (nameTE.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please enter name")));
    } else if (emailTE.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please enter email")));
    }
    // else if (_selectedCountryCode == null || _selectedCountryCode!.isEmpty) {
    //   // log('isempty');
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text("please select country code")));
    // }
    else if (selectedCountryCode == null || selectedCountryCode!.isEmpty) {
      // log('isempty');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("please select country code")));
    } else if (phoneTE.text.isEmpty
        // || phoneTE.text.length != 10
        ) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter 10digit number code")));
    } else if (passwordTE.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Password contains one alphabet and correctors and numbers")));
      // if (passwordTE.text.contains(RegExp(r"[a-z]"))) {
      //   log('A');
      // }
      // if (passwordTE.text.contains(RegExp(r"[A-Z]"))) {
      //   log('b');
      // }
      // if (passwordTE.text.contains(RegExp(r"[0-9]"))) {
      //   log('c');
      // }
      // if (passwordTE.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      //   log('d');
      // } else {
      //   return;
      // }
    } else {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text("success")));
      arrowController.forward();
      await Future.delayed(const Duration(milliseconds: 500));
      // await AuthController()
      //     .register(
      //         nameTE.text,
      //         emailTE.text,
      //         // int.parse(phoneTE.text)
      //         // '63ac33c3ff04e5652a2583f1',
      //         selectedCountryCode.toString(),
      //         phoneTE.text,
      //         passwordTE.text)
      //     .then((value) =>
      //         Navigator.of(context, rootNavigator: true).pushReplacement(
      //           MaterialPageRoute(
      //             builder: (context) => const SplashScreen2(),
      //           ),
      //         ));
      await AuthController()
          .register(nameTE.text, emailTE.text, selectedCountryCode.toString(),
              phoneTE.text, passwordTE.text, context)
          .then((value) {
        if (value) {
          Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SplashScreen2(),
            ),
          );
        }
      });
    }
  }

  void goToLogInScreen() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      ),
    );
  }

  @override
  String getTag() {
    return "register_controller";
  }
}
