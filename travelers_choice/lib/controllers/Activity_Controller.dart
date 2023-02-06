import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:intl/intl.dart';

import '../models/cart.dart';
import '../views/checkout_screen.dart';
import '../views/hotel_travel_constants.dart';

class ActivityController extends FxController {
  TickerProvider ticker;
  ActivityController(this.ticker);
  bool showLoading = true, uiLoading = true;
  final List<String> TransferCodes = ['without'];
  String? selectedtransfer;
  bool addCart = false;
  bool clickedExcursion = false;

  List<Cart>? carts;

  // bool increaseAble(Product product) {
  //   return product.person < 9;
  //   // return product.person < product.person;
  //   // return cart.quantity < cart.product.quantity;
  // }

  // bool decreaseAble(Product product) {
  //   return product.person > 1;
  // }

  // void increment(Product product) {
  //   if (!increaseAble(product)) return;
  //   product.person++;
  //   // calculateBilling();
  //   update();
  // }

  // void decrement(Product product) {
  //   if (!decreaseAble(product)) return;
  //   product.person--;
  //   // calculateBilling();
  //   update();
  // }
  bool increaseAble(Cart cart) {
    return cart.person < cart.product.person;
  }

  bool decreaseAble(Cart cart) {
    return cart.person > 1;
  }

  void increment(Cart cart) {
    if (!increaseAble(cart)) return;
    cart.person++;
    // calculateBilling();
    update();
  }

  void decrement(Cart cart) {
    if (!decreaseAble(cart)) return;
    cart.person--;
    // calculateBilling();
    update();
  }

  late Animation<Offset> animation, dateAnimation;
  late Animation<double> sizeAnimation,
      cartAnimation,
      paddingAnimation,
      fadeAnimation;
  late AnimationController animationController,
      fadeController,
      cartController,
      dateController;
  late TextEditingController dateTE;
  int dateCounter = 0;

  void fetchData() async {
    carts = HotelTravelCache.carts;
    // carts = HotelTravelCache.carts!.cast<Cart>();
    log('fetch');
    log(carts!.length.toString());
    // calculateBilling();
    showLoading = false;
    // uiLoading = false;
    update();
  }

  @override
  void initState() {
    super.initState();
    fetchloader();
    fetchData();
    dateTE = TextEditingController();
    dateController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    dateAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: dateController,
      curve: Curves.easeIn,
    ));
    animationController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: ticker,
    );
    cartController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: ticker,
    );
    animation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(15, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    cartAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 24, end: 28), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 28, end: 24), weight: 50)
    ]).animate(cartController);
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: fadeController,
        curve: Curves.easeIn,
      ),
    );
    fadeController.forward();
    cartController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        addCart = true;
        update();
      }
      if (status == AnimationStatus.dismissed) {
        addCart = false;
        update();
      }
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });
    dateController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        dateController.reverse();
      }
      if (status == AnimationStatus.dismissed && dateCounter < 2) {
        dateController.forward();
        dateCounter++;
      }
    });
  }

  Future<void> dateselect() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            1900), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate);
      dateTE.text = formattedDate;

      // setState(() {
      //   dateinput.text = formattedDate; //set output date to TextField value.
      // });
    } else {
      print("Date is not selected");
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    dateController.dispose();
    fadeController.dispose();
    cartController.dispose();
    super.dispose();
  }

  void fetchloader() async {
    await Future.delayed(const Duration(seconds: 4));

    uiLoading = false;
    log('fetchloader');
    log(uiLoading.toString());
    update();
  }

  void goBack() {
    Navigator.pop(context);
  }

  Future<void> goToCheckout() async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) =>
            FadeTransition(
              opacity: animation,
              child: child,
            ),
        pageBuilder: (_, __, ___) => const CheckOutScreen()));
  }

  @override
  String getTag() {
    return "Activity_controller";
  }
}
