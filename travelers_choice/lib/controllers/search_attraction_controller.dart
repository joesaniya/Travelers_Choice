import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/models/visaModels/visa_country_modal.dart';
import 'package:hotel_travel/views/visa_screen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../card_widgets/customsnackbar.dart';

import '../models/all_attraction_modal.dart';
import '../models/attraction_search_modal.dart';
import '../services/app_constants.dart';
import '../services/auth_service.dart';
import '../views/SearchScreen.dart';
import '../views/detail_screen/detail_Screen.dart';
import 'attraction_Controller.dart';

class SearchAttractionController extends FxController {
  TickerProvider ticker;
  SearchAttractionController(this.ticker);
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

  @override
  void initState() {
    super.initState();
    getAttraction(context);
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
  }

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
  String? currencies, countryCode;
  List<AllattractionModal>? allattractionList;
  Future<void> Destinationbtn() async {
    log('searchDestinationbtn');
  }

  SharedPreferences? sharedPreferences;
  bool isLoadingg = true;
  // List<AllattractionModal> allattractionList = <AllattractionModal>[];

  getAttraction(BuildContext context) async {
    await AuthService().getCountry();
    log('searchAttraction function called');
    sharedPreferences = await SharedPreferences.getInstance();
    Future.delayed(Duration.zero, () async {
      await AttractionController().getAllattractionList(context).then((value) {
        if (value != null) {
          isLoadingg = false;
          allattractionList = [];
          allattractionList!.add(value);
          log('AllSearch1:$allattractionList');

          countryCode = sharedPreferences!
              .getString(AppConstants.KEY_ACCESS_TOKEN_countryId);
          log('CountryCode:$countryCode');
          currencies = sharedPreferences!
              .getString(AppConstants.KEY_ACCESS_TOKEN_CurrenciesList);
          update();
        }
      });
    });
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
                allattractionList!.first.attractions.data.first, SlugnameId.last
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

  // void goToRegisterScreen() {
  //   Navigator.of(context, rootNavigator: true).pushReplacement(
  //     MaterialPageRoute(
  //       builder: (context) => RegisterScreen(),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    searchController.dispose();
    locationController.dispose();
    dateController.dispose();
    locationTE.dispose();
    selectedCountry = '';
    focus.dispose();
    visaFocus.dispose();
    super.dispose();
  }

  @override
  String getTag() {
    return "search_Attraction_controller";
  }
}
