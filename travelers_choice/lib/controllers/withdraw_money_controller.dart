import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class WithdrawMoneyController extends FxController {
  TickerProvider ticker;
  WithdrawMoneyController(this.ticker);

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> selectedChoices = [];
  RangeValues selectedRange = const RangeValues(200, 800);

  late Animation<double> fadeAnimation, cartAnimation;
  late TextEditingController amountTE,
      bankNameTE,
      ifsccodeTE,
      accountNoTE,
      benefiaryNameTE,
      phoneTE,
      ibanNumberTE,
      emailTE,
      countryTE;
  late AnimationController arrowController,
      animationController,
      amountController,
      bankNameController,
      ifsccodeController,
      accountNoController,
      benefiaryNameController,
      phoneController,
      ibanNumberController,
      emailController,
      countryController;
  late Animation<Offset> arrowAnimation,
      amountAnimation,
      bankNameAnimation,
      ifsccodeAnimation,
      accountNoAnimation,
      benefiaryNameAnimation,
      phoneAnimation,
      ibanNumberAnimation,
      emailAnimation,
      countryAnimation;
  int amountCounter = 0;
  int bankNameCounter = 0;
  int ifsccodeCounter = 0;
  int accountNoCounter = 0;
  int benefiaryNameCounter = 0;
  int phoneCounter = 0;
  int ibanNumberCounter = 0;
  int emailCounter = 0;
  int countryCounter = 0;
  GlobalKey<FormState> formKey = GlobalKey();

  bool uiLoading = true;

  late Tween<Offset> offset;

  int dateCounter = 0;

  List<String> categoryList = [
    "Theme Park",
    "Theme Park 1",
    "Theme Park 2",
    "Theme Park 3",
    "Theme Park 4",
    "Theme Park 5",
  ];

  void addChoice(String item) {
    selectedChoices.add(item);
    update();
  }

  void removeChoice(String item) {
    selectedChoices.remove(item);
    update();
  }

  void onChangePriceRange(RangeValues newRange) {
    selectedRange = newRange;
    update();
  }

  void fetchloader() async {
    await Future.delayed(const Duration(seconds: 4));

    uiLoading = false;
    log('fetchloader');
    log(uiLoading.toString());
    update();
  }

  @override
  void initState() {
    super.initState();

    fetchloader();
    amountTE = TextEditingController();
    bankNameTE = TextEditingController();
    ifsccodeTE = TextEditingController();
    accountNoTE = TextEditingController();
    benefiaryNameTE = TextEditingController();
    phoneTE = TextEditingController();
    ibanNumberTE = TextEditingController();
    emailTE = TextEditingController();
    countryTE = TextEditingController();

    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: ticker,
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    arrowController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));

    amountController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    bankNameController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    ifsccodeController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    accountNoController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    benefiaryNameController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    phoneController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    ibanNumberController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    emailController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    countryController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));

    //animation
    arrowAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    amountAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: amountController,
      curve: Curves.easeIn,
    ));
    bankNameAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: bankNameController,
      curve: Curves.easeIn,
    ));
    ifsccodeAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: ifsccodeController,
      curve: Curves.easeIn,
    ));
    accountNoAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: accountNoController,
      curve: Curves.easeIn,
    ));
    benefiaryNameAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: benefiaryNameController,
      curve: Curves.easeIn,
    ));
    phoneAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: phoneController,
      curve: Curves.easeIn,
    ));
    ibanNumberAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: ibanNumberController,
      curve: Curves.easeIn,
    ));
    emailAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: emailController,
      curve: Curves.easeIn,
    ));
    countryAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: countryController,
      curve: Curves.easeIn,
    ));

    //listener
    amountController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        amountController.reverse();
      }
      if (status == AnimationStatus.dismissed && amountCounter < 2) {
        amountController.forward();
        amountCounter++;
      }
    });
    bankNameController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        bankNameController.reverse();
      }
      if (status == AnimationStatus.dismissed && bankNameCounter < 2) {
        bankNameController.forward();
        bankNameCounter++;
      }
    });
    ifsccodeController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        ifsccodeController.reverse();
      }
      if (status == AnimationStatus.dismissed && ifsccodeCounter < 2) {
        ifsccodeController.forward();
        ifsccodeCounter++;
      }
    });
    accountNoController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        accountNoController.reverse();
      }
      if (status == AnimationStatus.dismissed && accountNoCounter < 2) {
        accountNoController.forward();
        accountNoCounter++;
      }
    });
    benefiaryNameController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        benefiaryNameController.reverse();
      }
      if (status == AnimationStatus.dismissed && benefiaryNameCounter < 2) {
        benefiaryNameController.forward();
        benefiaryNameCounter++;
      }
    });
    phoneController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        phoneController.reverse();
      }
      if (status == AnimationStatus.dismissed && phoneCounter < 2) {
        phoneController.forward();
        phoneCounter++;
      }
    });
    ibanNumberController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        ibanNumberController.reverse();
      }
      if (status == AnimationStatus.dismissed && ibanNumberCounter < 2) {
        ibanNumberController.forward();
        ibanNumberCounter++;
      }
    });
    emailController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        emailController.reverse();
      }
      if (status == AnimationStatus.dismissed && emailCounter < 2) {
        emailController.forward();
        emailCounter++;
      }
    });
    countryController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        countryController.reverse();
      }
      if (status == AnimationStatus.dismissed && countryCounter < 2) {
        countryController.forward();
        countryCounter++;
      }
    });
  }

  @override
  void dispose() {
    arrowController.dispose();
    amountController.dispose();
    bankNameController.dispose();
    ifsccodeController.dispose();
    accountNoController.dispose();
    benefiaryNameController.dispose();
    phoneController.dispose();
    ibanNumberController.dispose();
    emailController.dispose();
    countryController.dispose();

    super.dispose();
  }

  // void goToSingleProduct(Product product) {
  //   Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
  //       transitionDuration: const Duration(milliseconds: 500),
  //       transitionsBuilder: (
  //         BuildContext context,
  //         Animation<double> animation,
  //         Animation<double> secondaryAnimation,
  //         Widget child,
  //       ) =>
  //           FadeTransition(
  //             opacity: animation,
  //             child: child,
  //           ),
  //       pageBuilder: (_, __, ___) => SingleProductScreen(product)));
  // }

  void openEndDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void closeEndDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  String getTag() {
    return "search_controller";
  }
}
