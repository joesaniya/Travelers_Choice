import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../card_widgets/customsnackbar.dart';
import '../models/Slot_Time.dart';
import '../models/all_attraction_modal.dart';
import '../models/atteraction_model.dart';
import '../../controllers/attraction_Controller.dart';
import '../models/slot_pick.dart';
import '../services/Slot_Time_Service.dart';
import '../views/checkout_screen.dart';
import '../views/detail_screen/review_Screen.dart';
import '../views/login_Screens/login_screen.dart';
import '../views/new_cart.dart';

List<TextEditingController> controllerTE = [];

class DetailController extends FxController {
  TickerProvider ticker;
  DetailController(this.ticker);

  List<DetailattractionModal>? detailattraction;
  bool showLoading = true, uiLoading = true;

  //tab
  late TabController tabController;
  late ScrollController scrollController;
  //

//  late  Product product;
  // late DetailattractionModal product;

  late AnimationController animationController, cartController, dateController;
  late Animation<Color?> colorAnimation;
  late Animation<double> sizeAnimation,
      cartAnimation,
      paddingAnimation,
      fadeAnimation;
  late Animation<Offset> animation, dateAnimation;
  int dateCounter = 0;
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0, numPages = 3;
  late Timer timerAnimation;
  late TextEditingController dateTE;

  bool isFav = false;
  bool addCart = false;

  late List<String> sizes;
  String selectedSize = 'M';
  GlobalKey<ScaffoldState> snackkey = GlobalKey();

  // List<Product>? products;
  late double order, tax = 30, offer = 50, total;

  String? selectedtransfer;
  List<String> TransferCodes = ['without', 'private', 'shared'];
  final List<String> SharedwithoutCodes = [
    'without',
    'private',
  ];
  final List<String> withoutPrivateCodes = ['without', 'shared'];
  final List<String> withoutcodes = ['without'];

  String? SelectedwithoutSharedCodes;
  String? SelectedwithoutPrivateCodes;

  double? adultTotalPrice;

  // int person_count = 1;
  List<Activity> person_count = [];
  List<Map<String, dynamic>> child_count = [];
  List<Activity> selectedtour = [];

  double grandTotal = 0;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  SlotTime? selectedslot;

  List<CustomSlots> slottimeget = [];

  List<SlotTime> timeSlotList = [];

  CustomSlots? customSlots;
  List<List<String>> itemValue = [];
  List<DropdownMenuItem<String>> AdropDownItem(index) {
    return itemValue[index]
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value.toString()),
            ))
        .toList();
  }

  bool isChecked = false;

  var checkedResult = 'Checkbox is CHECKED';

  void toggleCheckbox(bool value) {
    if (isChecked == false) {
      // Put your code here which you want to execute on CheckBox Checked event.

      isChecked = true;
      checkedResult = 'Checkbox is CHECKED';
      update();
    } else {
      // Put your code here which you want to execute on CheckBox Un-Checked event.

      isChecked = false;
      checkedResult = 'Checkbox is UN-CHECKED';
      update();
    }
  }

  //
  List<SlotTime> listSLotDetails = <SlotTime>[];
  BaseOptions options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 15000),
      receiveTimeout: const Duration(milliseconds: 15000));
  final dio = Dio();

  Future<List<SlotTime>> processGetTimeSlot(String productId,
      String productCode, String date, String activityId) async {
    try {
      log("Activity Id:$activityId");
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

  Future<List<SlotTime>?> SlotPick(String productid, String productcode,
      String date, String activityId) async {
    log('product Id:$productid');
    log('product code:$productcode');
    log('date:$date');
    log("Activity Id:$activityId");

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
        amount = amount + (tour.grandTotal);
        log('amountgrandSelectedTourAmount() transfer:$amount');
      } else if (tour.privateTransfers!.isEmpty) {
        log('no transfers');
        amount = amount + (tour.grandTotal);
      } else {
        // amount =
        //     amount + (tour.grandTotal + tour.privateTransfers!.first.price);
        amount = amount + (tour.grandTotal);
        log('amountgrandSelectedTourAmount():$amount');
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

//adultincrement
  void personCountFn(Activity tour,
      {bool isAdult = false,
      bool isChild = false,
      bool isInfant = false,
      bool isIncrement = false}) {
    List<Activity> value =
        person_count.where((element) => element.sId == tour.sId).toList();

    if (tour.transferCode != null) {
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
      if (value.isNotEmpty) {
        int index = person_count.indexOf(value[0]);
        double val = getGrandTotal(person_count[index]);
        person_count[index].grandTotal = val;
        print('List Value=> ${person_count.length}');
      }
    } else {
      CustomSnackbar.show(
        context: context,
        message: 'Please Select Your Transfer Type',
        backgroundColor: const Color(0xff1529e8),
        duration: const Duration(seconds: 2),
      );
    }
    update();
  }

  getTotal(Activity tour) {
    List<Activity> value =
        person_count.where((element) => element.sId == tour.sId).toList();
    log('Tour Value==>$value');
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
      log('if Adult Price:${tour.adultPrice}');
      log('if Adult cost:${tour.adultCost}');
      // log('if transfer:${tour.privateTransfers!.first.toJson()}');
      List<PrivateTransfers>? private =
          tour.privateTransfers!.where((element) => element.isActive).toList();
      return tour.adultPrice == null
          ? private.isEmpty
              ? tour.adultCost
              : private[0].price
          : tour.adultPrice!.toDouble();
      // return tour.adultPrice == null
      //     // ? tour.privateTransfers!.first.price
      //     ? tour.privateTransfers == null || tour.privateTransfers!.isEmpty
      //         ? tour.adultCost
      //         : tour.privateTransfers!.first.price
      //     : tour.adultPrice!.toDouble();
    } else {
      log('Else value ${value[0].toJson()}');
      List<PrivateTransfers>? private =
          tour.privateTransfers!.where((element) => element.isActive).toList();
      // return (value[0].adultCount * (value[0].adultPrice ?? private[0].price)) +
      //     (value[0].childCount * (value[0].childPrice ?? private[0].price)) +
      //     (value[0].infantCount * (value[0].infantPrice ?? private[0].price));

      if (private.isNotEmpty && tour.activityType == 'transfer') {
        log("Remainder Value => ${(tour.adultCount + tour.childCount).remainder(private[0].maxCapacity!)}");
        log("Remainder Value / => ${(tour.adultCount + tour.childCount) / private[0].maxCapacity!}");
        log("Remainder Value ceil => ${((tour.adultCount + tour.childCount) / private[0].maxCapacity!).ceil()}");
        log("Remainder Value Round => ${((tour.adultCount + tour.childCount) / private[0].maxCapacity!).round()}");
        return private[0].price *
            (((tour.adultCount + tour.childCount) / private[0].maxCapacity!)
                .ceil());
      }
      return (value[0].adultCount *
              (value[0].adultPrice ?? value[0].adultCost)) +
          (value[0].childCount * (value[0].childPrice ?? value[0].adultCost)) +
          (value[0].infantCount * (value[0].infantPrice ?? value[0].adultCost));
      // return (value[0].adultCount * (value[0].adultPrice ?? 1.0)) +
      //     (value[0].childCount * (value[0].childPrice ?? 1.0)) +
      //     (value[0].infantCount * (value[0].infantPrice ?? 1.0));
    }
  }

  addisPrivateORsharing(Activity tour,
      {bool isPrivate = false, bool isSharing = false}) {
    List<Activity> value =
        person_count.where((element) => element.sId == tour.sId).toList();
    if (value.isEmpty) {
      personCountFn(tour, isAdult: true);
    } else {
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

  double getGrandTotal(Activity tour) {
    log(getTotal(tour).toString());
    log('person Count:${person_count.map((e) => e.adultCount)}');

    List<Activity> value =
        person_count.where((element) => element.sId == tour.sId).toList();
    log("Current Tour => ${value.length}");
    if (value.isEmpty) {
    } else {
      tour = value[0];
    }
    // double amount = double.parse(getTotal(tour).toString());
    double amount = double.parse(getTotal(tour).toString()) -
        (isChecked == true
            ? (tour.promoAmount == null)
                ? 0
                : tour.promoAmount!
            : 0);
    log('Get:$amount');

    if (tour.transferCode != null && tour.transferCode == "private") {
      // amount = amount + tour.privateTransferPrice!;//added transfer fee
      List<PrivateTransfers>? private =
          tour.privateTransfers!.where((element) => element.isActive).toList();

      // amount = amount +
      //     (tour.activityType == 'transfer'
      //         ? 0
      //         : (private.isNotEmpty ? private[0].price : 0));
      amount = amount +
          (tour.activityType == 'transfer'
              ? 0
              : (private.isNotEmpty ? private[0].price : 0)) -
          (isChecked == true
              ? (tour.promoAmount == null)
                  ? 0
                  : tour.promoAmount!
              : 0);
      // (tour.promoAmount!.toInt()) : 0);
      log("Promo Code Transfer => ${tour.promoAmount}");
      log(" Private Amount => $amount");

      log('Grand Total Privat:$amount');
    }
    if (tour.transferCode != null && tour.transferCode == "shared") {
      // amount = amount + tour.sharedTransferPrice!;
      // amount = amount +
      //     double.parse(
      //         (tour.sharedTransferPrice ?? 0).toString()); //added transfer fee
      amount = amount +
          double.parse((tour.sharedTransferPrice ?? 0).toString()) -
          (isChecked == true
              ? (tour.promoAmount == null)
                  ? 0
                  : tour.promoAmount!
              : 0);
      // (isChecked == true ? (tour.promoAmount!.toInt()) : 0);
      log("Promo Code Shared => ${tour.promoAmount}");
      log('Grand Total sharing:$amount');
    }
    log("Current Grand Total => $amount");
    update();
    return amount;
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

  late AnimationController fadeController;

  void fetchData() async {
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
    tabController = TabController(length: 4, vsync: ticker);
    scrollController = ScrollController(initialScrollOffset: 0.0);
    scrollController.addListener(() {
      changeAppBarColor(scrollController);
      // if (favs.isEmpty) {
      //   SharedPreferences.getInstance().then((prefs) {
      //     if (prefs.getStringList("favs") != null) {
      //       favs.addAll(prefs.getStringList("favs")!.toList());
      //     }
      //      final mealId = ModalRoute.of(context).settings.arguments as String;
      //     final selectedMeal =
      //         allattractionList.firstWhere((Meal) => Meal.id == mealId);
      //     favs = widget.toggleFavourite(mealId);
      //     // setState(() {
      //     //   final mealId = ModalRoute.of(context).settings.arguments as String;
      //     //   final selectedMeal =
      //     //     allattractionList.firstWhere((Meal) => Meal.id == mealId);
      //     //   favs = widget.toggleFavourite(mealId);
      //     // });
      //   });
      // }
    });
    // scrollController.hasClients(() {
    //   changeAppBarColor(scrollController);
    // });
    //
    dateTE = TextEditingController();
    save = false;
    // fetchData();
    dateController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    timerAnimation = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (currentPage < numPages - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.ease,
      );
    });
    dateAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: dateController,
      curve: Curves.easeIn,
    ));

    animationController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));

    cartController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));

    colorAnimation =
        ColorTween(begin: const Color(0xff1529e8), end: const Color(0xff1529e8)
                // end: const Color(0xff1c8c8c)
                )
            .animate(animationController);
    animation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(15, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 24, end: 28), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 28, end: 24), weight: 50)
    ]).animate(animationController);
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

    paddingAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 16, end: 14), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 14, end: 16), weight: 50)
    ]).animate(cartController);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isFav = true;
        update();
      }
      if (status == AnimationStatus.dismissed) {
        isFav = false;
        update();
      }
    });

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

    dateController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        dateController.reverse();
      }
      if (status == AnimationStatus.dismissed && dateCounter < 2) {
        dateController.forward();
        dateCounter++;
      }
    });
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

    cartController.dispose();

    pageController.dispose();
    timerAnimation.cancel();
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

  Future<void> BottomgoToCheckout1(dynamic lengthData, List<Activity> Option,
      String? textdate, String? Transfer, double? totalAmount) async {
    await Future.delayed(const Duration(seconds: 1));
    log('slot checkout');

    // log(selectedtour.length.toString());
    // log(selectedtour.first.name.toString());
    // log(selectedtour.first.adultCount.toString());
    log('Length:$lengthData');
    log('Selected Tour:$Option');

    log('Selected Transfer$Transfer');

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
        pageBuilder: (_, __, ___) =>
            CheckOutScreen(lengthData, Option, textdate!, Transfer, totalAmount
                // customSlots!.event,
                )));
  }

  Future<void> goToCheckout1() async {
    await Future.delayed(const Duration(seconds: 1));
    log('slot checkout');

    // log(selectedtour.length.toString());
    // log(selectedtour.first.name.toString());
    // log(selectedtour.first.adultCount.toString());
    log('Length:${selectedtour.length}');
    log('Selected Tour:$selectedtour');
    // log('Dates:${dateTE.text}');
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

  Future<void> goToCheckout(BuildContext context, String pid) async {
    // log('SLots Checkout:${selectedtour.first.customSlots!.slots!.first.endDateTime}');
    // log('SLots Checkout:${selectedtour.first.event!.eventName}');
    await Future.delayed(const Duration(seconds: 1));
    if (selectedtour.isEmpty) {
      CustomSnackbar.show(
        context: context,
        message: 'Select Your Tour Option',
        backgroundColor: const Color(0xff1529e8),
        duration: const Duration(seconds: 2),
      );
    }
    // else if (pid == '63ff12f5d7333637a938cad4' &&
    //         detailattraction!
    //                 .map((e) =>
    //                     e.activities!.map((e) => e.activityTimeSlot == null))
    //                 .toList() ==
    //             null
    //     // detailattraction![i].activities![i].activityTimeSlot == null
    //     ) {
    //   log('else');
    //   CustomSnackbar.show(
    //     context: context,
    //     message: 'Select Your Slot Time',
    //     backgroundColor: const Color(0xff1529e8),
    //     duration: const Duration(seconds: 2),
    //   );
    // }
    else {
      // log(selectedtour.length.toString());
      // log(selectedtour.first.name.toString());
      // log(selectedtour.first.adultCount.toString());
      // print(selectedtour.length);
      // print(selectedtour);
      // print(dateTE.text);
      // print(selectedtransfer);
      log('Length:${selectedtour.length}');
      log('Selected Tour:$selectedtour');
      // log('Dates:${dateTE.text}');
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
  //

  String? currencies, countryCode;

  String? currency() {
    if (currencies != null) {
      List<dynamic> countriesList = jsonDecode(currencies ?? "");
      String? isoCode;

      log("Country list => $countriesList");
      print('''
Country Code => $countryCode
''');
      for (var val in countriesList) {
        if (val['country']['_id'] == countryCode) {
          isoCode = val['isocode'];
          break;
        }
      }
      return isoCode;
    }
    return null;
  }

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

  getDetailAttraction(productid, productslug, setState) {
    log('getDetail Attraction function called');

    Future.delayed(Duration.zero, () async {
      await AttractionController()
          .getDetailattractionList(
              productid: productid, productslug: productslug)
          .then((value) {
        log('Details => $value');
        if (value != null) {
          isLoading = false;
          detailattraction = [];
          // detailattraction = value;
          setState(() {
            detailattraction = value;
          });
        }
      });
    });
  }

  showFAB(TabController tabController) {
    int reviewTabIndex = 2;
    if (tabController.index == reviewTabIndex) {
      return true;
    }
    return false;
  }

  List<String> favs = [];
  List<AllattractionModal> allattractionList = <AllattractionModal>[];

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

  // void toggleFavorite() {
  //   product.favorite = !product.favorite;
  //   update();
  // }

  // Future<void> bookNow(DetailattractionModal excursions, String eid) async {
  //   animationController.forward();
  //   log('Product Id:$eid');
  //   await Future.delayed(const Duration(seconds: 1));
  //   Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
  //       transitionDuration: const Duration(microseconds: 0
  //           // milliseconds: 500
  //           ),
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
  //       pageBuilder: (_, __, ___) => ActivityScreen(excursions.activities!, eid)
  //       // ActivityScreen(
  //       //   Excursions: widget.detailattraction
  //       //   )
  //       ));
  // }

  //revie
  Future<void> REviewPage(
      // DetailattractionModal review
      String id) async {
    animationController.forward();
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
        pageBuilder: (_, __, ___) => ReviewScreen(
            Id: id,
            // reviews: review.reviews
            rating: detailattraction!.first.averageRating,
            TotalRatingCount: detailattraction!.first.totalRating)
        // ActivityScreen(
        //   Excursions: widget.detailattraction
        //   )
        ));
  }

  // void goToSingleProduct(Datum product) {
  //   log(product.id);
  //   log('message');
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
  //       pageBuilder: (_, __, ___) => DetailScreen(product.id)
  //       // SingleProductScreen(product.id)
  //       ));
  // }

  // void fetchData() async {
  //   log('fetch data');
  //   products = HotelTravelCache.products;
  //   log(products!.length.toString());
  // }

  @override
  String getTag() {
    return "Detail_controller";
  }
}
