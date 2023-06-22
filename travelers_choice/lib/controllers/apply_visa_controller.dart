
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import '../card_widgets/customsnackbar.dart';

import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/models/Country_modal.dart';
import 'package:hotel_travel/models/visaModels/create_visa_modal.dart';
import 'package:hotel_travel/services/visa_service.dart';
import 'package:hotel_travel/views/payment_screen.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import '../models/atteraction_model.dart';
import '../models/product.dart';
import '../models/shipping_address.dart';
import '../models/visaModels/visa_document_model.dart';
import 'razor_credentials.dart' as razorCredentials;

import '../views/payment_cc.dart';
import '../views/checkout_screen.dart';
import '../../controllers/attraction_Controller.dart';

import '../views/hotel_travel_constants.dart';

class Tab {
  String name;
  IconData iconData;

  Tab(this.name, this.iconData);
}


class ApplyVisaController extends FxController {
  TickerProvider ticker;
  ApplyVisaController(this.ticker);

  List<DetailattractionModal> detailattraction = <DetailattractionModal>[];
  bool showLoading = true, uiLoading = true;

  //tab
  int? selectedPayment = 0;
  late TabController tabController;
  late ScrollController scrollController;
  String? countryId;
  bool selected = true;
  //
  List<Tab> tabs = [];

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
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(response.message ?? ''),
    //   ),
    // );
    CustomSnackbar.show(
      context: context,
      message: response.message ?? '',
      backgroundColor: Color(0xff1529e8),
      duration: Duration(seconds: 2),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('responsewallet:');
    log('response wallet:');
    // Do something when an external wallet is selected
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(response.walletName ?? ''),
    //   ),
    // );
    CustomSnackbar.show(
      context: context,
      message: response.walletName ?? '',
      backgroundColor: Color(0xff1529e8),
      duration: Duration(seconds: 2),
    );
  }
//  late  Product product;
  // late DetailattractionModal product;

  late AnimationController animationController, cartController, dateController;
  late Animation<Color?> colorAnimation;
  late Animation<double> sizeAnimation,
      cartAnimation,
      paddingAnimation,
      fadeAnimation;
  late Animation<Offset> dateAnimation;
  int dateCounter = 0;
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0, numPages = 4;
  late Timer timerAnimation;
  late TextEditingController dateTE;
  late TextEditingController visaController;
  GlobalKey<FormState> formKey = GlobalKey();

  int paymentMethodSelected = 1;
  ShippingAddress? addressSelected;
  List<ShippingAddress>? addressList;
  bool showcode = false;
  List<Product>? products;
  bool addCart = false;

  final _razorpay = Razorpay();


  // late AnimationController animationController;

  bool isFav = false;

  late List<String> sizes;
  String selectedSize = 'M';

  // List<Product>? products;
  late double order, tax = 30, offer = 50, total;

  String? selectedtransfer;
  final List<String> TransferCodes = ['without'];
  String? selectedPax;
  final List<String> PaxCodes = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20'
  ];
  Color appBarColor = Colors.transparent;

  changeAppBarColor(ScrollController scrollController) {
    if (scrollController.position.hasPixels) {
      if (scrollController.position.pixels > 2.0) {
        appBarColor = Colors.green;
        // setState(() {
        //   appBarColor = AppColor.primary;
        // });
      }
      if (scrollController.position.pixels <= 2.0) {
        appBarColor = Colors.transparent;
        // setState(() {
        //   appBarColor = Colors.transparent;
        // });
      }
    } else {
      appBarColor = Colors.transparent;
      // setState(() {
      //   appBarColor = Colors.transparent;
      // });
    }
  }

  bool isLoading = true;

  // late AnimationController animationController;

  late TextEditingController  FnameTE,LnameTE, emailTE,
      addressTE, phoneTE,passportTE, fromDateTE, toDateTE,dobTE, expiryTE;

  List<List<String>>selectTitle = [];
  List<String> selectedTitle=[];
  final List<String> titleCodes = ['Mr','Ms', 'Mrs','Mstr'];
  String? selectedVisa;
  // final List<String> visaTypes =
  // [
  //   '30 day single entry tourist visa',
  //   '60 days single entry tourist visa',
  //   '12 days work visa'];
  List<List<CountryElement>>selectCountry = [];
  List<CountryElement> selectedCountry=[];
  List<CountryElement> countryCodes = [];
  int? selectedTraveller ;
  final List<int> travellerNumber = [1,2,3,4,5,6,7,8,9];
  late AnimationController arrowController,

      firstnameController,
      lastnameController,
      emailController,
      phoneController,
      addressController,
      passportController,
      dobController,
      expiryController;

  late Animation<Offset> arrowAnimation,
      firstnameAnimation,
      lastnameAnimation,
      emailAnimation,
      phoneAnimation,
      addressAnimation,
      passportAnimation;

  int firstnameCounter = 0;
  int lastnameCounter = 0;
  int emailCounter = 0;
  int addressCounter = 0;
  int phoneCounter = 0;
  int passportCounter = 0;
  List<String> visaApplication = [];

  List<TextEditingController> firstNameControllers = [];
  List<TextEditingController> lastNameControllers = [];
  List<TextEditingController> emailControllers = [];
  List<TextEditingController> contactControllers = [];
  List<TextEditingController> passportControllers = [];
  List<TextEditingController> dobControllers = [];
  List<TextEditingController> expiryControllers = [];

  @override
  initState() {
    super.initState();
    fetchData();
    // print("erfdv fervf $visaApplication");
    fetchloader();
    currentPage = 0;
    addressList = ShippingAddress.shipping();
    addressSelected = addressList!.first;
    tabs = [
      Tab('Traveller Details', Icons.card_travel_outlined),
      Tab('Upload Details', Icons.paste_sharp),
      Tab('Make Payment',Icons.payment ),
    ];

    // visaApplication.add();
    FnameTE = TextEditingController();
    LnameTE = TextEditingController();
    emailTE = TextEditingController();
    addressTE = TextEditingController();
    phoneTE = TextEditingController();
    passportTE = TextEditingController();
    fromDateTE = TextEditingController();
    toDateTE = TextEditingController();
    dobTE = TextEditingController();
    expiryTE = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });

    animationController = AnimationController(
      duration: const Duration(seconds: 1),
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
    phoneController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));

    arrowController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    firstnameController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    lastnameController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    emailController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    passportController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));

    addressController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));

    dobController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    expiryController = AnimationController(
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
    phoneAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
          parent: phoneController,
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
    passportAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
          parent: passportController,
          curve: Curves.easeIn,
        ));
    addressAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
          parent: addressController,
          curve: Curves.easeIn,
        ));
    animationController.forward();

    //listener
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
    passportController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        passportController.reverse();
      }
      if (status == AnimationStatus.dismissed && passportCounter < 2) {
        passportController.forward();
        passportCounter++;
      }
    });
    addressController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        addressController.reverse();
      }
      if (status == AnimationStatus.dismissed && addressCounter < 2) {
        addressController.forward();
        addressCounter++;
      }
    });
  }


  // Future<void> initPlatformState() async {
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     await CcAvenue.cCAvenueInit(
  //         transUrl: 'https://secure.ccavenue.com/transaction/initTrans',
  //         accessCode: '4YRUXLSRO20O8NIH',
  //         amount: '10',
  //         cancelUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
  //         currencyType: 'INR',
  //         merchantId: '2',
  //         orderId: '6401ce6c913789806d34a7fd',
  //         redirectUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
  //         rsaKeyUrl: 'https://secure.ccavenue.com/transaction/jsp/GetRSA.jsp');
  //   } on PlatformException {
  //     log('PlatformException');
  //   }
  // }

  void createVisaOrderccAvenue(visaOrderId) async {

print(visaOrderId);

    var res = await http.post(
      Uri.parse(
          "https://secure.mytravellerschoice.com/api/v1/visa/application/initiate/$visaOrderId"),
      body: {
        "paymentProcessor": "ccavenue"
      },
    );
    log('Body Data:${res.body}');

    //todo

    if (res.statusCode == 200) {

      log('Response cc:${res.body}');
      var visaPaymentData = res.body;
      log('Payment data:$visaPaymentData');
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (context) => PaymentCCVisa(visaPaymentData: visaPaymentData),
        ),
      );
    } else {
      var jsondata = jsonDecode(res.body);
      log(jsondata['error']);
      print(jsondata['error']);
      //snackbar
      CustomSnackbar.show(
        context: context,
        message: jsondata['error'],
        backgroundColor: Color(0xff1529e8),
        duration: Duration(seconds: 2),
      );
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(jsondata['error'])));
      return null;
    }
  }

  String? validateFirstName(String? text) {
    if (text == null || text.isEmpty) {
      firstnameController.forward();
      return "Please enter first name";
    }
    return null;
  }
  String? validateFromDate(String? text) {
    if (text == null || text.isEmpty) {
      firstnameController.forward();
      return "Please select date";
    }
    return null;
  } String? validateToDate(String? text) {
    if (text == null || text.isEmpty) {
      firstnameController.forward();
      return "Please select date";
    }
    return null;
  }


  String? validateLastName(String? text) {
    if (text == null || text.isEmpty) {
      lastnameController.forward();
      return "Please enter Last name";
    }
    return null;
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

  String? validatePhone(String? text) {
    if (text == null || text.isEmpty) {
      phoneController.forward();
      return "Please enter Phone Number";
    } else if (FxStringValidator.isPhone(text)) {
      phoneController.forward();
      return "Please enter valid Number";
    }
    return null;
  }

  String? validatePassport(String? text) {
    if (text == null || text.isEmpty) {
      passportController.forward();
      return "Please enter Passport Number";
    } else if (FxStringValidator.isPassport(text)) {
      passportController.forward();
      return "Enter min 1 alphabet & Number";
    }
    return null;
  }

  String? validateAddress(String? text) {
    if (text == null || text.isEmpty) {
      addressController.forward();
      return "Please enter Address";
    } else if (FxStringValidator.validateStringRange(text)) {
      addressController.forward();
      return "Please enter valid Address";
    }
    return null;
  }
  String? validateDOB(String? text) {
    if (text == null || text.isEmpty) {
      dobController.forward();
      return "Please choose date";
    }
    return null;
  }

 String? validateCountry(String? text){
    if(text == null || text.isEmpty){
      return "Please Choose Nationality";
    }
 }

  String? validateExpiry(String? text) {
    if (text == null || text.isEmpty) {
      expiryController.forward();
      return "Please choose date";
    }
    return null;
  }

  void fetchData() async {
    products = HotelTravelCache.products;
    // calculateBilling();
    // showLoading = false;
    // uiLoading = false;
    update();
  }


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
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(res.body),
      //   ),
      // );
      CustomSnackbar.show(
        context: context,
        message: res.body,
        backgroundColor: Color(0xff1529e8),
        duration: Duration(seconds: 2),
      );
    }
  }



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
  //   calculateBilling();
  //   update();
  // }

  // void decrement(Product product) {
  //   if (!decreaseAble(product)) return;
  //   product.person--;
  //   calculateBilling();
  //   update();
  // }

  // void calculateBilling() {
  //   order = 0;
  //   for (Product product in products!) {
  //     order = order + (product.price * product.person);
  //   }

  //   total = order + tax - offer;
  // }

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


  // void toggleFavorite() {
  //   product.favorite = !product.favorite;
  //   update();
  // }

  // Future<void> bookNow() async {
  //   animationController.forward();
  //   await Future.delayed(const Duration(seconds: 1));
  //   Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
  //       transitionDuration: const Duration(milliseconds: 500),
  //       transitionsBuilder: (
  //           BuildContext context,
  //           Animation<double> animation,
  //           Animation<double> secondaryAnimation,
  //           Widget child,
  //           ) =>
  //           FadeTransition(
  //             opacity: animation,
  //             child: child,
  //           ),
  //       pageBuilder: (_, __, ___) => const CheckOutScreen()));
  // }

  void goBack() {
    Navigator.pop(context);
  }
  void selectPaymentMethod(int method) {
    paymentMethodSelected = method;
    update();
  }

  void selectSize(String size) {
    selectedSize = size;
    update();
  }

  // void fetchData() async {
  //   log('fetch data');
  //   products = HotelTravelCache.products;
  //   log(products!.length.toString());
  // }

  void fetchloader() async {
    await Future.delayed(const Duration(seconds: 4));

    uiLoading = false;
    log('fetchloader');
    log(uiLoading.toString());
    update();
  }

  Future<void> goToCheckout() async {
    /*Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => CheckOutScreen(),
      ),
    );*/
  }

  // void goToSingleProduct(Product product) {
  //   Navigator.of(context, rootNavigator: true).push(
  //     MaterialPageRoute(
  //       builder: (context) => SingleProductScreen(product),
  //     ),
  //   );
  // }
  nextPage() async {
    if (currentPage == numPages) {
      /*   Navigator.push(
          context, MaterialPageRoute(builder: (context) => FullApp()));*/
    } else {
      await pageController.animateToPage(
        currentPage + 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    }
  }

  openGateway(String orderId) {
    log('OrderId:$orderId');
    // log('key:${razorCredentials.keyId}');
    var options = {
      "key": razorCredentials.keyId,
      "amount": 10000, //in the smallest currency sub-unit.
      "name": "Acme Corp.",
      "order_id": orderId, // Generate order_id using Orders API
      "description": "Visa",
      "timeout": 60 * 5, // in seconds // 5 minutes
      "prefill": {
        "contact": "7894561234",
        "email": "abrar@gmail.com",
      }
    };
    // _razorpay.open(options);
    // var datavalue = jsonEncode(options);
    // Map<String, dynamic> map = options;
    try {
      // log('Options:$datavalue');

      // _razorpay.open(datavalue);
      log('Options:$options');
      _razorpay.open(options);
      //todo
      // log('Options:$map');
      // _razorpay.open(map);
    } catch (e) {
      print('razor error:${e.toString()}');
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
    addressController.dispose();
    phoneController.dispose();
    dobController.dispose();
    expiryController.dispose();
    animationController.dispose();
    _razorpay.clear();

    super.dispose();
  }


  // Future<void> createVisa() async {
  //
  //
  //     await AuthController()
  //         .register(nameTE.text, emailTE.text, selectedCountryCode.toString(),
  //         phoneTE.text, passwordTE.text, context)
  //         .then((value) {
  //     });
  //   }
  Future<CreateVisaApplication> postCreateVisa(
    Map map
      ) async {
    try {
      var data = await VisaService()
          .postCreateVisa(map,

      );
      if (data != null) {
        // log(data);
        return data;
      } else {
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<VisaDocumentUpload?> postDocumentUpload(
      {required File image1, required File image2, required File image3,required File image4,required File image5, String? id}
      ) async {
    try {
      var data = await VisaService()
          .postVisaDocumentUpload( image1, image2, image3, image4, image5,

      );
      if (data != null) {
        // log(data);
        return data;
      } else {
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  String getTag() {
    return "checkout_controller";
  }


  // uploadFile(List<File> files) async {
  //
  //   var postUri = Uri.parse("url here");
  //   var request =  http.MultipartRequest("POST", postUri);
  //   request.fields['user'] = 'blah';
  //   files.forEach((file) async{
  //     request.files.add( http.MultipartFile.fromBytes('file', await File.fromUri(Uri.file(file.path)).readAsBytes(),));
  //
  //   });
  //
  //   request.send().then((response) {
  //     if (response.statusCode == 200) print("Uploaded!");
  //   });
  // }
}

