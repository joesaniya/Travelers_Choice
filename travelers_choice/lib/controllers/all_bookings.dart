import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutx/flutx.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import '../models/category.dart';
import '../models/order_attraction_modal.dart';
import '../models/product.dart';
import '../views/download/pdf_viewer_page.dart';
import '../views/hotel_travel_constants.dart';
import '../views/view_order.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:dio/dio.dart';
import '../card_widgets/customsnackbar.dart';

class AllBookingController extends FxController {
  TickerProvider ticker;
  AllBookingController(this.ticker);
  List<Category>? categories;
  List<Product>? products;
  // List<AllAttractionOrders>? products;
  bool uiLoading = true;
  late Category selectedCategory;
  late AnimationController animationController;
  late AnimationController bellController, searchController;
  late Animation<Offset> searchAnimation;
  late Animation<double> scaleAnimation,
      slideAnimation,
      fadeAnimation,
      bellAnimation;
  late Tween<Offset> offset;
  late TextEditingController SearchTE;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<Widget> newCategories = [];
  late Intro intro;
  int searchCounter = 0;
  String? token;
  AllAttractionOrders? orders;

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchloader();
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
    animationController.forward();
    bellController.repeat(reverse: true);

    intro = Intro(
      stepCount: 2,
      maskClosable: true,
      onHighlightWidgetTap: (introStatus) {
        print(introStatus);
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
      const Duration(milliseconds: 2000),
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
    animationController.dispose();
    bellController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void fetchData() {
    categories = HotelTravelCache.categories;
    products = HotelTravelCache.products;
    // selectedCategory = categories!.first;
    // uiLoading = false;
    // log(uiLoading.toString());
    update();
  }

  void fetchloader() async {
    await Future.delayed(const Duration(seconds: 4));

    uiLoading = false;
    log('fetchloader');
    log(uiLoading.toString());
    update();
  }

  void openPDF(
          BuildContext context, File file, String orderId, String ActivityId) =>
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => PDFViewerPage(
                file: file, IdOrder: orderId, IdActivity: ActivityId)),
      );
  void downloadBtn(String orderId, String ActivityId) async {
    log('Donloadbtn Calling....');
    var res = await http.get(
      Uri.parse(
          "https://secure.mytravellerschoice.com/api/v1/attractions/orders/6401e4f5913789806d34b998/ticket/6401e4f5913789806d34b999"),
      // "https://secure.mytravellerschoice.com/api/v1/attractions/orders/$orderId/ticket/$ActivityId"),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );
    // body: jsonEncode(body),

    if (res.statusCode == 200) {
      log('response 200');
      // log('Response download:${res.bodyBytes}');

      String imagesdata = res.body;
      log('download data:$imagesdata');
      downloadBook(
          downloadLink:
              "https://secure.mytravellerschoice.com/api/v1/attractions/orders/6401e4f5913789806d34b998/ticket/6401e4f5913789806d34b999",
          title: "esther");
      // Navigator.of(context, rootNavigator: true).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => TicketDownload(downloaddata: imagesdata),
      //   ),
      // );
    } else {
      log('img error');
      var jsondata = jsonDecode(res.body);
      log(jsondata['error']);
      print(jsondata['error']);
      //snackbar
      CustomSnackbar.show(
        context: context,
        message: jsondata['error'],
        backgroundColor: const Color(0xff1529e8),
        duration: const Duration(seconds: 2),
      );
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(jsondata['error'])));
      return null;
    }
  }

  downloadBook({String? downloadLink, String? title}) async {
    log('downloading...');
    Dio dio;
    if (await Permission.storage.request().isGranted) {
      log('permissionif..');
      final downloadPath = await path.getExternalStorageDirectory();
      var filePath = '${downloadPath!.path}/$title.pdf';

      dio = Dio();
      await dio.download(downloadLink!, filePath).then((value) {
        dio.close();
        log('downloaded');
      }).catchError((Object e) {
        log('error:$e');
        // Fluttertoast.showToast(
        //     msg: "Terjadi kesalahan. Download gagal.", timeInSecForIosWeb: 1);
      });
    } else {}
  }

  Future<void> bookNow(
      // String id,
      Datum ordermodal // AllAttractionOrders ordermodal
      ) async {
    animationController.forward();
    log('Order attraction');
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
        transitionDuration: const Duration(microseconds: 0
            // milliseconds: 500
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
        pageBuilder: (_, __, ___) => ViewOrder(
            // Id: id
            ordermodal)));
  }

  void changeSelectedCategory(Category category) {
    selectedCategory = category;
    update();
  }

  void goToSingleProduct(Product product) {
    log(product.name);
    log('message');
    // Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
    //         transitionDuration: const Duration(milliseconds: 500),
    //         transitionsBuilder: (
    //           BuildContext context,
    //           Animation<double> animation,
    //           Animation<double> secondaryAnimation,
    //           Widget child,
    //         ) =>
    //             FadeTransition(
    //               opacity: animation,
    //               child: child,
    //             ),
    //         pageBuilder: (_, __, ___) => SingleProductScreen(product))
    //     // PageRouteBuilder(
    //     //     transitionDuration: const Duration(seconds: 1),
    //     //     pageBuilder: (_, __, ___) => SingleProductScreen(product)),
    //     );
  }

  @override
  String getTag() {
    return "AllBooking Controller";
  }
}
