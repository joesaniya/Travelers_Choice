import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
// import 'package:global_snack_bar/global_snack_bar.dart';
import 'package:hotel_travel/models/atteraction_model.dart';
import 'package:hotel_travel/views/new_cart.dart';
import 'package:intl/intl.dart';
import '../card_widgets/customsnackbar.dart';
import '../models/Slot_Time.dart';
import '../models/cart.dart';
import '../models/slot_pick.dart';
import '../services/Slot_Time_Service.dart';
import '../views/checkout_screen.dart';
import '../views/hotel_travel_constants.dart';
import '../views/login_Screens/login_screen.dart';
import 'package:http/http.dart' as http;

List<TextEditingController> controllerTE = [];
// double amount = 0;

class ActivityController extends FxController {
  TickerProvider ticker;
  ActivityController(this.ticker);
  bool showLoading = true, uiLoading = true;
  final List<String> TransferCodes = ['Without Transfer', 'private', 'shared'];
  final List<String> SharedwithoutCodes = [
    'without',
    'private',
  ];
  final List<String> withoutPrivateCodes = ['without', 'shared'];
  final List<String> withoutcodes = ['without'];

  String? selectedtransfer;
  String? SelectedwithoutSharedCodes;
  String? SelectedwithoutPrivateCodes;
  bool addCart = false;
  double? adultTotalPrice;
  List<Cart>? carts;

  // int person_count = 1;
  List<Activity> person_count = [];
  List<Map<String, dynamic>> child_count = [];
  List<Activity> selectedtour = [];
  double grandTotal = 0;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  SlotTime? selectedslot;

  List<CustomSlots> slottimeget = [];

  CustomSlots? customSlots;

  // List<SlotTime> events = [];
  // Dio? dio;
  BaseOptions options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 15000),
      receiveTimeout: const Duration(milliseconds: 15000));
  final dio = Dio();

  Future<List<SlotTime>> processGetTimeSlot(
      String productId, String productCode, String date) async {
    try {
      print("time Slot api hit");
      var response = await dio.post(
        'https://a.walletbot.online/api/v1/attractions/timeslot',
        data: {
          "productId": productId,
          "productCode": productCode,
          "timeSlotDate": date
        },
        options: Options(headers: {
          // "Authorization": token
          'Content-Type': 'application/json',
        }),
      );
      log("time Slot ${response.data}");

      if (response.statusCode == 200) {
        List res = response.data;

        List<SlotTime> timeSlotList = [];

        for (var element in res) {
          String str = json.encode(element);

          var timeResponse = SlotTime.fromJson(json.decode(str));
          timeSlotList.add(timeResponse);
        }

        print("RRRRRRR ${response.data.runtimeType}");

        return timeSlotList;
      } else {
        var jsondata = jsonDecode(response.data);
        log(jsondata['error']);
        return [];
      }
    } catch (error) {
      print("erorrr $error");
      rethrow;
    }
  }

  Future<List<SlotTime>?> SlotPick(
    String productid,
    String productcode,
    String date,
  ) async {
    log('product Id:$productid');
    log('product code:$productcode');
    log('date:$date');

    try {
      List<SlotTime> slots;
      var data = await SlotTimeService()
          // .getSlotTime(productid, productcode, date, context);
          .getSlotTime1(productid, productcode, date, context);

      if (data != null) {
        // slottimeget.add(data);
        // var slots = slotTimeFromJson(data);

        CustomSlots currentSlot = CustomSlots(id: productid, slots: data);
        if (slottimeget.contains(currentSlot)) {
          int index = slottimeget.indexOf(currentSlot);
          slottimeget[index].slots = data;

          slots = slottimeget[index].slots!;
        } else {
          log('slot length 1:$slottimeget');
          // slottimeget[0].id = productid;
          // slottimeget[0].slots = [];
          // slottimeget[0].slots!.addAll(data);
          slottimeget.add(currentSlot);
          log('slot length 2:$slottimeget');
          log('Slots:$slottimeget');
          log('Slot Ebentname:${slottimeget[0].slots!.map((e) => e.eventName).toList()}');
          slots = slottimeget[0].slots!;
        }

        return slots; //removed true
      } else {
        return null; //falseremoved
      }
    } catch (e) {
      rethrow;
    }
  }

  void listPickSlot(
    String productid,
    String productcode,
    String date,
  ) async {
    log('calling');
    {
      var response = await http.post(
          Uri.parse("http://servisjer.me-tech.com.my/api/Car/GetUserCar"),
          body: ({
            "productId": productid,
            "productCode": productcode,
            "timeSlotDate": date
          }));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        log('list Pick:$body');
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Successfully Login")));
      }
    }
  }

  //slotsupdate
  // void updateTourSlot(SlotTime tour) {
  void updateTourSlot(Activity tour) {
    log('updateTourSlot calling');
    // log('Selected Tour Date:${tour.selectedDate}');
    log('Name Event:${tour.slotsdata}');

    // List<SlotTime> value =
    //     slottimeget.where((element) => element.eventId == tour.eventId).toList();
    // print("Coutn => ${value.length}");
    // if (value.isEmpty) {
    //   double val = getGrandTotalSlots(tour);
    //   tour.grandTotal = val;
    //   log('Value Total:$val');

    //   if (selectedtour.contains(tour)) {
    //     selectedtour.remove(tour);
    //   } else {
    //     tour.grandTotal = tour.adultCount!.toDouble();
    //     // tour.grandTotal = tour.adultPrice!.toDouble();
    //     selectedtour.add(tour);
    //   }
    // } else {
    //   int index = person_count.indexOf(value[0]);
    //   double val = getGrandTotal(person_count[index]);
    //   person_count[index].grandTotal = val;
    //   if (selectedtour.contains(person_count[index])) {
    //     selectedtour.remove(person_count[index]);
    //   } else {
    //     selectedtour.add(person_count[index]);
    //   }

    //   print(person_count[index].grandTotal);
    // }
    // // log('Select:${selectedtour.map((e) => e.selectedDate)}');
    // update();
  }

  void updateTours(Activity tour) {
    log('updateTours Calling');
    // log('Selected Tour Date:${tour.selectedDate}');

    List<Activity> value =
        person_count.where((element) => element.sId == tour.sId).toList();
    print("Coutn => ${value.length}");
    if (value.isEmpty) {
      double val = getGrandTotal(tour);
      tour.grandTotal = val;
      log('Value Total:$val');

      if (selectedtour.contains(tour)) {
        selectedtour.remove(tour);
      }
      // else if (tour.activityType == 'transfer') {
      //   if (person_count.length <=
      //       tour.privateTransfers!.first.maxCapacity!.toInt()) {
      //     log('length:${person_count.length}');
      //     log('low Price transfer:${tour.lowPrice}');
      //     tour.grandTotal = tour.lowPrice!.toDouble();
      //     // tour.grandTotal = tour.adultPrice!.toDouble();
      //     selectedtour.add(tour);
      //   }
      //   // if (tour.privateTransfers!.map((e) => e.maxCapacity).toList() ==
      //   //     value) {
      //   //   log('transfer adult count:');
      //   // } else if (tour.privateTransfers!.map((e) => e.maxCapacity).toList() ==
      //   //     value.map((e) => e.childCount).toList()) {}
      // }
      else {
        log('low Price:${tour.lowPrice}');
        tour.grandTotal = tour.lowPrice!.toDouble();
        // tour.grandTotal = tour.adultPrice!.toDouble();
        selectedtour.add(tour);
      }
    } else {
      int index = person_count.indexOf(value[0]);
      double val = getGrandTotal(person_count[index]);
      person_count[index].grandTotal = val;
      if (selectedtour.contains(person_count[index])) {
        selectedtour.remove(person_count[index]);
      } else {
        selectedtour.add(person_count[index]);
      }

      log('Person count Grand Total:${person_count[index].grandTotal}');
    }
    // log('Select:${selectedtour.map((e) => e.selectedDate)}');
    update();
  }

  grandSelectedTourAmount() {
    double amount = 0;
    // double privateamount = 0;

    for (Activity tour in selectedtour) {
      log('tour.grandTotal:${tour.grandTotal}');
      // var Estheramount =
      //     tour.adultCount / tour.privateTransfers!.first.maxCapacity!.toInt();
      // log('Esther:$Estheramount');
      // var totalmembercount = Estheramount.toInt();
      // log('totalmembercount:$totalmembercount');

      // amount = membercount * tour.totalAmount;
      // log('Amount Transfer:$amount');
      if (tour.activityType == 'transfer') {
        // // if(tour.privateTransfers!.first.maxCapacity<!tour.adultCount)
        // if(tour.adultCount/)
        // {

        // }
        // log('Esther1:${Estheramount.toInt()}');
        log('activity type');
      } else if (tour.privateTransfers!.isEmpty) {
        log('no transfers');
        amount = amount + (tour.grandTotal);
      } else {
        // amount =
        //     amount + (tour.grandTotal + tour.privateTransfers!.first.price);
        amount = amount + (tour.grandTotal);
        log('amount:$amount');
      }
      // amount = amount + (tour.grandTotal + tour.privateTransfers!.first.price);
      // // amount = amount + (tour.grandTotal);
      // log('amount:$amount');
    }

    return amount;
    // update();
    // log('Amount:$amount');
  }

  // double amount = 0;

  // grandSelectedTourAmount() {
  //   double amount = 0;

  //   for (Activity tour in selectedtour) {
  //     log('tour.grandTotal:${tour.grandTotal}');
  //     if (tour.privateTransfers!.isEmpty) {
  //       log('no transfers');
  //       amount = amount + (tour.grandTotal);
  //     } else {
  //       // amount =
  //       //     amount + (tour.grandTotal + tour.privateTransfers!.first.price);
  //       amount = amount + (tour.grandTotal);
  //       log('amount:$amount');
  //     }
  //     // amount = amount + (tour.grandTotal + tour.privateTransfers!.first.price);
  //     // // amount = amount + (tour.grandTotal);
  //     // log('amount:$amount');
  //   }

  //   return amount;
  //   // update();
  //   // log('Amount:$amount');
  // }

  void Total(Activity tour) {}

  //todo
  void incrementperson(personCount) {
    if (!increaseAble(personCount)) return;
    personCount++;
    // calculateBilling();
    update();
  }

  bool increaseAble1(personCount) {
    return personCount;
  }

  //
  bool increaseAble(Activity cart) {
    // return cart.person < cart.product.person;
    return true;
  }

  bool decreaseAble(Cart cart) {
    return cart.person > 1;
  }

//adultincrement
  void personCountFn(Activity tour,
      {bool isAdult = false,
      bool isChild = false,
      bool isInfant = false,
      bool isIncrement = false}) {
    List<Activity> value =
        person_count.where((element) => element.sId == tour.sId).toList();

    print("Person Count Added=-> $value");
    if (value.isEmpty) {
      if (isAdult) {
        isIncrement
            ? tour.adultCount++
            : (tour.adultCount != 1)
                ? tour.adultCount--
                : 1;
      }
      if (isChild) {
        isIncrement
            ? tour.childCount++
            : (tour.childCount != 1)
                ? tour.childCount--
                : 1;
      }
      if (isInfant) {
        isIncrement
            ? tour.infantCount++
            : (tour.infantCount != 1)
                ? tour.infantCount--
                : 1;
      }
      double val = getGrandTotal(tour);
      tour.grandTotal = val;
      person_count.add(tour);
    } else {
      int index = person_count.indexOf(value[0]);

      if (isAdult) {
        isIncrement
            ? person_count[index].adultCount++
            : (person_count[index].adultCount != 1)
                ? person_count[index].adultCount--
                : 1;
      }
      if (isChild) {
        isIncrement
            ? person_count[index].childCount++
            : (person_count[index].childCount != 0)
                ? person_count[index].childCount--
                : 0;
      }
      if (isInfant) {
        isIncrement
            ? person_count[index].infantCount++
            : (person_count[index].infantCount != 0)
                ? person_count[index].infantCount--
                : 0;
      }
    }
    int index = person_count.indexOf(value[0]);
    double val = getGrandTotal(person_count[index]);
    person_count[index].grandTotal = val;
    print('List Value=> ${person_count.length}');
    update();
  }

  getTotal(Activity tour) {
    List<Activity> value =
        person_count.where((element) => element.sId == tour.sId).toList();
    if (value.isEmpty) {
      log('adult:${tour.adultCost}');
      log('ticket:${tour.transferPricing}');
      log('qtn:${tour.qtnActivityType}');
      // return tour.adultPrice!.toDouble();//without transfer
      // return tour.adultPrice == null
      //     ? tour.privateTransfers!.first.price
      //     : tour.adultPrice!.toDouble();//added transfer fee+total
      // : tour.privateTransfers!.first.price;
      // log('vec:${tour.ticketPricing.adultPrice}');
      log('adult 2:${tour.adultPrice}');
      log('Pvt:${tour.privateTransfers!.map((e) => e.price).toList()}');
      return tour.adultPrice == null
          // ? tour.privateTransfers!.first.price
          ? tour.privateTransfers == null || tour.privateTransfers!.isEmpty
              ? tour.adultCost
              : tour.privateTransfers!.first.price
          : tour.adultPrice!.toDouble();
    } else {
      return (value[0].adultCount * (value[0].adultPrice ?? 1.0)) +
          (value[0].childCount * (value[0].childPrice ?? 1.0)) +
          (value[0].infantCount * (value[0].infantPrice ?? 1.0));
    }
  }

  addisPrivateORsharing(Activity tour,
      {bool isPrivate = false, bool isSharing = false}) {
    List<Activity> value =
        person_count.where((element) => element.sId == tour.sId).toList();
    if (value.isEmpty) {
      personCountFn(tour, isAdult: true);
      if (isPrivate) {
        person_count[0].isPrivate = true;
        person_count[0].isSharing = false;
      } else if (isSharing) {
        person_count[0].isPrivate = false;
        person_count[0].isSharing = true;
      } else {
        person_count[0].isPrivate = false;
        person_count[0].isSharing = false;
      }
    } else {
      if (isPrivate) {
        value[0].isPrivate = true;
        value[0].isSharing = false;
      } else if (isSharing) {
        value[0].isPrivate = false;
        value[0].isSharing = true;
      } else {
        value[0].isPrivate = false;
        value[0].isSharing = false;
      }
      update();
    }
  }

  int getCounts(String id,
      {bool isAdult = false, bool isChild = false, bool isInfant = false}) {
    List<Activity> value =
        person_count.where((element) => element.sId == id).toList();

    if (value.isEmpty) {
      return isAdult ? 1 : 0;
    } else {
      int index = person_count.indexOf(value[0]);
      if (isAdult) {
        return person_count[index].adultCount;
      } else if (isChild) {
        return person_count[index].childCount;
      } else {
        return person_count[index].infantCount;
      }
    }
  }

  // //slotstotal
  //   double getGrandTotalSlots(SlotTime tour) {
  //   // log(getTotal(tour).toString());

  //   List<SlotTime> value =
  //       slottimeget.where((element) => element.eventId == tour.eventId).toList();
  //   log("Current Tour => ${value.length}");
  //   if (value.isEmpty) {
  //   } else {
  //     tour = value[0];
  //   }
  //   double amount = double.parse(getTotal(tour).toString());

  //   if (tour.isPrivate) {
  //     // amount = amount + tour.privateTransferPrice!;//added transfer fee
  //     amount = amount;
  //     // amount = amount +
  //     //     tour.privateTransferPrice! +
  //     //     tour.privateTransfers!.first.cost!.toDouble();
  //   }
  //   if (tour.isSharing) {
  //     // amount = amount + tour.sharedTransferPrice!;
  //     amount = amount; //added transfer fee
  //   }
  //   log("Current Grand Total => $amount");
  //   return amount;
  //   update();
  // }

  double getGrandTotal(Activity tour) {
    log(getTotal(tour).toString());

    List<Activity> value =
        person_count.where((element) => element.sId == tour.sId).toList();
    log("Current Tour => ${value.length}");
    if (value.isEmpty) {
    } else {
      tour = value[0];
    }
    double amount = double.parse(getTotal(tour).toString());

    if (tour.isPrivate) {
      // amount = amount + tour.privateTransferPrice!;//added transfer fee
      amount = amount;

      // amount = amount +
      //     tour.privateTransferPrice! +
      //     tour.privateTransfers!.first.cost!.toDouble();
      log('Grand Total Privat:$amount');
    }
    if (tour.isSharing) {
      // amount = amount + tour.sharedTransferPrice!;
      amount = amount; //added transfer fee
      log('Grand Total sharing:$amount');
    }
    log("Current Grand Total => $amount");
    return amount;
    update();
  }

  String getCount(String id) {
    String? count;

    return count.toString() == 'null' ? "1" : count.toString();
  }

  String getadultTotalPrice(Activity toursData) {
    String? totalPrice;

    return totalPrice ?? toursData.adultPrice.toString();
  }

  calculateBilling(String id, double adultPrice) {}

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
    // defaultChoiceIndex = -1;
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
    paddingAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 16, end: 14), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 14, end: 16), weight: 50)
    ]).animate(cartController);
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

  int defaultChoiceIndex = -1;

  final List<String> timeslotstart = [
    '10.00 am',
    '11.00 am',
    '12.00 pm',
    '13.00 pm',
    '14.00 pm',
    '15.00 pm',
    '16.00 pm',
    '17.00 pm',
    '18.00 pm'
  ];
  final List<String> timeslotend = [
    '11.00 am',
    '12.00 pm',
    '13.00 pm',
    '14.00 pm',
    '15.00 pm',
    '16.00 pm',
    '17.00 pm',
    '18.00 pm',
    '19.00 pm'
  ];
//drawer
  void openendDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void closeEndDrawer() {
    log('close drawer');
    // scaffoldKey.currentState?.closeEndDrawer();
    Navigator.of(context).pop();
    // scaffoldKey.currentState?.openDrawer();
  }

  void getslot(dynamic result) {
    log('Result:$result');
  }

  dateselect(index) async {
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
      // dateTE.text = formattedDate;
      controllerTE[index].text = formattedDate;

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
    await Future.delayed(const Duration(seconds: 1));

    uiLoading = false;
    log('fetchloader');
    log(uiLoading.toString());
    update();
  }

  void goBack() {
    Navigator.pop(context);
  }

  void Login() {
    log('calling login....');
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      ),
    );
  }

  // Future<void> goToCheckout1() async {
  //   await Future.delayed(const Duration(seconds: 1));
  //
  //   log(selectedtour.length.toString());
  //   log(selectedtour.first.name.toString());
  //   log(selectedtour.first.adultCount.toString());
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
  //       pageBuilder: (_, __, ___) => CheckOutScreen(
  //           selectedtour.length,
  //           selectedtour,
  //           dateTE.text,
  //           selectedtransfer,
  //           grandSelectedTourAmount())));
  // }

  Future<void> goToCheckout1() async {
    await Future.delayed(const Duration(seconds: 1));
    log('slot checkout');

    // log(selectedtour.length.toString());
    // log(selectedtour.first.name.toString());
    // log(selectedtour.first.adultCount.toString());
    log('Length:${selectedtour.length}');
    log('Selected Tour:$selectedtour');
    log('Dates:${dateTE.text}');
    log('Selected Transfer$selectedtransfer');

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
              selectedtour,
              dateTE.text,
              selectedtransfer,
              grandSelectedTourAmount(),
              // customSlots!.event,
            )));
  }

  Future<void> goToCheckout() async {
    // log('SLots Checkout:${selectedtour.first.customSlots!.slots!.first.endDateTime}');
    // log('SLots Checkout:${selectedtour.first.event!.eventName}');
    await Future.delayed(const Duration(seconds: 1));
    if (selectedtour.isEmpty) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("Select Your Tour Option")));
      CustomSnackbar.show(
        context: context,
        message: 'Select Your Tour Option',
        backgroundColor: const Color(0xff1529e8),
        duration: const Duration(seconds: 2),
      );
    } else {
      // log(selectedtour.length.toString());
      // log(selectedtour.first.name.toString());
      // log(selectedtour.first.adultCount.toString());
      // print(selectedtour.length);
      // print(selectedtour);
      // print(dateTE.text);
      // print(selectedtransfer);
      log('Length:${selectedtour.length}');
      log('Selected Tour:$selectedtour');
      log('Dates:${dateTE.text}');
      log('Selected Transfer$selectedtransfer');
      print(grandSelectedTourAmount());
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
          // pageBuilder: (_, __, ___) => AttractionCartPage(
          //     selectedtour.length,
          //     // selectedtours,
          //     selectedtour,
          //     dateTE.text,
          //     selectedtransfer,
          //
          //     // excursions.activities!
          //     // amount
          //     grandSelectedTourAmount())

          pageBuilder: (_, __, ___) => NewCartPage(
                selectedtour.length,
                // selectedtours,
                selectedtour,
                dateTE.text,
                selectedtransfer,

                grandSelectedTourAmount(),
                //  customSlots!.event,
              )

          // CheckOutScreen(
          //     selectedtour.length,
          //     // selectedtours,
          //     selectedtour,
          //     dateTE.text,
          //     selectedtransfer,

          //     // excursions.activities!
          //     // amount
          //     grandSelectedTourAmount())
          ));
    }
  }

  Future<void> goToCheckoutFromCart() async {
    await Future.delayed(const Duration(seconds: 1));
    if (selectedtour.isEmpty) {
      CustomSnackbar.show(
        context: context,
        message: 'Select Your Tour Option',
        backgroundColor: const Color(0xff1529e8),
        duration: const Duration(seconds: 2),
      );
      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("Select Your Tour Option")));
    } else {
      log(selectedtour.length.toString());
      log(selectedtour.first.name.toString());
      log(selectedtour.first.adultCount.toString());
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
          pageBuilder: (_, __, ___) => NewCartPage(
                selectedtour.length,
                // selectedtours,
                selectedtour,
                dateTE.text,
                selectedtransfer,

                // excursions.activities!
                // amount
                grandSelectedTourAmount(),
                // customSlots!.event
              )

          // CheckOutScreen(
          //     selectedtour.length,
          //     // selectedtours,
          //     selectedtour,
          //     dateTE.text,
          //     selectedtransfer,

          //     // excursions.activities!

          //     // amount
          //     grandSelectedTourAmount())
          ));
    }
  }

  @override
  String getTag() {
    return "Activity_controller";
  }
}
