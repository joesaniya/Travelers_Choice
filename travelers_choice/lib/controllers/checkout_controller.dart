import 'dart:developer';

import 'package:cc_avenue/cc_avenue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/views/hotel_travel_constants.dart';
import 'package:iconsax/iconsax.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../models/atteraction_model.dart';
import '../models/product.dart';
import '../models/razor_response.dart';
import '../models/shipping_address.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../views/checkout_screen.dart';
import '../views/payment_cc.dart';
import 'razor_credentials.dart' as razorCredentials;

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
  int? selectedPayment = 0;
  ShippingAddress? addressSelected;
  List<ShippingAddress>? addressList;
  bool showcode = false;
  List<Product>? products;
  bool addCart = false;
  String? selectedCountryCode;
  bool selected = true;

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
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print('response Success');
    log('response Success');
    verifySignature(
      signature: response.signature,
      paymentId: response.paymentId,
      orderId: response.orderId,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('responseError');
    log('responseError');
    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message ?? ''),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('responsewallet:');
    log('response wallet:');
    // Do something when an external wallet is selected
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.walletName ?? ''),
      ),
    );
  }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) async {
  //   // Fluttertoast.showToast(msg: " Payment Successfully");
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(const SnackBar(content: Text(' Payment Successfully')));
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(const SnackBar(content: Text(' Payment Failed')));
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(const SnackBar(content: Text(' External Wallet')));
  // }
  final _razorpay = Razorpay();
  @override
  initState() {
    super.initState();
    fetchData();

    // details=;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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
      log('PlatformException');
    }
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

  Cartnext(selectedExcursionsDatas, context, total) async {
    log('cartnext');
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
        pageBuilder: (_, __, ___) => CheckOutScreen(
            selectedtour.length,
            // selectedtours,
            selectedtour,
            dateTE.text,
            selectedtransfer,

            // excursions.activities!
            // amount
            grandSelectedTourAmount())));
  }

  //next button
  nextPage(selectedExcursionsDatas, context, total) async {
    log('Page Number:$currentPage ');
    log('Total:$total ');

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
      } else if (phoneTE.text.isEmpty
          // || phoneTE.text.length != 10
          ) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please Enter Phone Number")));
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
        createOrderccAvenue(selectedExcursionsDatas);
      } else {
        log('2');
        createOrder(selectedExcursionsDatas);
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

  //redirect

  Future<dynamic> createOrder1() async {
    var mapHeader = <String, String>{};
    mapHeader['Authorization'] =
        "Basic cnpwX3Rlc3RfU2RHQmFoV3RsS1dNd2I6Mlh2WElOSDlMcG9xTHdyU3F5cDFzam5y";
    mapHeader['Accept'] = "application/json";
    mapHeader['Content-Type'] = "application/x-www-form-urlencoded";
    var map = <String, String>{};

    map['amount'] = "${(num.parse(phoneTE.text) * 100)}";
    // map['amount'] = "${(num.parse(200 as S) * 100)}";

    map['currency'] = "INR";
    map['receipt'] = "receipt1";
    print("map $map");
    var response = await http.post(Uri.https("api.razorpay.com", "/v1/orders"),
        headers: mapHeader, body: map);
    print("....${response.body}");
    if (response.statusCode == 200) {
      RazorpayOrderResponse1 data =
          RazorpayOrderResponse1.fromJson(json.decode(response.body));
      openCheckout1(data);
    } else {
      log('Error');
      // Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }

  void openCheckout1(RazorpayOrderResponse1 data) async {
    // var options = {
    //   'key': razorCredentials.keyId,
    //   'amount': "${(num.parse(phoneTE.text) * 100)}",
    //   'name': 'Razorpay Test',
    //   'description': '',
    //   'order_id': data.order.id,
    // };
    log('openchk:$data');
    var options = {
      'key': razorCredentials.keyId,
      'amount': 100, //in the smallest currency sub-unit.
      'name': 'Acme Corp.',
      'order_id': data.order.id, // Generate order_id using Orders API
      'description': 'Tours',
      'timeout': 60 * 5, // in seconds // 5 minutes
      'prefill': {
        // 'contact': phoneTE.text,
        'contact': '7639798240',
        'email': emailTE.text,
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void createOrder(selectedExcursionsDatas) async {
    String username = razorCredentials.keyId;
    String password = razorCredentials.keySecret;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    List<Map<String, dynamic>> ActivityList = [];
    for (var element in selectedExcursionsDatas) {
      print('Element:${element.sId}');
      print('Element Date:${element.selectedDate}');
      print('Element Type:${element.transferType}');
      print('Adult Count:${element.adultCount}');
      print('child Count:${element.childCount}');
      print('Infant Count:${element.infantCount}');
      // var datas=
      Map<String, dynamic> datas = {
        // "activity": element.sId,
        // // "date": "2023-02-28",
        // "date": element.selectedDate,
        // "adultsCount": element.adultCount,
        // "childrenCount": element.childCount,
        // "infantCount": element.infantCount,
        // "transferType": "private"
        "activity": "63e6317d20e0e01648630e6a",
        "date": "2023-04-5",
        "adultsCount": 1,
        "childrenCount": 0,
        "infantCount": 0,
        "transferType": "private"
      };
      ActivityList.add(datas);
      print('Data-->$datas');
    }
    selectedExcursionsDatas.map((e) =>
        // e,
        log('selected Activites:$e'));
    //var body=
    Map<String, dynamic> body = {
      "name": FnameTE.text,
      "email": emailTE.text,
      "phoneNumber": phoneTE.text,
      "country": selectedCountryCode,
      "paymentProcessor": "razorpay",
      // "paymentProcessor": selectedPayment == 1 ? "ccavenue" : "razorpay",
      // "selectedActivities": jsonEncode(ActivityList)
      "selectedActivities": ActivityList
    };
    var res = await http.post(
      Uri.parse(
          // "api.razorpay.com", "v1/orders"
          "https://secure.mytravellerschoice.com/api/v1/attractions/orders/create"), //https://api.razorpay.com/v1/orders
      //https://secure.mytravellerschoice.com/api/v1/attractions/orders/create

      headers: <String, String>{
        "Content-Type": "application/json",
        // 'authorization': basicAuth,
      },
      body: jsonEncode(body),
    );
    log('Body Data:${res.body}');
    // if (res.statusCode == 200) {
    //   RazorpayOrderResponse1 data =
    //       RazorpayOrderResponse1.fromJson(json.decode(res.body));
    //   log('res.body${res.body}');
    //   openCheckout1(data);
    // }
    //todo

    if (res.statusCode == 200) {
      var jsondata = jsonDecode(res.body);
      log('Response:${res.body}');
      String orderId = jsondata['order']['id'];
      // openGateway(jsonDecode(res.body)['id']);
      // log('Response Id:${jsonDecode(res.body)['id']}');
      log('Response Id:${jsonDecode(res.body)['orderId']}');
      log('order Id:${jsondata['order']['id']}');
      // openGateway(jsonDecode(res.body)['orderId']);
      openGateway(orderId);
      // openGateway(jsondata['order']);
      // pageController.animateToPage(
      //   currentPage + 1,
      //   duration: const Duration(milliseconds: 600),
      //   curve: Curves.ease,
      // );
    }
    // print('Body:${res.body}');
    // log('Body:${res.body}');
    else {
      var jsondata = jsonDecode(res.body);
      log(jsondata['error']);
      print(jsondata['error']);
      //snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(jsondata['error'])));
      return null;
    }
  }

// openGateway(Map<String, dynamic> order)
  openGateway(String orderId) {
    log('OrderId:$orderId');
    log('key:${razorCredentials.keyId}');
    var options = {
      "key": razorCredentials.keyId,
      "amount": 10000, //in the smallest currency sub-unit.
      "name": "Acme Corp.",
      "order_id": orderId, // Generate order_id using Orders API
      "description": "Tours",
      "timeout": 60 * 5, // in seconds // 5 minutes
      "prefill": {
        "contact": phoneTE.text,
        "email": emailTE.text,
      }
    };
    // _razorpay.open(options);
    // var datavalue = jsonEncode(options);
    String encodedMap = jsonEncode(options);

    Map<String, dynamic> user = jsonDecode(encodedMap ?? '');
    // Map<String, dynamic> map =
    //     json.decode(options as String) as Map<String, dynamic>;
    try {
      // log('Options:$datavalue');

      // _razorpay.open(datavalue);
      // log('Options:$options');
      // _razorpay.open(options);
      //todo
      log('Options:$user');
      _razorpay.open(user);
    } catch (e) {
      print('razor error:${e.toString()}');
    }
  }

  verifySignature({
    String? signature,
    String? paymentId,
    String? orderId,
    //  String? razorpayorderid,
    // String? transactionid,
    // String? signature,
    // String? orderId,
  }) async {
    Map<String, dynamic> body = {
      'razorpay_signature': signature,
      'razorpay_payment_id': paymentId,
      'razorpay_order_id': orderId,
      // 'razorpay_order_id': razorpayorderid,
      // 'transactionid': transactionid,
      // 'razorpay_signature': signature,
      // 'orderId': orderId,
    };

    var parts = [];
    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    var res = await http.post(
      Uri.https(
        "10.0.2.2", // my ip address , localhost
        "razorpay_signature_verify.php",
      ),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded", // urlencoded
      },
      body: formData,
    );

    print('sign:${res.body}');
    log('sign:${res.body}');
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.body),
        ),
      );
    }
  }

  //ccavenue
  void createOrderccAvenue(selectedExcursionsDatas) async {
    String username = razorCredentials.keyId;
    String password = razorCredentials.keySecret;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    List<Map<String, dynamic>> ActivityList = [];
    for (var element in selectedExcursionsDatas) {
      print('Element:${element.sId}');
      print('Element Date:${element.selectedDate}');
      print('Element Type:${element.transferType}');
      print('Adult Count:${element.adultCount}');
      print('child Count:${element.childCount}');
      print('Infant Count:${element.infantCount}');
      // var datas=
      Map<String, dynamic> datas = {
        "activity": element.sId,
        // "date": "2023-02-28",
        "date": element.selectedDate,
        "adultsCount": element.adultCount,
        "childrenCount": element.childCount,
        "infantCount": element.infantCount,
        "transferType": "private"
        // "activity": "63e6317d20e0e01648630e6a",
        // "date": "2023-04-5",
        // "adultsCount": 1,
        // "childrenCount": 0,
        // "infantCount": 0,
        // "transferType": "private"
      };
      ActivityList.add(datas);
      print('Data-->$datas');
    }
    selectedExcursionsDatas.map((e) =>
        // e,
        log('selected Activites:$e'));
    //var body=
    Map<String, dynamic> body = {
      "name": FnameTE.text,
      "email": emailTE.text,
      "phoneNumber": phoneTE.text,
      "country": selectedCountryCode,
      "paymentProcessor": "ccavenue",
      // "paymentProcessor": selectedPayment == 1 ? "ccavenue" : "razorpay",
      // "selectedActivities": jsonEncode(ActivityList)
      "selectedActivities": ActivityList
    };
    var res = await http.post(
      Uri.parse(
          "https://secure.mytravellerschoice.com/api/v1/attractions/orders/create"),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(body),
    );
    log('Body Data:${res.body}');

    //todo

    if (res.statusCode == 200) {
      log('Response cc:${res.body}');

      var paymentdata = res.body;
      log('Payment data:$paymentdata');
      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(
          builder: (context) => PaymentCC(paymentdata: paymentdata),
        ),
      );
      //     .whenComplete(() {
      //   log('complete');
      //   Navigator.of(context, rootNavigator: true).pushReplacement(
      //     MaterialPageRoute(
      //       builder: (context) => const BookingSuccess(),
      //     ),
      //   );
      // });
    } else {
      var jsondata = jsonDecode(res.body);
      log(jsondata['error']);
      print(jsondata['error']);
      //snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(jsondata['error'])));
      return null;
    }
  }

  void createOrderDemo(total) async {
    log('CreateOrdeerDemo');
    log('Total Demo:$total');
    String username = razorCredentials.keyId;
    String password = razorCredentials.keySecret;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    Map<String, dynamic> body = {
      "amount": total,
      "currency": "AED",
      "receipt": "rcptid_11"
    };

    var res = await http.post(
      // Uri.parse(
      //     "https://secure.mytravellerschoice.com/api/v1/attractions/orders/create"),
      Uri.https(
          "api.razorpay.com", "v1/orders"), //https://api.razorpay.com/v1/orders
      headers: <String, String>{
        "Content-Type": "application/json",
        'authorization': basicAuth,
      },
      body: jsonEncode(body),
    );

    if (res.statusCode == 200) {
      openGatewaydemo(jsonDecode(res.body)['id'], total);
    }
    print('Body:${res.body}');
    log('Body:${res.body}');
  }

  openGatewaydemo(String orderId, double total) {
    log('id:$orderId');
    log('tot:$total');
    var options = {
      'key': razorCredentials.keyId,
      'amount': total, //in the smallest currency sub-unit.
      'name': 'Acme Corp.',
      'order_id': orderId, // Generate order_id using Orders API
      'description': 'Tours',
      'timeout': 60 * 5, // in seconds // 5 minutes
      'prefill': {
        'contact': phoneTE.text,
        'email': emailTE.text,
      }
    };
    _razorpay.open(options);
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
    return "checkout_controller";
  }
}
