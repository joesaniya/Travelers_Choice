import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:intl/intl.dart';

import '../flight_module/widgets/boarding_pass.dart';
import '../models/atteraction_model.dart';
import '../models/tickets.dart';
import '../views/hotel_travel_constants.dart';

class HistoryController extends FxController {
  TickerProvider ticker;
  HistoryController(this.ticker);

  List<DetailattractionModal> detailattraction = <DetailattractionModal>[];
  bool showLoading = true, uiLoading = true;

  //tab
  late TabController tabController;
  late ScrollController scrollController;
  String? token;
  //

//  late  Product product;
  // late DetailattractionModal product;

  late AnimationController animationController,
      cartController,
      dateController,
      searchController;
  late Animation<Color?> colorAnimation;
  late Animation<double> sizeAnimation,
      cartAnimation,
      paddingAnimation,
      fadeAnimation;
  late Animation<Offset> dateAnimation, searchAnimation;
  int dateCounter = 0, searchCounter = 0;
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0, numPages = 4;
  late Timer timerAnimation;
  late TextEditingController dateTE, SearchTE;
  // late TextEditingController HistoryController;

  bool isFav = false;
  bool addCart = false;

  List<Tickets>? tickets;

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

  // getDetailAttraction(productid, setState) {
  //   log('getDetail Attraction function called');
  //   Future.delayed(Duration.zero, () async {
  //     await AttractionController()
  //         .getDetailattractionList(productid: productid)
  //         .then((value) {
  //       log('Details => $value');
  //       if (value != null) {
  //         isLoading = false;
  //         // detailattraction = value;
  //         setState(() {
  //           detailattraction = value;
  //         });
  //       }
  //     });
  //   });
  // }
  //
  // showFAB(TabController tabController) {
  //   int reviewTabIndex = 2;
  //   if (tabController.index == reviewTabIndex) {
  //     return true;
  //   }
  //   return false;
  // }

  @override
  void initState() {
    super.initState();
    //new
    tabController = TabController(length: 4, vsync: ticker);
    scrollController = ScrollController(initialScrollOffset: 0.0);
    scrollController.addListener(() {
      changeAppBarColor(scrollController);
    });
    // scrollController.hasClients(() {
    //   changeAppBarColor(scrollController);
    // });
    //
    dateTE = TextEditingController();
    // HistoryController = TextEditingController();
    save = false;
    fetchData();
    SearchTE = TextEditingController();
    searchController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    searchAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: searchController,
      curve: Curves.easeIn,
    ));
    searchController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        searchController.reverse();
      }
      if (status == AnimationStatus.dismissed && searchCounter < 2) {
        searchController.forward();
        searchCounter++;
      }
    });

    //date
    dateController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    timerAnimation = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (currentPage < numPages - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      //
      // pageController.animateToPage(
      //   currentPage,
      //   duration: const Duration(milliseconds: 800),
      //   curve: Curves.ease,
      // );
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
        ColorTween(begin: Colors.grey.shade400, end: const Color(0xff1529e8)
                // end: const Color(0xff1c8c8c)
                )
            .animate(animationController);

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
  }

  void BoardingScreen() {
    log('Boarding screen calling');
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   PageRouteBuilder(
    //       transitionDuration: const Duration(seconds: 2),
    //       pageBuilder: (_, __, ___) => const BoardingPass()),
    // );
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
        pageBuilder: (_, __, ___) => const BoardingPass()));
  }

  @override
  void dispose() {
    animationController.dispose();
    cartController.dispose();
    dateController.dispose();
    super.dispose();
    pageController.dispose();
    timerAnimation.cancel();
    scrollController.dispose();
    searchController.dispose();
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

  void selectSize(String size) {
    selectedSize = size;
    update();
  }

  // void fetchData() async {
  //   log('fetch data');
  //   products = HotelTravelCache.products;
  //   log(products!.length.toString());
  // }
  void fetchData() {
    tickets = HotelTravelCache.tickets;

    log('selectedtickets:$tickets');

    update();
  }

  void fetchloader() async {
    await Future.delayed(const Duration(seconds: 1));

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

  @override
  String getTag() {
    return "Detail_controller";
  }
}
