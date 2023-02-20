import 'dart:developer';

import 'package:cc_avenue/cc_avenue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/views/hotel_travel_constants.dart';
import 'package:iconsax/iconsax.dart';

import '../models/product.dart';
import '../models/shipping_address.dart';
import '../views/bottomSheet/payment_Selection.dart';

class Tab {
  String name;
  IconData iconData;

  Tab(this.name, this.iconData);
}

class CheckOutController extends FxController {
  TickerProvider ticker;
  CheckOutController(this.ticker);
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  int numPages = 3;
  int paymentMethodSelected = 1;
  ShippingAddress? addressSelected;
  List<ShippingAddress>? addressList;
  bool showcode = false;
  List<Product>? products;
  bool addCart = false;
  String? selectedCountryCode;

  List<Tab> tabs = [];
//form
  late Animation<double> fadeAnimation, cartAnimation;
  // late AnimationController animationController;

  late TextEditingController FnameTE, LnameTE, emailTE, phoneTE, reqTE, promoTE;
  GlobalKey<FormState> formKey = GlobalKey();
  String? selectedname;
  final List<String> nameCodes = ['Mr.', 'Mrs.', 'Ms.'];
  String? selectedcountry;
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

  @override
  initState() {
    super.initState();
    fetchData();
    // details=;
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

  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await CcAvenue.cCAvenueInit(
          transUrl: 'https://secure.ccavenue.com/transaction/initTrans',
          accessCode: '4YRUXLSRO20O8NIH',
          amount: '10',
          cancelUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
          currencyType: 'INR',
          merchantId: '2',
          orderId: '519',
          redirectUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
          rsaKeyUrl: 'https://secure.ccavenue.com/transaction/jsp/GetRSA.jsp');
    } on PlatformException {
      print('PlatformException');
    }
  }

  void fetchData() async {
    products = HotelTravelCache.products;
    // calculateBilling();
    // showLoading = false;
    // uiLoading = false;
    update();
  }

  // nextPage1(selectedExcursionsDatas) async {
  //   if (currentPage == numPages) {
  //     /*   Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => FullApp()));*/
  //   } else {
  //     // await pageController.animateToPage(
  //     //   currentPage + 1,
  //     //   duration: const Duration(milliseconds: 600),
  //     //   curve: Curves.ease,
  //     // );
  //     await PaymentController()
  //         // .PersonalInfo(nameTE.text, emailTE.text, selectedCountryCode.toString(),
  //         //     phoneTE.text, passwordTE.text, context)
  //         .PersonalInfo('jeni', 'jeni@gmail.com', '6098754321',
  //             '63db60f9f926b340dbb3f446', selectedExcursionsDatas)
  //         .then((value) {
  //       if (value) {
  //         log('Value:$value');
  //         pageController.animateToPage(
  //           currentPage + 1,
  //           duration: const Duration(milliseconds: 600),
  //           curve: Curves.ease,
  //         );
  //       }
  //     });
  //     //validation
  //     // if (selectedname == null || selectedname!.isEmpty) {
  //     //   ScaffoldMessenger.of(context).showSnackBar(
  //     //       const SnackBar(content: Text("Please Select Mr/Ms/Mrs")));
  //     // } else if (FnameTE.text.isEmpty) {
  //     //   ScaffoldMessenger.of(context).showSnackBar(
  //     //       const SnackBar(content: Text("Please Enter First Name")));
  //     // } else if (LnameTE.text.isEmpty) {
  //     //   ScaffoldMessenger.of(context).showSnackBar(
  //     //       const SnackBar(content: Text("Please Enter Last Name")));
  //     // } else if (emailTE.text.isEmpty) {
  //     //   ScaffoldMessenger.of(context)
  //     //       .showSnackBar(const SnackBar(content: Text("Please Enter Email")));
  //     // } else if (selectedcountry == null || selectedcountry!.isEmpty) {
  //     //   ScaffoldMessenger.of(context).showSnackBar(
  //     //       const SnackBar(content: Text("Please Select Country")));
  //     // } else if (selectedCountryCode == null || selectedCountryCode!.isEmpty) {
  //     //   ScaffoldMessenger.of(context).showSnackBar(
  //     //       const SnackBar(content: Text("Please Select Phone Code")));
  //     // } else if (phoneTE.text.isEmpty

  //     //     //  ||phoneTE.length!=10
  //     //     ) {
  //     //   ScaffoldMessenger.of(context).showSnackBar(
  //     //       const SnackBar(content: Text("Please Enter Phone Number")));
  //     // } else if (reqTE.text.isEmpty) {
  //     //   ScaffoldMessenger.of(context)
  //     //       .showSnackBar(const SnackBar(content: Text("Enter Request")));
  //     // } else {
  //     //   await pageController.animateToPage(
  //     //     currentPage + 1,
  //     //     duration: const Duration(milliseconds: 600),
  //     //     curve: Curves.ease,
  //     //   );
  //     // }
  //   }
  // }

  //next button
  nextPage(selectedExcursionsDatas) async {
    log('Page Number:$currentPage ');

    if (currentPage == 0) {
      log('selected page 0');
      if (selectedname == null || selectedname!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please Select Mr/Ms/Mrs")));
      } else if (FnameTE.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please Enter First Name")));
      } else if (LnameTE.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please Enter Last Name")));
      } else if (emailTE.text.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Please Enter Email")));
      } else if (selectedcountry == null || selectedcountry!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please Select Country")));
      } else if (selectedCountryCode == null || selectedCountryCode!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please Select Phone Code")));
      } else if (phoneTE.text.isEmpty || phoneTE.text.length != 10) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please Enter Phone Number")));
      } else if (reqTE.text.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Enter Request")));
      } else {
        await pageController.animateToPage(
          currentPage + 1,
          duration: const Duration(milliseconds: 600),
          curve: Curves.ease,
        );
      }
      // await pageController.animateToPage(
      //   currentPage + 1,
      //   duration: const Duration(milliseconds: 600),
      //   curve: Curves.ease,
      // );
    } else if (currentPage == 1) {
      log('selected page 1');
      // await PaymentController()
      //     // .PersonalInfo(nameTE.text, emailTE.text, selectedCountryCode.toString(),
      //     //     phoneTE.text, passwordTE.text, context)
      //     .PersonalInfo('jeni', 'jeni@gmail.com', '6098754321',
      //         '63db60f9f926b340dbb3f446', 'razorpay', selectedExcursionsDatas)
      //     .then((value) {
      //   if (value) {
      //     log('Value:$value');

      //     pageController.animateToPage(
      //       currentPage + 1,
      //       duration: const Duration(milliseconds: 600),
      //       curve: Curves.ease,
      //     );
      //   }
      // });
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        // backgroundColor: const Color(0xff1529e8).withAlpha(40),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        isScrollControlled: true,
        builder: (context) {
          return const paymentSelection();
        },
      );
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
    super.dispose();
  }

  @override
  String getTag() {
    return "checkout_controller";
  }
}
