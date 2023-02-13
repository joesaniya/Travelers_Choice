import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:intl/intl.dart';

import '../models/Country_modal.dart';
import '../views/SearchScreen.dart';

class SearchController extends FxController {
  TickerProvider ticker;
  SearchController(this.ticker);
  late TextEditingController locationTE, dateTE;
  String? locationplace;
  GlobalKey<FormState> formKey = GlobalKey();

  // List<AllattractionModal> searchResult = <AllattractionModal>[];

  //country
  final focus = FocusNode();
  // List<AllattractionModal> allattractionList = <AllattractionModal>[];

//ani
  late AnimationController searchController, locationController, dateController;
  late Animation<Offset> searchAnimation, locationAnimation, dateAnimation;
  int locationCounter = 0;
  int dateCounter = 0;

  @override
  void initState() {
    super.initState();
    locationTE = TextEditingController();
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

  @override
  void dispose() {
    searchController.dispose();
    locationController.dispose();
    dateController.dispose();
    focus.dispose();
    super.dispose();
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

  Future<void> searchbtn(
      // Destination locationplace
      Destination selectedCountry) async {
    log('search btn');
    locationCounter = 0;
    dateCounter = 0;

    if (locationTE.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select location")));
    }
    // else if (dateTE.text.isEmpty) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("Please select date")));
    // }
    else {
      log('country');
      log(selectedCountry.toString());
      print('SElected$selectedCountry');
      log('location:${locationTE.text}');

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
              place: selectedCountry
              // locationplace
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
  String getTag() {
    return "login_controller";
  }
}
