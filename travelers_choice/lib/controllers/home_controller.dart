import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutx/flutx.dart';

import 'package:hotel_travel/models/all_attraction_modal.dart';
import 'package:intl/intl.dart';
import '../card_widgets/customsnackbar.dart';
import '../models/attraction_search_modal.dart';
import '../models/product.dart';

import '../models/visaModels/visa_country_modal.dart';
import '../views/SearchScreen.dart';
import '../views/detail_screen/detail_Screen.dart';
import '../views/hotel_travel_constants.dart';
import '../views/visa_screen.dart';

class HomeController extends FxController {
  TickerProvider ticker;
  HomeController(this.ticker);
  // List<Category>? categories;
  List<Product>? products;
  List<AllattractionModal> allattractionList = <AllattractionModal>[];
  bool uiLoading = true;
  // late Category selectedCategory;
  late AnimationController animationController;
  late AnimationController bellController;
  late Animation<double> scaleAnimation,
      slideAnimation,
      fadeAnimation,
      bellAnimation;
  late Tween<Offset> offset;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<Widget> newCategories = [];

  //searchAttraction
  late TextEditingController locationTE, dateTE, visaTE;
  String? locationplace;
  GlobalKey<FormState> formKey = GlobalKey();

  // List<AllattractionModal> searchResult = <AllattractionModal>[];

  //country
  final focus = FocusNode();
  final visaFocus = FocusNode();
  // List<AllattractionModal> allattractionList = <AllattractionModal>[];

//ani
  late AnimationController searchController, locationController, dateController;
  late Animation<Offset> searchAnimation, locationAnimation, dateAnimation;
  int locationCounter = 0;
  int dateCounter = 0;

  Future<void> dateselect() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            1900), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      // log(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      log(formattedDate);
      dateTE.text = formattedDate;

      // setState(() {
      //   dateinput.text = formattedDate; //set output date to TextField value.
      // });
    } else {
      log("Date is not selected");
    }
  }

  List<Attraction> slugslist = [];
  List<String> SlugnameId = [];

  String? selectedCountry;
  List<AttractionSearchDataModal> countryList = <AttractionSearchDataModal>[];

  Future<void> Destinationbtn() async {
    log('searchDestinationbtn');
  }

  Future<void> searchbtn(
    // Destination locationplace
    // Destination selectedCountry,

    String selectedCountry,
    String keyid,
    String code,
    double Currencyvalue,
    String slugname,
    // Datum product
  ) async {
    log('search btn');
    log('Key Id:$keyid');
    log('controller slug:$slugname');
    locationCounter = 0;
    dateCounter = 0;
    // log('Currency Symbol:$currencySymbol');
    // log('Rate:$conversionRate');

    if (locationTE.text.isEmpty) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("Please select location")));
      CustomSnackbar.show(
        context: context,
        message: 'Please Select Location',
        backgroundColor: const Color(0xff1529e8),
        duration: const Duration(seconds: 2),
      );
    }
    // else if (dateTE.text.isEmpty) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("Please select date")));
    // }
    else {
      log('Slug:$slugname');
      log('SElected$selectedCountry');
      log('location:${locationTE.text}');
      if (countryList.first.attractions
          .map((e) => e.id)
          .toList()
          .contains(keyid)) {
        log('attraction name');
        log('Slug Id:${SlugnameId.last}');
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
            pageBuilder: (_, __, ___) => DetailScreen(keyid,
                allattractionList.first.attractions.data.first, SlugnameId.last
                //  slugname

                // product,
                // allattractionList!.first.attractions.data.first.slug
//  product.category.slug
                )
            // SingleProductScreen(product.id)
            ));
      } else {
        log('destination name');
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
            pageBuilder: (_, __, ___) => SearchScreen(
                  // place: Destination.fromJson(jsonDecode(selectedCountry)),
                  place: selectedCountry,
                  placeId: keyid,
                  currencySymbol: code,
                  conversionRate: Currencyvalue,
                  // currencySymbol: currencySymbol,
                  // conversionRate: conversionRate
                  // place:locationTE.text
                )));
      }
      // Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
      //     transitionDuration: const Duration(milliseconds: 500),
      //     transitionsBuilder: (
      //       BuildContext context,
      //       Animation<double> animation,
      //       Animation<double> secondaryAnimation,
      //       Widget child,
      //     ) =>
      //         FadeTransition(
      //           opacity: animation,
      //           child: child,
      //         ),
      //     pageBuilder: (_, __, ___) => SearchScreen(
      //           // place: Destination.fromJson(jsonDecode(selectedCountry)),
      //           place: selectedCountry,
      //           currencySymbol: code,
      //           conversionRate: Currencyvalue,
      //           // currencySymbol: currencySymbol,
      //           // conversionRate: conversionRate
      //           // place:locationTE.text
      //         )));
    }
  }

  Future<void> searchVisabtn(
      // Destination locationplace
      VisaCountryModal selectedVisaCountry) async {
    log('search btn');
    locationCounter = 0;
    dateCounter = 0;

    if (visaTE.text.isEmpty) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("Please select location")));
      CustomSnackbar.show(
        context: context,
        message: 'Please Select Location',
        backgroundColor: const Color(0xff1529e8),
        duration: const Duration(seconds: 2),
      );
    }
    // else if (dateTE.text.isEmpty) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("Please select date")));
    // }
    else {
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
          // pageBuilder: (_, __, ___) =>Container()
          pageBuilder: (_, __, ___) => VisaScreen(
              // place: Destination.fromJson(jsonDecode(selectedCountry)),
              place: selectedVisaCountry
              // place:locationTE.text
              )));
    }
  }

  //

  late Intro intro;
  String? selectedCountryCode;
  // final focus = FocusNode();
  final scrollController = ScrollController();
  final scrollController1 = ScrollController();
  final itemsPerPage = 10;
  var loadedItems = 0;
  var items = <String>[];

  void scrollListener() {
    log('scroll listener calling');
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      _loadMoreItems();
    }
  }

  void scrollListener1() {
    log('scroll listener calling');
    if (scrollController1.offset >=
            scrollController1.position.maxScrollExtent &&
        !scrollController1.position.outOfRange) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    await Future.delayed(
        const Duration(seconds: 1)); // simulate network latency
    log('loadmore items calling');
    items.addAll(_generateItems(loadedItems, itemsPerPage));
    loadedItems += itemsPerPage;
    update();
  }

  List<String> _generateItems(int start, int count) {
    return List.generate(count, (index) => 'Item ${start + index + 1}');
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    scrollController1.addListener(scrollListener1);
    fetchData();
    fetchloader();

    //
    locationTE = TextEditingController();
    visaTE = TextEditingController();
    dateTE = TextEditingController();
    searchController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    locationController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    dateController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 50));
    searchAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: searchController,
      curve: Curves.easeIn,
    ));
    locationAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: locationController,
      curve: Curves.easeIn,
    ));
    dateAnimation =
        Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0.01, 0))
            .animate(CurvedAnimation(
      parent: dateController,
      curve: Curves.easeIn,
    ));

    locationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        locationController.reverse();
      }
      if (status == AnimationStatus.dismissed && locationCounter < 2) {
        locationController.forward();
        locationCounter++;
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
    //
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: ticker,
    );
    bellController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: ticker,
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );

    bellAnimation = Tween<double>(begin: -0.04, end: 0.04).animate(
      CurvedAnimation(
        parent: bellController,
        curve: Curves.linear,
      ),
    );

    offset = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));

    animationController.forward();
    bellController.repeat(reverse: true);

    intro = Intro(
      stepCount: 2,
      maskClosable: true,
      onHighlightWidgetTap: (introStatus) {
        // log(introStatus);
      },
      widgetBuilder: StepWidgetBuilder.useDefaultTheme(
        texts: [
          'Get your notifications from here',
          // 'Attractions of the hotel',
          'Search Your best Hotels',
        ],
        buttonTextBuilder: (currPage, totalPage) {
          return currPage < totalPage - 1 ? 'Next' : 'Finish';
        },
      ),
    );

    intro.setStepConfig(0, borderRadius: BorderRadius.circular(64));
    Timer(
      const Duration(milliseconds: 0
          // 2000
          ),
      () {
        if (HotelTravelCache.isFirstTime) {
          // intro.start(context);
          HotelTravelCache.isFirstTime = false;
        }
      },
    );
  }

  startIntro() {
    intro.start(context);
  }

  void goBack() {
    Navigator.pop(context);
  }

  String? currencies, countryCode;

  String? currency() {
    if (currencies != null) {
      List<dynamic> countriesList = jsonDecode(currencies!);
      String? isoCode;

      log("Country list => $countriesList");
      log('''
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

  Future<bool> onWillPop() async {
    IntroStatus introStatus = intro.getStatus();
    if (introStatus.isOpen) {
      intro.dispose();
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    log('Home dispose calling');
    animationController.dispose();
    scrollController.dispose();
    scrollController1.dispose();
    bellController.dispose();

    searchController.dispose();
    locationController.dispose();
    dateController.dispose();
    locationTE.dispose();
    // searchController.reset();
    // locationController.reset();
    // dateController.reset();
    // locationTE.clear();
    selectedCountry = '';
    focus.dispose();
    visaFocus.dispose();
    super.dispose();
    super.dispose();
  }

  void fetchData() {
    // categories = HotelTravelCache.categories!.cast<Category>();
    // // products = HotelTravelCache.products;
    // selectedCategory = categories!.first;
    log('selectedCategory');
    // log(selectedCategory.)
    // uiLoading = false;
    // log(uiLoading.toString());
    update();
  }

  // void changeSelectedCategory(Category category) {
  //   selectedCategory = category;
  //   update();
  // }

  void fetchloader() async {
    await Future.delayed(const Duration(seconds: 1));

    uiLoading = false;
    log('fetchloader');
    log(uiLoading.toString());
    update();
  }

  // void changeSelectedCategory(Category category) {
  //   selectedCategory = category;
  //   update();
  // }

  void goToSingleProduct(
    Datum product,
    // currencySymbol, conversionRate
  ) {
    log(product.id);
    log('Slug:${product.slug}');
    log('message');
    // log(currencySymbol);
    // log("utfyjhvbn  $conversionRate");
    Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 0
            // 500
            ),
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
        pageBuilder: (_, __, ___) => DetailScreen(
            product.id,

            //  _toggleFavorite, _isMealFavorite,
            product,
            product.slug
            //   currencySymbol:currencySymbol,
            // conversionRate: conversionRate
            )
        // SingleProductScreen(product.id)
        ));
  }

  // final List<AllattractionModal> favouriteMeals = [];
  // final List<AllattractionModal> availableMeals = <AllattractionModal>[];

  // void _toggleFavorite(String mealId) async {
  //   await AttractionController().getAllattractionList(context).then((value) {
  //     if (value != null) {
  //       // isLoading = false;
  //       allattractionList = [];
  //       allattractionList.add(value);
  //       log('data All1:$allattractionList');
  //     }
  //   });
  //   log('All Data:${allattractionList.first.attractions.data.length}');
  //   log('toggle');

  //   final existingIndex = _favouriteMeals
  //       .indexWhere((meal) => meal.attractions.data.first.id == mealId);
  //   if (existingIndex >= 0) {
  //     _favouriteMeals.removeAt(existingIndex);
  //     update();
  //   } else {
  //     // _favouriteMeals.add(
  //     //   _availableMeals
  //     //       .firstWhere((meal) => meal.attractions.data.first.id == mealId),
  //     // );
  //     log('All Data:${allattractionList.first.attractions.data.length}');
  //     // AllattractionModal objmodal=a
  //     _favouriteMeals.add(
  //       allattractionList
  //           .firstWhere((meal) => meal.attractions.data.first.id == mealId),
  //     );
  //   }
  // }

  // bool _isMealFavorite(String id) {
  //   return _favouriteMeals.any((meal) => meal.attractions.data.first.id == id);
  // }

  void goToSubscription() {
    // Navigator.of(context, rootNavigator: true).push(
    //   MaterialPageRoute(
    //     builder: (context) => SubscriptionScreen(),
    //   ),
    // );
  }

  void goToNotification() {
    // Navigator.of(context, rootNavigator: true).push(
    //   MaterialPageRoute(
    //     builder: (context) => NotificationScreen(),
    //   ),
    // );
  }

  @override
  String getTag() {
    return "home_controller";
  }
}
