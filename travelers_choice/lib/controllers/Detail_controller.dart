import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:intl/intl.dart';

import '../models/atteraction_model.dart';
import '../views/checkout_screen.dart';
import '../../controllers/attraction_Controller.dart';

class DetailController extends FxController {
  TickerProvider ticker;
  DetailController(this.ticker);

  // List<DetailattractionModal> detailAttractions = <DetailattractionModal>[];

//  late  Product product;
  // late DetailattractionModal product;
  List<DetailattractionModal> detailattraction = <DetailattractionModal>[];
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
  late Animation<Offset> dateAnimation;
  int dateCounter = 0;
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0, numPages = 3;
  late Timer timerAnimation;
  late TextEditingController dateTE;

  bool isFav = false;
  bool addCart = false;

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

  getDetailAttraction(productid, setState) {
    log('getDetail Attraction function called');
    Future.delayed(Duration.zero, () async {
      await AttractionController()
          .getDetailattractionList(productid: productid)
          .then((value) {
        log('Details => $value');
        if (value != null) {
          isLoading = false;
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

  @override
  void initState() {
    super.initState();
    //new
    tabController = TabController(length: 3, vsync: ticker);
    scrollController = ScrollController(initialScrollOffset: 0.0);
    scrollController.addListener(() {
      changeAppBarColor(scrollController);
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

  @override
  void dispose() {
    animationController.dispose();
    cartController.dispose();
    dateController.dispose();
    super.dispose();
    pageController.dispose();
    timerAnimation.cancel();
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

  Future<void> bookNow() async {
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
        pageBuilder: (_, __, ___) => const CheckOutScreen()));
  }

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

  @override
  String getTag() {
    return "Detail_controller";
  }
}
