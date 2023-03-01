import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/services/auth_service.dart';
import 'package:hotel_travel/services/visa_service.dart';
import 'package:hotel_travel/views/search_screens/search_place.dart';
import 'package:hotel_travel/views/search_screens/visa_search.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/attraction_Controller.dart';
import '../controllers/home_controller.dart';
import '../loading_effect.dart';

import '../models/Country_modal.dart';
import '../models/all_attraction_modal.dart';
import '../services/app_constants.dart';
import '../theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  // const HomeScreen({required this.size});
  // final Size size;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late ThemeData theme, theme1;

  late HomeController controller;
  String _tabbed = '1';
  String? name, flagname;
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

  @override
  void initState() {
    super.initState();

    getAttraction(context);
    getVisa(context);
    fetchData();
    log('All Data:$allattractionList');
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        name = sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN_Name);
        log(name.toString());
        log('username');
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

  List<CountryModal> countryList = <CountryModal>[];
  bool isCountryListLoading = true;
  Future getCountryList() async {
    isCountryListLoading = true;
    try {
      var data = await AuthService().getCountry();
      countryList.clear();
      if (data != null) {
        setState(() {
          countryList.add(data);
          controller.countryCode = sharedPreferences!
              .getString(AppConstants.KEY_ACCESS_TOKEN_countryId);
          print("controller.countryCode ${controller.countryCode}");
          selectedCountry = countryList.first.currencies.firstWhere((element) => element.country.id==controller.countryCode);

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

//topatt
  Widget _buildProductList() {
    List<Widget> list = [];

    // for (Product product in controller.products!)
    for (var product in allattractionList!.first.attractions.data) {
      String text = product.category.categoryName.name;
      // String text = "Theme Park,Theme Park";

      text = text.replaceAll("_", " ");

      List<String> words = text.split(" ");
      var currencySymbol = selectedCountry!.isocode;
      var conversionRate = selectedCountry!.conversionRate;
      for (int i = 0; i < words.length; i++) {
        words[i] =
            words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      }

      text = words.join(" ");
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: InkWell(
          onTap: () {
            controller.goToSingleProduct(product,currencySymbol,conversionRate);
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

            child: ClipRect(
              child: Banner(
                textStyle: const TextStyle(color: Colors.white),
                message: product.bookingType.name[0].toUpperCase() +
                    product.bookingType.name.substring(1).toLowerCase(),
                location: BannerLocation.topStart,
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
                          // child: Image(
                          //   image: NetworkImage(
                          //       'https://a.walletbot.online${product.images.first}',
                          //       // product.images.first
                          //        errorBuilder: (BuildContext context, Object exception,
                          //         StackTrace stackTrace) {
                          //       return Text('Your error widget...');
                          //     },
                          //       ),

                          //   // height: 100,
                          //   height: 132,
                          //   width: 150,
                          //   fit: BoxFit.cover,
                          // ),

                          child: CachedNetworkImage(
                            height: 132,
                            width: 150,
                            fit: BoxFit.cover,
                            fadeOutDuration: const Duration(seconds: 1),
                            fadeInDuration: const Duration(seconds: 3),
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
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
                            // Wrap(spacing: 10, runSpacing: 10, children: [
                            //   FxContainer(
                            //     borderRadiusAll: 10,
                            //     // padding: FxSpacing.xy(8, 4),
                            //     padding: FxSpacing.xy(6, 2),
                            //     // color: Color(0xff1529e8),
                            //     color: Colors.blueGrey,
                            //     child: Center(
                            //       child: FxText.bodySmall(
                            //         text,

                            //         fontWeight: 300,
                            //         color: Colors.white,
                            //         // color: theme.colorScheme.onPrimary,
                            //       ),
                            //     ),
                            //   ),
                            //   const SizedBox(
                            //     width: 5,
                            //   ),
                            //   FxContainer(
                            //     borderRadiusAll: 10,
                            //     // padding: FxSpacing.xy(8, 4),
                            //     padding: FxSpacing.xy(6, 2),
                            //     // color: Color(0xff1529e8),
                            //     color: Colors.blueGrey,
                            //     child: Center(
                            //       child: FxText.bodySmall(
                            //         // product.bookingType.name,
                            //         product.bookingType.name[0].toUpperCase() +
                            //             product.bookingType.name
                            //                 .substring(1)
                            //                 .toLowerCase(),
                            //         // 'Ticket',
                            //         fontWeight: 300,
                            //         color: Colors.white,
                            //         // color: theme.colorScheme.onPrimary,
                            //       ),
                            //     ),
                            //   ),
                            //   const SizedBox(
                            //     width: 5,
                            //   ),
                            //   product.isOffer == false
                            //       ? Expanded(child: Container())
                            //       : FxContainer(
                            //           borderRadiusAll: 10,
                            //           // padding: FxSpacing.xy(8, 4),
                            //           padding: FxSpacing.xy(6, 2),
                            //           // color: Color(0xff1529e8),
                            //           color: Colors.blueGrey,
                            //           child: FxText.bodySmall(
                            //             'Offer',

                            //             fontWeight: 300,
                            //             maxLines: 1,
                            //             overflow: TextOverflow.ellipsis,
                            //             color: Colors.white,
                            //             // color: theme.colorScheme.onPrimary,
                            //           ),
                            //         ),
                            // ]
                            //     // children: _buildType(),
                            //     ),
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
                                        text,

                                        fontWeight: 300,
                                        color: Colors.white,
                                        // color: theme.colorScheme.onPrimary,
                                      ),
                                    ),

                                  )
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
                            product.title[0].toUpperCase() +
                                product.title.substring(1).toLowerCase(),
                            fontWeight: 800,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        FxSpacing.height(4),
                        Hero(
                          tag: "${product.duration}",
                          child: FxText.labelLarge(
                            // '${controller.currency() ?? '\$'} ${product.activity.adultPrice.toString()}',
                            " ${(selectedCountry!=null ?  "${((product.activity.lowPrice * selectedCountry!.conversionRate) as double).toStringAsFixed(2)} ${selectedCountry!.isocode} "   : "")}",
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
                              child: Row(
                                children: [
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
                                ),
                                const SizedBox(
                                  width: 5,
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
                                      )
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
                                product.title[0].toUpperCase() +
                                    product.title.substring(1).toLowerCase(),
                                fontWeight: 800,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            FxSpacing.height(4),
                            Hero(
                              tag: "${product.duration}",
                              child: FxText.labelLarge(
                                // '${controller.currency() ?? '\$'} ${product.activity.adultPrice.toString()}',
                                "${product.activity.lowPrice.toString()} AED",
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
                                  child: Row(
                                    children: [
                                      const Icon(
                                        // FeatherIcons.star,
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 12,
                                      ),
                                      FxSpacing.width(4),
                                      FxText.bodySmall(
                                        product.averageRating
                                            .toStringAsFixed(1),
                                        fontWeight: 600,
                                        color: Colors.black,
                                      ),
                                      FxSpacing.width(4),
                                      FxText.bodySmall(
                                        "(${product.totalReviews.toStringAsFixed(0)})",
                                        fontWeight: 600,
                                        color: Colors.black,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
      String text = product.category.categoryName.name;

      text = text.replaceAll("_", " ");

      List<String> words = text.split(" ");

      for (int i = 0; i < words.length; i++) {
        words[i] =
            words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      }

      text = words.join(" ");

      var currencySymbol = selectedCountry!.isocode;
      var conversionRate = selectedCountry!.conversionRate;
      print(text);
      list.add(
          // car(controller.products![i])
          InkWell(
        onTap: () {
          controller.goToSingleProduct(product,currencySymbol,conversionRate);
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
          height: 280,
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
                              text,
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
                        product.title[0].toUpperCase() +
                            product.title.substring(1).toLowerCase(),
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
                                product.destination.name[0].toUpperCase() +
                                    product.destination.name
                                        .substring(1)
                                        .toLowerCase(),

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
                    FxText(
                      // "${product.activity.adultPrice.toString()} AED",,
                      " ${(selectedCountry!=null ?  "${((product.activity.lowPrice * selectedCountry!.conversionRate) as double).toStringAsFixed(2)} ${selectedCountry!.isocode} "   : "")}",
                      // "${product.activity.lowPrice.toString()} AED",
                      // '${controller.currency() ?? '\$'} ${product.activity.adultPrice.toString()}',
                      color: const Color(0xff1529e8),
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
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }

  Widget _buildBody() {
    double width = MediaQuery.of(context).size.width;
    double containerWidth = width / 2;
    // if (controller.uiLoading)
    if (allattractionList == null) {
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
      if (allattractionList!.isEmpty) {
        return const Scaffold(body: Center(child: Text("No Data found")));
      } else {
        return WillPopScope(
          onWillPop: () => controller.onWillPop(),
          child: Scaffold(
            backgroundColor: const Color(0xfff5f5f5),
            body: ListView(
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
                        'Hey ${name![0].toUpperCase()+name!.substring(1).toLowerCase()}',
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
                                    // Expanded(
                                    //   child: FxText.labelLarge(
                                    //     "Code",
                                    //     fontWeight: 600,
                                    //     color: Colors.black,
                                    //     // color: theme.colorScheme.onPrimary,
                                    //     letterSpacing: 0.4,
                                    //   ),
                                    // ),
                                    Expanded(
                                      child: SvgPicture.network(
                                        'https://cdn.jsdelivr.net/npm/svg-country-flags@1.2.10/svg/in.svg',
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
                                     selectedCountry = countryList.first.currencies.firstWhere((element) => element.country.id==value.toString());

                                    log("Abbrar ${selectedCountry!.currencySymbol}");
                                    controller.selectedCountryCode =
                                        value.toString();
                                    // _selectedCountryCode = value.toString();
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
                          RotationTransition(
                            turns: controller.bellAnimation,
                            // key: controller.intro.keys[0],
                            child: InkWell(
                              onTap: () {
                                controller.goToNotification();
                              },
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Icon(
                                    FeatherIcons.bell,
                                    color: theme.colorScheme.onBackground,
                                    size: 20,
                                  ),
                                  Positioned(
                                    bottom: -2,
                                    right: -2,
                                    child: FxContainer.rounded(
                                      paddingAll: 3,
                                      color: const Color(0xff1529e8),
                                      // color: theme.colorScheme.primary,
                                      child: Center(
                                          child: FxText.bodySmall(
                                        '2',
                                        color: theme.colorScheme.onPrimary,
                                        fontSize: 8,
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
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

                _tabbed == '1' ? const SearchPlace() : const SearchVisa(),

                // GestureDetector(
                //   onTap: () {},
                //   child: Container(
                //     height: 50.0,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       color: const Color(0xff1529e8).withOpacity(0.3),
                //       borderRadius: BorderRadius.circular(50.0),
                //       boxShadow: <BoxShadow>[
                //         BoxShadow(
                //           color: Colors.grey.shade100,
                //           offset: const Offset(-4 * -1, 4 * -1),
                //           blurRadius: 8.0,
                //         ),
                //         BoxShadow(
                //           color: Colors.grey.shade500,
                //           offset: const Offset(10, 10),
                //           blurRadius: 8.0,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // //anim
                //  Container(
                //   // key: controller.intro.keys[2],
                //   height: 50,
                //   child: AnimatedList(
                //       scrollDirection: Axis.horizontal,
                //       key: controller.listKey,
                //       initialItemCount: controller.newCategories.length,
                //       itemBuilder: (context, index, animation) {
                //         return SlideTransition(
                //             position: animation.drive(controller.offset),
                //             child: controller.newCategories[index]);
                //       }),
                // ),
                // FxSpacing.height(20),

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
                                      : theme1.colorScheme.primaryContainer,
                                  width: _tabbed == '1' ? 0.0 : 1.0),
                              // borderRadius:
                              //     new BorderRadius.all(Radius.elliptical(90, 45)),
                              // borderRadius: BorderRadius.only(
                              //     topLeft: Radius.circular(20),
                              //     topRight: Radius.circular(20))
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                      // GestureDetector(
                      //   onTap: () {
                      //     log('flight');
                      //     _tabbed = '2';
                      //     setState(() {});
                      //   },
                      //   child: Container(
                      //       width: 120,
                      //       decoration: BoxDecoration(
                      //           color: _tabbed == '2'
                      //               ? const Color(0xff1529e8)
                      //               // theme1.colorScheme.primary
                      //               : Colors.transparent,
                      //           border: Border.all(
                      //               color: _tabbed == '2'
                      //                   ? Colors.transparent
                      //                   : theme1.colorScheme.primaryContainer,
                      //               width: _tabbed == '2' ? 0.0 : 1.0),
                      //           borderRadius: BorderRadius.circular(20.0)
                      //           // borderRadius:
                      //           //     new BorderRadius.all(Radius.elliptical(90, 45)),
                      //           ),
                      //       padding: const EdgeInsets.symmetric(horizontal: 5),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Image.asset(
                      //               "assets/images/apps/shopping2/icons/flight.png",
                      //               height: 20,
                      //               width: 20,
                      //               color: _tabbed == '2'
                      //                   ? Colors.white
                      //                   : Colors.black),
                      //           const SizedBox(
                      //             width: 7,
                      //           ),
                      //           FxText.bodyLarge(
                      //             'Flight',
                      //             style: TextStyle(
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.w800,
                      //               color: _tabbed == '2'
                      //                   ? Colors.white
                      //                   : Colors.black,
                      //             ),
                      //           ),
                      //         ],
                      //       )),
                      // ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      //  GestureDetector(
                      //   onTap: () {
                      //     log('Hotel');
                      //     _tabbed = '3';
                      //     setState(() {});
                      //   },
                      //   child: Container(
                      //     width: 120,
                      //     decoration: BoxDecoration(
                      //         color: _tabbed == '3'
                      //             ? const Color(0xff1529e8)
                      //             // theme1.colorScheme.primary
                      //             : Colors.transparent,
                      //         border: Border.all(
                      //             color: _tabbed == '3'
                      //                 ? Colors.transparent
                      //                 : theme1.colorScheme.primaryContainer,
                      //             width: _tabbed == '3' ? 0.0 : 1.0),
                      //         borderRadius: BorderRadius.circular(20.0)),
                      //     padding: const EdgeInsets.symmetric(horizontal: 5),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         Image.asset(
                      //             "assets/images/apps/shopping2/icons/hotel.png",
                      //             height: 20,
                      //             width: 20,
                      //             color: _tabbed == '3'
                      //                 ? Colors.white
                      //                 : Colors.black),
                      //         const SizedBox(
                      //           width: 7,
                      //         ),
                      //         FxText.bodyLarge(
                      //           'Hotel',
                      //           style: TextStyle(
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.w800,
                      //               color: _tabbed == '3'
                      //                   ? Colors.white
                      //                   : Colors.black),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
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
                                      : theme1.colorScheme.primaryContainer,
                                  width: _tabbed == '4' ? 0.0 : 1.0),
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
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

                //banner
                // FxSpacing.height(20),
                // Card(
                //   elevation: 1.0,
                //   child: ClipRect(
                //     child: Banner(
                //       textStyle: const TextStyle(color: Colors.white),
                //       message: 'OPEN',
                //       location: BannerLocation.topEnd,
                //       color: const Color(0xFF0db3ae),
                //       child: InkWell(
                //         child: const Padding(
                //             padding: EdgeInsets.all(8.0),
                //             child: Text('......')),
                //         onTap: () {},
                //       ),
                //     ),
                //   ),
                // ),
                FxSpacing.height(20),
                TopAttraction(),
                // const TopAttractionCard(),->crt
                // _buildAttractionList(),
                FxSpacing.height(20),

                FadeTransition(
                  opacity: controller.fadeAnimation,
                  // key: controller.intro.keys[1],
                  child: Container(
                    child: FxText.bodyLarge(
                      'Top Attractions',
                      letterSpacing: 0,
                      fontWeight: 600,
                    ),
                  ),
                ),

                FxSpacing.height(20),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _buildProductList(),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  // List<Widget> _buildType() {
  //   log(
  //     'category:${controller.categoryattraction.length}',
  //   );
  //   List<Widget> choices = [];
  //   for (SearchCategoriesModal item in controller.categoryattraction) {
  //     bool selected = controller.selectedChoices == item;
  //     if (selected) {
  //       choices.add(FxContainer.none(
  //         // color: theme.colorScheme.primary.withAlpha(28),
  //         // color: const Color(0xff1529e8).withAlpha(28),
  //         color: const Color(0xff1529e8),
  //         splashColor: Colors.lightBlue,

  //         bordered: true,
  //         borderRadiusAll: 20,
  //         paddingAll: 8,
  //         // border: Border.all(
  //         //   // color: theme.colorScheme.primary
  //         //   color: const Color(0xff1529e8),
  //         // ),
  //         onTap: () {
  //           controller.removeChoice(item);
  //         },
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Image(
  //                 height: 24,
  //                 width: 24,
  //                 image:
  //                     NetworkImage('https://a.walletbot.online/${item.icon}')),
  //             FxSpacing.width(20),
  //             FxText.bodySmall(
  //               item.categoryName![0].toUpperCase() +
  //                   item.categoryName!.substring(1).toLowerCase(),
  //               // color: theme.colorScheme.onBackground,
  //               color: Colors.white,
  //               fontSize: 16,
  //             ),
  //           ],
  //         ),
  //         // child: Row(
  //         //   mainAxisSize: MainAxisSize.min,
  //         //   children: [
  //         //     const Icon(
  //         //       Icons.check,
  //         //       size: 14,
  //         //       color: Color(0xff1529e8),
  //         //       // color: theme.colorScheme.primary,
  //         //     ),
  //         //     FxSpacing.width(6),
  //         //     FxText.bodySmall(
  //         //       item.categoryName.toString(),
  //         //       fontSize: 11,
  //         //       color: const Color(0xff1529e8),
  //         //       // color: theme.colorScheme.primary,
  //         //     )
  //         //   ],
  //         // )
  //       ));
  //     } else {
  //       choices.add(FxContainer.none(
  //         color: Colors.blueGrey.shade100,
  //         borderRadiusAll: 20,
  //         padding: FxSpacing.xy(12, 8),
  //         onTap: () {
  //           log('selected id:${item.id}');
  //           controller.addChoice(item);
  //         },
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             // ImageIcon(
  //             //   NetworkImage('https://a.walletbot.online/${item.icon}'),
  //             //   // color: Colors.red,
  //             //   size: 24,
  //             // ),

  //             Image(
  //                 height: 24,
  //                 width: 24,
  //                 image:
  //                     NetworkImage('https://a.walletbot.online/${item.icon}')),
  //             FxSpacing.width(20),
  //             FxText.bodySmall(
  //               item.categoryName![0].toUpperCase() +
  //                   item.categoryName!.substring(1).toLowerCase(),
  //               color: theme.colorScheme.onBackground,
  //               fontSize: 16,
  //             ),
  //           ],
  //         ),
  //       ));
  //     }
  //   }
  //   return choices;
  // }
}
