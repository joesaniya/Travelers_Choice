import 'dart:developer';
import '/card_widgets/customsnackbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/views/hotel_travel_constants.dart';
import 'package:iconsax/iconsax.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/views/booking_success.dart';
import '/models/atteraction_model.dart';
import '/models/product.dart';
import '/models/razor_response.dart';
import '/models/shipping_address.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/services/app_constants.dart';
import '/views/checkout_screen.dart';
import '/views/login_Screens/login_screen.dart';
import '/views/payment_cc.dart';


class Tab {
  String name;
  IconData iconData;

  Tab(this.name, this.iconData);
}

class HotelCheckOutController extends FxController {
  TickerProvider ticker;
  HotelCheckOutController(this.ticker);
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  int numPages = 3;
  int paymentMethodSelected = 1;
  int? selectedPayment = 0;
  ShippingAddress? addressSelected;
  List<ShippingAddress>? addressList;
  bool showcode = false;
  List<Product>? products;
  bool addCart = false;
  String? selectedCountryCode;
  String? selectedCountryCode1;
  String? selectedCountryName;
  bool selected = true;

  List<Tab> tabs = [];
  String? token;
//form
  late Animation<double> fadeAnimation, cartAnimation;
  // late AnimationController animationController;

  late TextEditingController FnameTE, LnameTE, emailTE, phoneTE, reqTE, promoTE;
  GlobalKey<FormState> formKey = GlobalKey();
  String? selectedname;
  final List<String> nameCodes = ['Mr.', 'Mrs.', 'Ms.'];
  String? selectedcountry;
  String? selectedNameCountry;

  final List<String> countryCodes = ['India', 'UAE', 'France'];
  late AnimationController arrowController,
      animationController,
      cartController,
      firstnameController,
      lastnameController,
      emailController,
      phoneController,
      promoController,
      reqController;
  late Animation<Offset> arrowAnimation,
      firstnameAnimation,
      lastnameAnimation,
      emailAnimation,
      phoneAnimation,
      promoAnimation,
      reqAnimation;

  int firstnameCounter = 0;
  int lastnameCounter = 0;
  int emailCounter = 0;
  int reqCounter = 0;
  int phoneCounter = 0;
  int promoCounter = 0;
  List<Map<String, dynamic>> details = [];


  
  final _razorpay = Razorpay();
  @override
  initState() {
    super.initState();
    fetchData();
    SharedPreferences.getInstance().then((sharedPrefValue) {
      token = sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN);
      log(token.toString());
    });
    
    currentPage = 0;
    addressList = ShippingAddress.shipping();
    addressSelected = addressList!.first;
    tabs = [
      Tab('Personal Details', Iconsax.user),
      Tab('Payment', Icons.payment),
      Tab('Booked', Icons.check_circle_outline),
    ];
    FnameTE = TextEditingController();
    LnameTE = TextEditingController();
    emailTE = TextEditingController();
    phoneTE = TextEditingController();
    reqTE = TextEditingController();
    promoTE = TextEditingController();

    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: ticker,
    );
    cartController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
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
    promoController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));

    arrowController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    firstnameController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    lastnameController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    emailController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    phoneController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    reqController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));

    //animation
    arrowAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
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
    promoAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: promoController,
      curve: Curves.easeIn,
    ));
    firstnameAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: firstnameController,
      curve: Curves.easeIn,
    ));
    lastnameAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: lastnameController,
      curve: Curves.easeIn,
    ));
    emailAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: emailController,
      curve: Curves.easeIn,
    ));
    phoneAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: phoneController,
      curve: Curves.easeIn,
    ));
    reqAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: reqController,
      curve: Curves.easeIn,
    ));
    animationController.forward();

    //listener
    promoController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        promoController.reverse();
      }
      if (status == AnimationStatus.dismissed && promoCounter < 2) {
        promoController.forward();
        promoCounter++;
      }
    });
    firstnameController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        firstnameController.reverse();
      }
      if (status == AnimationStatus.dismissed && firstnameCounter < 2) {
        firstnameController.forward();
        firstnameCounter++;
      }
    });
    lastnameController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        lastnameController.reverse();
      }
      if (status == AnimationStatus.dismissed && lastnameCounter < 2) {
        lastnameController.forward();
        lastnameCounter++;
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
    phoneController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        phoneController.reverse();
      }
      if (status == AnimationStatus.dismissed && emailCounter < 2) {
        phoneController.forward();
        phoneCounter++;
      }
    });
    reqController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        reqController.reverse();
      }
      if (status == AnimationStatus.dismissed && reqCounter < 2) {
        reqController.forward();
        reqCounter++;
      }
    });
  }

  void goBack() {
    Navigator.pop(context);
  }

  void selectPaymentMethod(int method) {
    paymentMethodSelected = method;
    update();
  }
  // void showcodeMethod(bool show) {
  //   showcode = show;
  //   update();
  // }

  void selectShippingAddress(ShippingAddress address) {
    addressSelected = address;
    update();
  }

 
  void Login() {
    log('calling login....');
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text('Please Login Your account'),
    //   ),
    // );
    CustomSnackbar.show(
      context: context,
      message: 'Please Login Your account',
      backgroundColor: Color(0xff1529e8),
      duration: Duration(seconds: 2),
    );
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      ),
    );
  }

  void fetchData() async {
    products = HotelTravelCache.products;
    // calculateBilling();
    // showLoading = false;
    // uiLoading = false;
    update();
  }

  List<Activity> selectedtour = [];
  grandSelectedTourAmount() {
    double amount = 0;

    for (Activity tour in selectedtour) {
      log('tour.grandTotal:${tour.grandTotal}');

      amount = amount + (tour.grandTotal);
      log('amount:$amount');
    }

    return amount;
    // update();
    // log('Amount:$amount');
  }

  late TextEditingController dateTE = TextEditingController();
  String? selectedtransfer;



  //next button
  nextPage( context,  token) async {
    log('Page Number:$currentPage ');
    

    if (currentPage == 0) {
      log('selected page 0');
      if (selectedname == null || selectedname!.isEmpty) {
        CustomSnackbar.show(
          context: context,
          message: 'Please Select Mr/Ms/Mrs',
          backgroundColor: Color(0xff1529e8),
          duration: Duration(seconds: 2),
        );
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text("Please Select Mr/Ms/Mrs")));
      } else if (FnameTE.text.isEmpty) {
        CustomSnackbar.show(
          context: context,
          message: 'Please Enter First Name',
          backgroundColor: Color(0xff1529e8),
          duration: Duration(seconds: 2),
        );
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text("Please Enter First Name")));
      } else if (LnameTE.text.isEmpty) {
        CustomSnackbar.show(
          context: context,
          message: 'Please Enter Last Name',
          backgroundColor: Color(0xff1529e8),
          duration: Duration(seconds: 2),
        );
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text("Please Enter Last Name")));
      } else if (emailTE.text.isEmpty) {
        CustomSnackbar.show(
          context: context,
          message: 'Please Enter email',
          backgroundColor: Color(0xff1529e8),
          duration: Duration(seconds: 2),
        );
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(const SnackBar(content: Text("Please Enter Email")));
      } else if (
          // selectedcountry == null || selectedcountry!.isEmpty
          selectedCountryName == null || selectedCountryName!.isEmpty) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text("Please Select Country")));
        CustomSnackbar.show(
          context: context,
          message: 'Please Select Country',
          backgroundColor: Color(0xff1529e8),
          duration: Duration(seconds: 2),
        );
      } else if (selectedCountryCode == null || selectedCountryCode!.isEmpty) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text("Please Select Phone Code")));
        CustomSnackbar.show(
          context: context,
          message: 'Please Select Phone Code',
          backgroundColor: Color(0xff1529e8),
          duration: Duration(seconds: 2),
        );
      } else if (phoneTE.text.isEmpty
          // || phoneTE.text.length != 10
          ) {
        CustomSnackbar.show(
          context: context,
          message: 'Please Enter Phone Number',
          backgroundColor: Color(0xff1529e8),
          duration: Duration(seconds: 2),
        );
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text("Please Enter Phone Number")));
      }
      // else if (reqTE.text.isEmpty) {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(const SnackBar(content: Text("Enter Request")));
      // }
      else {
        await pageController.animateToPage(
          currentPage + 1,
          duration: const Duration(milliseconds: 600),
          curve: Curves.ease,
        );
      }
    } else if (currentPage == 1) {
      log('selected page 1');

      if (selectedPayment == 1) {
        log('1');
        // createOrderccAvenue(selectedExcursionsDatas, token);
      } else {
        log('2');
        // createOrder(selectedExcursionsDatas);
      }

      //crt
      // createOrder(selectedExcursionsDatas);

      // createOrderDemo(total);

      //ttodo
      // createOrder1();

      //

      // showModalBottomSheet(
      //   context: context,
      //   backgroundColor: Colors.transparent,
      //   // backgroundColor: const Color(0xff1529e8).withAlpha(40),
      //   shape: const RoundedRectangleBorder(
      //       borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      //   isScrollControlled: true,
      //   builder: (context) {
      //     return const paymentSelection();
      //   },
      // );
    } else {
      log('selected page final');
      await pageController.animateToPage(
        currentPage + 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    }
  }

  // previousPage() async {
  //   if (currentPage == 0) {
  //     /*   Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => FullApp()));*/
  //   } else {
  //     await pageController.animateToPage(
  //       currentPage - 1,
  //       duration: const Duration(milliseconds: 600),
  //       curve: Curves.ease,
  //     );
  //   }
  // }

  onPageChanged(int page, {bool fromUser = false}) async {
    if (!fromUser) currentPage = page;
    update();
    if (fromUser) {
      await pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    }
  }

  

 


  @override
  void dispose() {
    if (pageController.hasClients) pageController.dispose();
    arrowController.dispose();
    cartController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    reqController.dispose();
    promoController.dispose();
    animationController.dispose();
    _razorpay.clear();
    super.dispose();
  }

  @override
  String getTag() {
    return "hotel_checkout_controller";
  }
}
