import 'dart:developer';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/services/auth_service.dart';
import 'package:hotel_travel/services/visa_service.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Hotel_folder/views/hotel_search.dart';
import '../controllers/attraction_Controller.dart';
import '../controllers/home_controller.dart';
import '../flight_module/splash/flight_splash.dart';
import '../loading_effect.dart';
import '../models/Country_modal.dart';
import '../models/all_attraction_modal.dart';
import '../models/atteraction_model.dart';
import '../services/app_constants.dart';
import '../theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'search_screens/search_attrction.dart';

class HomeScreen extends StatefulWidget {
  List<Activity> cartMeal;
  HomeScreen(this.cartMeal, {super.key});

  // const HomeScreen({required this.size});
  // final Size size;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late ThemeData theme, theme1;

  late HomeController controller;
  String _tabbed = '1';
  String? name, flagname, token;
  SharedPreferences? sharedPreferences;

  bool isLoading = true;

  // List<AllattractionModal> allattractionList = <AllattractionModal>[];
  List<AllattractionModal>? allattractionList;
  getAttraction(BuildContext context) async {
    await AuthService().getCountry();
    log('getAttraction function called');
    sharedPreferences = await SharedPreferences.getInstance();
    Future.delayed(Duration.zero, () async {
      await AttractionController().getAllattractionList(context).then((value) {
        if (value != null) {
          log('first data');
          isLoading = false;
          allattractionList = [];
          allattractionList!.add(value);
          log('All1:$allattractionList');

          setState(() {
            controller.countryCode = sharedPreferences!
                .getString(AppConstants.KEY_ACCESS_TOKEN_countryId);
            log('CountryCode:${controller.countryCode}');
            controller.currencies = sharedPreferences!
                .getString(AppConstants.KEY_ACCESS_TOKEN_CurrenciesList);
          });
        }
      });
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit the App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  getVisa(BuildContext context) async {
    await VisaService().getVisaCountry();
    log('getVisa function called');
    // sharedPreferences = await SharedPreferences.getInstance();
    // Future.delayed(Duration.zero, () async {
    //   await AttractionController().getAllattractionList(context).then((value) {
    //     if (value != null) {
    //       isLoading = false;
    //       allattractionList = [];
    //       allattractionList!.add(value);
    //       log('All1:$allattractionList');
    //
    //       setState(() {
    //         controller.countryCode = sharedPreferences!
    //             .getString(AppConstants.KEY_ACCESS_TOKEN_countryId);
    //         controller.currencies = sharedPreferences!
    //             .getString(AppConstants.KEY_ACCESS_TOKEN_CurrenciesList);
    //       });
    //     }
    //   });
    // });
  }

  // final scrollController = ScrollController();
  // final itemsPerPage = 10;
  // var loadedItems = 0;
  // // var items = <String>[];

  // void scrollListener() {
  //   log('scroll listener calling');
  //   if (scrollController.offset >= scrollController.position.maxScrollExtent &&
  //       !scrollController.position.outOfRange) {
  //     _loadMoreItems();
  //   }
  // }

  // Future<void> _loadMoreItems() async {
  //   await Future.delayed(
  //       const Duration(seconds: 10)); // simulate network latency
  //   log('loadmore items calling');

  //   setState(() {
  //     allattractionList!.addAll(_generateItems(loadedItems, itemsPerPage));
  //     loadedItems += itemsPerPage;
  //   });
  // }

  // List<AllattractionModal> _generateItems(int start, int count) {
  //   return List.generate(count, (index) => 'Item ${start + index + 1}');
  // }

  @override
  void initState() {
    super.initState();
    // scrollController.addListener(scrollListener);
    // controller.scrollController.addListener(controller.scrollListener);
    // getData();
    getCountryList();
    getAttraction(context);
    getVisa(context);
    // fetchData();
    log('All Data:$allattractionList');
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        name = sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN_Name);
        log(name.toString());
        log('username');
        token = sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN);
        log('Token home:${token.toString()}');

        // flagname = sharedPrefValue
        //     .getString(AppConstants.KEY_ACCESS_TOKEN_CountryFlag);
        // log('Country Flag:$flagname');
      });
    });
    controller = FxControllerStore.put(HomeController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });
  }

  List<Activity> selectedtour = [];

  fetchData() {
    Future.delayed(Duration.zero, () async {
      await getCountryList().then((value) {
        if (value) {
          isLoading = false;
          setState(() {});
        }
      });
      // await AuthController().getCountryList().then((value) {
      //   if (value) {
      //     isLoading = false;
      //     setState(() {});
      //   }
      // });
    });
  }

  Currency? selectedCountry;

  // List? newsData, topNews1;

  // Future getData() async {
  //   List<Future> responseFutures = [
  //     http.get(
  //       Uri.parse(
  //           'https://secure.mytravellerschoice.com/api/v1/attractions/all?limit=1000'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         // HttpHeaders.authorizationHeader: ""
  //       },
  //     ),
  //     http.get(
  //       Uri.parse(
  //           'https://secure.mytravellerschoice.com/api/v1/home/initial-data'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         // HttpHeaders.authorizationHeader: ""
  //       },
  //     ),
  //   ];
  //   List responses = await Future.wait(responseFutures);

  //   List data = jsonDecode(responses[0].body)['articles'];
  //   List topNewsData = jsonDecode(responses[1].body)['stories'];

  //   setState(() {
  //     List newsData = data;
  //     List topNews1 = topNewsData;

  //     isLoading =
  //         false; //this is for the initial loading, this is taking too much of time.
  //   });

  //   log('newsData:$newsData');
  //   log('topNews1:$topNews1');
  // }

  List<CountryModal> countryList = <CountryModal>[];
  bool isCountryListLoading = true;
  getCountryList() async {
    log('getcountry');
    isCountryListLoading = true;
    try {
      log('getcountry try');
      var data = await AuthService().getCountry();
      countryList.clear();
      if (data != null) {
        log('getcountry set');
        setState(() {
          countryList.add(data);
          // controller.countryCode = '63db60f9f926b340dbb3f446';63ac33ecff04e5652a2583f5
          // controller.countryCode = sharedPreferences!
          //     .getString(AppConstants.KEY_ACCESS_TOKEN_countryId);
          controller.countryCode = '63ac33ecff04e5652a2583f5';
          print("controller.countryCode ${controller.countryCode}");
          log("controller.countryCode ${controller.countryCode}");
          selectedCountry = countryList.first.currencies.firstWhere(
              (element) => element.country.id == controller.countryCode);
          log("selected Country:$selectedCountry");
        });

        isCountryListLoading = false;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

//capital
  String capitalizeAllWord(String value) {
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    return result;
  }

  //location
  String capitalizelocation(String value) {
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    return result;
  }

  String? currencySymbol;
  // double? conversionRate;
  double conversionRate = 0.0;

//topatt
  Widget _buildProductList() {
    List<Widget> list = [];

    // for (Product product in controller.products!)
    for (var product in allattractionList!.first.attractions.data) {
      // String text = product.category.categoryName.name;
      String text = product.category.categoryName;
      // String text = "Theme Park,Theme Park";
      //todo
      // text = text.replaceAll("_", " ");

      // List<String> words = text.split(" ");
      //todo
      currencySymbol = selectedCountry!.isocode;
      conversionRate = selectedCountry!.conversionRate;
      sharedPreferences!
          .setString(AppConstants.symbol, selectedCountry!.isocode);
      sharedPreferences!
          .setDouble(AppConstants.rate, selectedCountry!.conversionRate);
      //todo
      // text = text.replaceAll("_", " ");

      // List<String> words = text.split(" ");
      // for (int i = 0; i < words.length; i++) {
      //   words[i] =
      //       words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      // }

      // text = words.join(" ");
      //todo
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: InkWell(
          onTap: () {
            controller.goToSingleProduct(
              product,
              // currencySymbol, conversionRate
            );
          },
          child: Container(
            // onTap: () {
            //   controller.goToSingleProduct(product);
            // },
            // borderRadiusAll: 4,
            // // paddingAll: 16,
            // height: 120,
            height: 132,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey.shade300, width: 1)),
            margin: const EdgeInsets.only(
              bottom: 20,
            ),
            // //margin: EdgeInsets.all(8),
            // // color: Colors.green,
            // margin: FxSpacing.bottom(20),

            child: Container(
              margin: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Container(
                    // margin: EdgeInsets.all(8),
                    // paddingAll: 0,
                    // borderRadiusAll: 4,
                    // margin: EdgeInsets.all(8),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    // child: Image(image: NetworkImage(product.images.first)),
                    child: Hero(
                      tag: "product_image_${product.images.first}",
                      child: CachedNetworkImage(
                        height: 132,
                        width: 150,
                        fit: BoxFit.cover,
                        fadeOutDuration: const Duration(seconds: 1),
                        fadeInDuration: const Duration(seconds: 3),
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        ),
                        imageUrl:
                            'https://a.walletbot.online${product.images.first}',
                      ),
                    ),
                  ),
                  FxSpacing.width(20),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: FxContainer(
                                  borderRadiusAll: 10,
                                  // padding: FxSpacing.xy(8, 4),
                                  padding: FxSpacing.xy(6, 2),
                                  // color: Color(0xff1529e8),
                                  color: Colors.blueGrey,
                                  child: Center(
                                    child: FxText.bodySmall(
                                      // overflow: TextOverflow.ellipsis,
                                      // maxLines: 1,
                                      // text,
                                      capitalizeAllWord(
                                          product.category.categoryName),

                                      fontWeight: 300,
                                      color: Colors.white,
                                      // color: theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                              // FxContainer(
                              //   borderRadiusAll: 10,
                              //   // padding: FxSpacing.xy(8, 4),
                              //   padding: FxSpacing.xy(6, 2),
                              //   // color: Color(0xff1529e8),
                              //   color: Colors.blueGrey,
                              //   child: Center(
                              //     child: FxText.bodySmall(
                              //       // product.bookingType.name,
                              //       product.bookingType.name[0]
                              //               .toUpperCase() +
                              //           product.bookingType.name
                              //               .substring(1)
                              //               .toLowerCase(),
                              //       // 'Ticket',
                              //       fontWeight: 300,
                              //       color: Colors.white,
                              //       // color: theme.colorScheme.onPrimary,
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(
                              //   width: 5,
                              // ),

                              product.isOffer == false
                                  ? Container()
                                  : FxContainer(
                                      borderRadiusAll: 10,
                                      // padding: FxSpacing.xy(8, 4),
                                      padding: FxSpacing.xy(6, 2),
                                      // color: Color(0xff1529e8),
                                      color: Colors.blueGrey,
                                      child: FxText.bodySmall(
                                        'Offer',

                                        fontWeight: 300,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white,
                                        // color: theme.colorScheme.onPrimary,
                                      ),
                                    ),
// <<<<<<< HEAD
//                                     ),
//                                   ),
//                                 ),
//                                 // FxContainer(
//                                 //   borderRadiusAll: 10,
//                                 //   // padding: FxSpacing.xy(8, 4),
//                                 //   padding: FxSpacing.xy(6, 2),
//                                 //   // color: Color(0xff1529e8),
//                                 //   color: Colors.blueGrey,
//                                 //   child: Center(
//                                 //     child: FxText.bodySmall(
//                                 //       // product.bookingType.name,
//                                 //       product.bookingType.name[0]
//                                 //               .toUpperCase() +
//                                 //           product.bookingType.name
//                                 //               .substring(1)
//                                 //               .toLowerCase(),
//                                 //       // 'Ticket',
//                                 //       fontWeight: 300,
//                                 //       color: Colors.white,
//                                 //       // color: theme.colorScheme.onPrimary,
//                                 //     ),
//                                 //   ),
//                                 // ),
//                                 // const SizedBox(
//                                 //   width: 5,
//                                 // ),
//
//                                 product.isOffer == false
//                                     ? Container()
//                                     : FxContainer(
//                                   borderRadiusAll: 10,
//                                   // padding: FxSpacing.xy(8, 4),
//                                   padding: FxSpacing.xy(6, 2),
//                                   // color: Color(0xff1529e8),
//                                   color: Colors.blueGrey,
//                                   child: FxText.bodySmall(
//                                     'Offer',
//
//                                     fontWeight: 300,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     color: Colors.white,
//                                     // color: theme.colorScheme.onPrimary,
//                                   ),
//                                 )
//                                 ]
//                             ),
// =======
//                                     )
//                             ]),
// >>>>>>> fbbb748cc95e63646309c21ad393ab877c48ed96,
                            ],
                          ),
                          FxSpacing.height(8),
                          Hero(
                            tag: "product_title_${product.title}",
                            // child: FxText.bodyLarge(
                            //   product.name,
                            //   // fontWeight: 500,
                            // ),
                            child: FxText.bodyLarge(
                              // product.title[0].toUpperCase() +
                              //     product.title.substring(1).toLowerCase(),
                              capitalizeAllWord(product.title),
                              fontWeight: 800,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          FxSpacing.height(4),
                          Hero(
// <<<<<<< HEAD
                            tag: "${product.duration}",
                            child: FxText.labelLarge(
                              // "65",
                              // '${controller.currency() ?? '\$'} ${product.activity.adultPrice.toString()}',
                              " ${(selectedCountry != null ? "${((product.activity.lowPrice * selectedCountry!.conversionRate) as double).toStringAsFixed(2)} ${selectedCountry!.isocode} " : "")}",
                              // "\$" + product.price.toString() + "/hour",
                              fontWeight: 700,
                            ),
                          ),
                          FxSpacing.height(6),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Hero(
                                  tag: "${product.averageRating}",
                                  child: Row(children: [
                                    const Icon(
                                      // FeatherIcons.star,
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 12,
                                    ),
                                    FxSpacing.width(4),
                                    FxText.bodySmall(
                                      product.averageRating.toStringAsFixed(1),
                                      fontWeight: 600,
                                      color: Colors.black,
                                    ),
                                    FxSpacing.width(4),
                                    FxText.bodySmall(
                                      "(${product.totalReviews.toStringAsFixed(0)})",
                                      fontWeight: 600,
                                      color: Colors.black,
                                    ),
                                  ]),
                                )
                              ]),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
    }

    return Column(
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<HomeController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  //car
  Widget TopAttraction() {
    List<Widget> list = [];

    // list.add(FxSpacing.width(20));

    // for (int i = 0; i < controller.products; i++) {
    //   list.add(car(controller.products![i]));
    // }
    // for (Product product in controller.products!)
    for (Datum product in allattractionList!.first.attractions.data) {
      // String text = product.category.categoryName.name;
      String text = product.category.categoryName;
      //todo
      // text = text.replaceAll("_", " ");

      // List<String> words = text.split(" ");

      // for (int i = 0; i < words.length; i++) {
      //   words[i] =
      //       words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      // }

      // text = words.join(" ");

      // var currencySymbol = selectedCountry!.isocode;
      // var conversionRate = selectedCountry!.conversionRate;
      print(text);
      //todo
      list.add(
          // car(controller.products![i])
          InkWell(
        onTap: () {
          controller.goToSingleProduct(
            product,
            // currencySymbol, conversionRate
          );
        },
        child: Container(
          margin: const EdgeInsets.all(5.0),

          // height: 250,
          // height: 267,
          // height: 278,
          // height: 286,
          // height: 300,

          // width: 300,
          width: 260,
          // height: 274,
          // height: 280,
          height: 296,
          // height: MediaQuery.of(context).size.height * 0.360,

          decoration: BoxDecoration(
              // color: Color(0xffe6e1e5),
              color: Colors.white,
              // color: Color(0xffe5fdfd),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey.shade300, width: 1)),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   margin: const EdgeInsets.all(8),
              //   height: 150,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       image: DecorationImage(
              //           image: NetworkImage(
              //               'https://a.walletbot.online${product.images.first}'
              //               // product.images.first.toString()
              //               ),
              //           fit: BoxFit.fill)
              //           ),
              // ),
              Container(
                margin: const EdgeInsets.all(8),
                height: 150,
                child: CachedNetworkImage(
                  imageUrl: 'https://a.walletbot.online${product.images.first}',
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        // colorFilter: const ColorFilter.mode(
                        //   Colors.red,
                        //   BlendMode.colorBurn,
                        // ),
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                    color: Color(0xff1529e8),
                  )),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fadeOutDuration: const Duration(seconds: 1),
                  fadeInDuration: const Duration(seconds: 3),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FxContainer(
                          borderRadiusAll: 10,
                          // padding: FxSpacing.xy(8, 4),
                          padding: FxSpacing.xy(6, 2),
                          // color: Color(0xff1529e8),
                          color: Colors.blueGrey,
                          child: Center(
                            child: FxText.bodySmall(
                              // text,
                              capitalizeAllWord(product.category.categoryName),

                              // product.category.categoryName.name[0]
                              //         .toUpperCase() +
                              //     product.category.categoryName.name
                              //         .substring(1)
                              //         .toLowerCase(),
                              fontWeight: 300,
                              color: Colors.white,
                              // color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        FxContainer(
                          borderRadiusAll: 10,
                          // padding: FxSpacing.xy(8, 4),
                          padding: FxSpacing.xy(6, 2),
                          // color: Color(0xff1529e8),
                          color: Colors.blueGrey,
                          child: Center(
                            child: FxText.bodySmall(
                              product.bookingType.name[0].toUpperCase() +
                                  product.bookingType.name
                                      .substring(1)
                                      .toLowerCase(),

                              fontWeight: 300,
                              color: Colors.white,
                              // color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        product.isOffer == false
                            ? const SizedBox()
                            : FxContainer(
                                borderRadiusAll: 10,
                                // padding: FxSpacing.xy(8, 4),
                                padding: FxSpacing.xy(6, 2),
                                // color: Color(0xff1529e8),
                                color: Colors.blueGrey,
                                child: FxText.bodySmall(
                                  'Offer',

                                  fontWeight: 300,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white,
                                  // color: theme.colorScheme.onPrimary,
                                ),

                                // child: FxText.bodySmall(
                                //  '${product.duration}${product.durationType.name.toString() == "hours" ? 'Hrs' : 'Hrs'}',
                                //   // '${product.duration} hrs',
                                //   // 'offer',

                                //   fontWeight: 300,
                                //   maxLines: 1,
                                //   overflow: TextOverflow.ellipsis,
                                //   color: Colors.white,
                                //   // color: theme.colorScheme.onPrimary,
                                // ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: FxText.bodyLarge(
                        // product.title[0].toUpperCase() +
                        //     product.title.substring(1).toLowerCase(),
                        capitalizeAllWord(product.title),
                        fontWeight: 800,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              // FeatherIcons.star,
                              Icons.star,
                              color: Colors.yellow,
                              size: 12,
                            ),
                            FxSpacing.width(4),
                            FxText.bodySmall(
                              // '4.5',
                              product.averageRating.toStringAsFixed(1),
                              fontWeight: 600,
                              color: Colors.black,
                            ),
                            FxSpacing.width(4),
                            FxText.bodySmall(
                              "(${product.totalReviews})",
                              fontWeight: 600,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              FxSpacing.height(10),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FxContainer(
                          borderRadiusAll: 8,
                          padding: FxSpacing.xy(8, 4),
                          // color: theme.colorScheme.primary,
                          // color: Colors.yellow.shade400,
                          color: Colors.white,
                          child: Row(
                            children: [
                              const Icon(
                                Iconsax.location,
                                color: Colors.black,
                                // color: theme.colorScheme.onPrimary,
                                size: 12,
                              ),
                              FxSpacing.width(4),
                              FxText.labelLarge(
                                // '\$' + product.price.toString(),
                                capitalizeAllWord(product.destination.name),
                                // capitalizelocation(
                                //     product.destination.name[0].toUpperCase() +
                                //         product.destination.name),

                                //crt
                                // product.destination.name[0].toUpperCase() +
                                //     product.destination.name
                                //         .substring(1)
                                //         .toLowerCase(),

                                // product.price.toString() + " " + "AED",
                                // "\$" + product.price.toString() + "/hour",
                                // fontWeight: 700,
                              ),
                            ],
                          ),
                        ),
                        // FxContainer.bordered(
                        //   paddingAll: 4,
                        //   borderRadiusAll: 4,
                        //   child: Icon(
                        //     FeatherIcons.plus,
                        //     size: 14,
                        //     color: theme.colorScheme.onBackground,
                        //   ),
                        // ),
                      ],
                    ),
                    //currencyChange
                    Column(
                      children: [
                        FxText.bodyMedium("Starting From", fontWeight: 500),
                        FxText(
                          // "76",
                          // "${product.activity.adultPrice.toString()} AED",,
                          " ${(selectedCountry != null ? "${((product.activity.lowPrice * selectedCountry!.conversionRate) as double).toStringAsFixed(2)} ${selectedCountry!.isocode} " : "")}",
                          // "${product.activity.lowPrice.toString()} AED",
                          // '${controller.currency() ?? '\$'} ${product.activity.adultPrice.toString()}',
                          color: const Color(0xff1529e8),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
    }

    return SingleChildScrollView(
      // controller: controller.scrollController,
      controller: controller.scrollController1,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }

  Widget _buildBody() {
    double width = MediaQuery.of(context).size.width;
    double containerWidth = width / 2;
    if (controller.uiLoading)
    // if (allattractionList == null)
    {
      return Scaffold(
          body: Padding(
        padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
        child: LoadingEffect.getHomeLoadingScreen
            // getProductLoadingScreen->profile
            //getDatingHomeScreen->detail

            (
          context,
          // theme, theme.colorScheme
        ),
      ));
    } else {
      // if (allattractionList!.isEmpty)
      if (controller.uiLoading) {
        return const Scaffold(body: Center(child: Text("No Data found")));
      } else {
        return WillPopScope(
          // onWillPop: () => controller.onWillPop(),
          onWillPop: _onWillPop,
          child: Scaffold(
            backgroundColor: const Color(0xfff5f5f5),
            body: ListView(
              shrinkWrap: true,
              padding: FxSpacing.fromLTRB(
                  20, FxSpacing.safeAreaTop(context) + 20, 20, 0),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: "splash_username",
                      child: FxText.titleLarge(
                        // 'Hey Nency,',
                        // name.toString(),
                        token == null
                            ? 'Welcome back!!'
                            : 'Hey ${name![0].toUpperCase() + name!.substring(1).toLowerCase()}',
                        fontWeight: 700,
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          SizedBox(
                            height: 30,
                            width: 50,
                            // decoration: const BoxDecoration(color: Colors.white),
                            child:
                                // AppConstants.KEY_ACCESS_TOKEN_countryId == countryList?
                                // SvgPicture.network(
                                //   "https://cdn.jsdelivr.net/npm/svg-country-flags@1.2.10/svg/in.svg",
                                //   // "63db60f9f926b340dbb3f446",
                                //   width: 16,
                                //   height: 16,
                                // ),
                                DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                iconSize: 0.0,
                                hint: Row(
                                  children: [
                                    Expanded(
                                      child: SvgPicture.network(
                                        'https://cdn.jsdelivr.net/npm/svg-country-flags@1.2.10/svg/ae.svg',
                                        // 'https://cdn.jsdelivr.net/npm/svg-country-flags@1.2.10/svg/in.svg',
                                        width: 16,
                                        height: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                items: countryList.isNotEmpty &&
                                        countryList.first.currencies.isNotEmpty
                                    ? countryList.first.currencies.map((value) {
                                        return DropdownMenuItem<String>(
                                            value: value.country.id.toString(),
                                            child: Center(
                                              // child: Text(
                                              //   value.flag.toString(),
                                              //   style: FxTextStyle.bodyMedium(),
                                              // ),
                                              child: SvgPicture.network(
                                                value.country.flag,
                                                width: 16,
                                                height: 16,
                                              ),
                                            ));
                                      }).toList()
                                    : [].map((value) {
                                        return DropdownMenuItem<String>(
                                            value: value,
                                            child: Center(
                                              child: Text(
                                                value,
                                                style: FxTextStyle.bodyMedium(),
                                              ),
                                            ));
                                      }).toList(),

                                value: controller.selectedCountryCode,

                                onChanged: (value) {
                                  setState(() {
                                    selectedCountry = countryList
                                        .first.currencies
                                        .firstWhere((element) =>
                                            element.country.id ==
                                            value.toString());

                                    log("Selected Currency Symbol: ${selectedCountry!.currencySymbol}");
                                    log("Selected Country: $selectedCountry");
                                    controller.selectedCountryCode =
                                        value.toString();
                                    // _selectedCountryCode = value.toString();
                                    log("Selected CountryCode: ${controller.selectedCountryCode}");
                                  });
                                },

                                buttonHeight: 30,
                                buttonWidth: 200,
                                buttonPadding: const EdgeInsets.only(
                                    left: 14, right: 14, top: 4, bottom: 4),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                ),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 1),
                                  color: Colors.white,
                                  // color: theme.cardTheme.color,
                                ),
                                // .

                                itemHeight: 40,

                                itemPadding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                dropdownMaxHeight: 200,
                                dropdownPadding: null,

                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 2,
                                scrollbarAlwaysShow: true,
                                offset: const Offset(0, 0),
                              ),
                            ),
                          ),
                          FxSpacing.width(20),
                          // RotationTransition(
                          //   turns: controller.bellAnimation,
                          //   // key: controller.intro.keys[0],
                          //   child: InkWell(
                          //     onTap: () {
                          //       Navigator.of(context, rootNavigator: true).push(
                          //           PageRouteBuilder(
                          //               transitionDuration:
                          //                   const Duration(milliseconds: 500),
                          //               transitionsBuilder: (
                          //                 BuildContext context,
                          //                 Animation<double> animation,
                          //                 Animation<double> secondaryAnimation,
                          //                 Widget child,
                          //               ) =>
                          //                   FadeTransition(
                          //                     opacity: animation,
                          //                     child: child,
                          //                   ),
                          //               pageBuilder: (_, __, ___) =>
                          //                   NewCart(widget.cartMeal)));
                          //       // controller.goToNotification();
                          //     },
                          //     child: Stack(
                          //       clipBehavior: Clip.none,
                          //       children: [
                          //         Icon(
                          //           FeatherIcons.shoppingBag,
                          //           color: theme.colorScheme.onBackground,
                          //           size: 20,
                          //         ),
                          //         Positioned(
                          //           bottom: -2,
                          //           right: -2,
                          //           child: FxContainer.rounded(
                          //             paddingAll: 3,
                          //             color: const Color(0xff1529e8),
                          //             // color: theme.colorScheme.primary,
                          //             child: Center(
                          //                 child: FxText.bodySmall(
                          //               '2',
                          //               color: theme.colorScheme.onPrimary,
                          //               fontSize: 8,
                          //             )),
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),

                          // // //icon
                          // // IconButton(
                          // //   icon: const Icon(Icons.shopping_cart),
                          // //   onPressed: () {
                          // //     Navigator.of(context, rootNavigator: true).push(
                          // //         PageRouteBuilder(
                          // //             transitionDuration:
                          // //                 const Duration(milliseconds: 500),
                          // //             transitionsBuilder: (
                          // //               BuildContext context,
                          // //               Animation<double> animation,
                          // //               Animation<double> secondaryAnimation,
                          // //               Widget child,
                          // //             ) =>
                          // //                 FadeTransition(
                          // //                   opacity: animation,
                          // //                   child: child,
                          // //                 ),
                          // //             pageBuilder: (_, __, ___) =>
                          // //                 NewCart(widget.cartMeal)));
                          // //   },
                          // // ),
                          // FxSpacing.width(20),

                          // //bell
                          // RotationTransition(
                          //   turns: controller.bellAnimation,
                          //   // key: controller.intro.keys[0],
                          //   child: InkWell(
                          //     onTap: () {
                          //       controller.goToNotification();
                          //     },
                          //     child: Stack(
                          //       clipBehavior: Clip.none,
                          //       children: [
                          //         Icon(
                          //           FeatherIcons.bell,
                          //           color: theme.colorScheme.onBackground,
                          //           size: 20,
                          //         ),
                          //         Positioned(
                          //           bottom: -2,
                          //           right: -2,
                          //           child: FxContainer.rounded(
                          //             paddingAll: 3,
                          //             color: const Color(0xff1529e8),
                          //             // color: theme.colorScheme.primary,
                          //             child: Center(
                          //                 child: FxText.bodySmall(
                          //               '2',
                          //               color: theme.colorScheme.onPrimary,
                          //               fontSize: 8,
                          //             )),
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
                FxSpacing.height(4),
                FadeTransition(
                  opacity: controller.fadeAnimation,
                  child: FxText.bodySmall(
                    'Begin your Travel !!',
                    xMuted: true,
                  ),
                ),
                FxSpacing.height(20),
                //slanding widget
                // Stack(
                //   children: <Widget>[
                //     Image(
                //       width: double.infinity,
                //       height: MediaQuery.of(context).size.height * 0.35,
                //       fit: BoxFit.fill,
                //       image: AssetImage("assets/images/apps/hotel/hotelbg.jpg"),
                //     ),
                //     SearchPlace()
                //     // LogInScreen()
                //     // buildSearchBar(MediaQuery.of(context).size, "long"),
                //     // buildTitle(size),
                //   ],
                // ),

                // SearchAttractionScreen(
                //     isocode: selectedCountry!.isocode,
                //     conversionRate: selectedCountry!.conversionRate),
                // FxSpacing.height(29),
                _tabbed == '1'
                    ? SearchAttractionScreen(
                        isocode: currencySymbol.toString(),
                        conversionRate: conversionRate.toDouble(),
                        //isocode: selectedCountry!.isocode,
                        //conversionRate: selectedCountry!.conversionRate
                      )
                    // SearchPlace(
                    //     isocode: selectedCountry!.isocode,
                    //     conversionRate: selectedCountry!.conversionRate)
                    : _tabbed == '3'
                        ? const HotelSearch()
                        : const SizedBox(),
                // : const SearchVisa(),

                Listener(
                  behavior: HitTestBehavior.opaque,
                  onPointerDown: (_) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Column(
                    children: [
                      FxSpacing.height(20),
                      //scroll
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                log('Attraction');
                                _tabbed = '1';
                                setState(() {});
                              },
                              child: Container(
                                // width: 100,
                                decoration: BoxDecoration(
                                    color: _tabbed == '1'
                                        ? const Color(0xff1529e8)
                                        // theme1.colorScheme.primary
                                        : Colors.transparent,
                                    border: Border.all(
                                        color: _tabbed == '1'
                                            ? Colors.transparent
                                            : theme1
                                                .colorScheme.primaryContainer,
                                        width: _tabbed == '1' ? 0.0 : 1.0),
                                    // borderRadius:
                                    //     new BorderRadius.all(Radius.elliptical(90, 45)),
                                    // borderRadius: BorderRadius.only(
                                    //     topLeft: Radius.circular(20),
                                    //     topRight: Radius.circular(20))
                                    borderRadius: BorderRadius.circular(20.0)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        "assets/images/apps/shopping2/icons/attraction.png",
                                        height: 20,
                                        width: 20,
                                        color: _tabbed == '1'
                                            ? Colors.white
                                            : Colors.black),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    FxText.bodyLarge(
                                      'Attraction',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: _tabbed == '1'
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                log('flight');
                                _tabbed = '2';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const FlightSplash()));
                                setState(() {});
                              },
                              child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: _tabbed == '2'
                                          ? const Color(0xff1529e8)
                                          // theme1.colorScheme.primary
                                          : Colors.transparent,
                                      border: Border.all(
                                          color: _tabbed == '2'
                                              ? Colors.transparent
                                              : theme1
                                                  .colorScheme.primaryContainer,
                                          width: _tabbed == '2' ? 0.0 : 1.0),
                                      borderRadius: BorderRadius.circular(20.0)
                                      // borderRadius:
                                      //     new BorderRadius.all(Radius.elliptical(90, 45)),
                                      ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          "assets/images/apps/shopping2/icons/flight.png",
                                          height: 20,
                                          width: 20,
                                          color: _tabbed == '2'
                                              ? Colors.white
                                              : Colors.black),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      FxText.bodyLarge(
                                        'Flight',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: _tabbed == '2'
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                log('Hotel');
                                _tabbed = '3';
                                setState(() {});
                                // Navigator.of(context, rootNavigator: true).push(
                                //     PageRouteBuilder(
                                //         transitionDuration:
                                //             const Duration(milliseconds: 500),
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
                                //         pageBuilder: (_, __, ___) =>
                                //             const HotelSplash()));
                              },
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                    color: _tabbed == '3'
                                        ? const Color(0xff1529e8)
                                        // theme1.colorScheme.primary
                                        : Colors.transparent,
                                    border: Border.all(
                                        color: _tabbed == '3'
                                            ? Colors.transparent
                                            : theme1
                                                .colorScheme.primaryContainer,
                                        width: _tabbed == '3' ? 0.0 : 1.0),
                                    borderRadius: BorderRadius.circular(20.0)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        "assets/images/apps/shopping2/icons/hotel.png",
                                        height: 20,
                                        width: 20,
                                        color: _tabbed == '3'
                                            ? Colors.white
                                            : Colors.black),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    FxText.bodyLarge(
                                      'Hotel',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: _tabbed == '3'
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                log('visa');
                                _tabbed = '4';
                                setState(() {});
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=> VisaScreen()));
                              },
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                    color: _tabbed == '4'
                                        ? const Color(0xff1529e8)
                                        // theme1.colorScheme.primary
                                        : Colors.transparent,
                                    border: Border.all(
                                        color: _tabbed == '4'
                                            ? Colors.transparent
                                            : theme1
                                                .colorScheme.primaryContainer,
                                        width: _tabbed == '4' ? 0.0 : 1.0),
                                    borderRadius: BorderRadius.circular(20.0)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        "assets/images/apps/shopping2/icons/visa_icon.png",
                                        height: 20,
                                        width: 20,
                                        color: _tabbed == '4'
                                            ? Colors.white
                                            : Colors.black),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    FxText.bodyLarge(
                                      'Visa',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: _tabbed == '4'
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            // GestureDetector(
                            //   onTap: () {
                            //     log('Transfer');
                            //     _tabbed = '5';
                            //     setState(() {});
                            //   },
                            //   child: Container(
                            //     width: 120,
                            //     decoration: BoxDecoration(
                            //         color: _tabbed == '5'
                            //             ? const Color(0xff1529e8)
                            //             // theme1.colorScheme.primary
                            //             : Colors.transparent,
                            //         border: Border.all(
                            //             color: _tabbed == '5'
                            //                 ? Colors.transparent
                            //                 : theme1.colorScheme.primaryContainer,
                            //             width: _tabbed == '5' ? 0.0 : 1.0),
                            //         borderRadius: BorderRadius.circular(20.0)
                            //         // borderRadius:
                            //         //     new BorderRadius.all(Radius.elliptical(90, 45)),
                            //         ),
                            //     padding: const EdgeInsets.symmetric(horizontal: 5),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         Image.asset(
                            //             "assets/images/apps/shopping2/icons/card.png",
                            //             height: 20,
                            //             width: 20,
                            //             color: _tabbed == '5'
                            //                 ? Colors.white
                            //                 : Colors.black),
                            //         const SizedBox(
                            //           width: 7,
                            //         ),
                            //         FxText.bodyLarge(
                            //           'Transfer',
                            //           style: TextStyle(
                            //               fontSize: 18,
                            //               fontWeight: FontWeight.w800,
                            //               color: _tabbed == '5'
                            //                   ? Colors.white
                            //                   : Colors.black),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),

                      FxSpacing.height(20),
                      allattractionList == null || allattractionList!.isEmpty
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  0.8, // 80% of the screen width
                              height: MediaQuery.of(context).size.height * 0.6,
                              // height: double.infinity,
                              // width: double.infinity,
                              child: Center(
                                child: FxText.bodySmall(
                                  "Wait here, we are fetching data",
                                ),
                              ),
                            )
                          : const SizedBox(),
                      allattractionList == null || allattractionList!.isEmpty
                          ? const SizedBox()
                          : TopAttraction(),
                      // const TopAttractionCard(),->crt
                      // _buildAttractionList(),
                      allattractionList == null || allattractionList!.isEmpty
                          ? const SizedBox()
                          : FxSpacing.height(20),

                      allattractionList == null || allattractionList!.isEmpty
                          ? const SizedBox()
                          : FadeTransition(
                              opacity: controller.fadeAnimation,
                              // key: controller.intro.keys[1],
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: FxText.bodyLarge(
                                    'Top Attractions',
                                    letterSpacing: 0,
                                    fontWeight: 600,
                                  ),
                                ),
                              ),
                            ),

                      allattractionList == null || allattractionList!.isEmpty
                          ? const SizedBox()
                          : FxSpacing.height(20),
                      allattractionList == null || allattractionList!.isEmpty
                          ? const SizedBox()
                          : SingleChildScrollView(
                              controller: controller.scrollController,
                              scrollDirection: Axis.vertical,
                              child: _buildProductList(),
                            ),
                      FxSpacing.height(60),
                      // LazyLoadListView(
                      //   listItems: _herosList,
                      //   listItemType:
                      //       LazyLoadListViewItemType.customListItemType,
                      //   customListItemWidgetBuilder: (context, index) {
                      //     final hero = _herosList[index];
                      //     return CustomListTile(hero: hero);
                      //   },
                      //   onScrollDidReachEnd: _loadMorePhotos,
                      //   shouldEndLoad: _shouldEndLoadingPhotos,
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    }
  }
}
