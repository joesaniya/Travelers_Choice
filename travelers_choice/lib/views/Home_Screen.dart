import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/services/auth_service.dart';
import 'package:hotel_travel/views/search_screens/search_place.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/attraction_Controller.dart';
import '../controllers/home_controller.dart';
import '../loading_effect.dart';

import '../models/all_attraction_modal.dart';
import '../services/app_constants.dart';
import '../theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  // const HomeScreen({required this.size});
  // final Size size;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late ThemeData theme, theme1;

  late HomeController controller;
  String _tabbed = '1';
  String? name, currencies, countryCode;
  SharedPreferences? sharedPreferences;

  bool isLoading = true;
  List<AllattractionModal> allattractionList = <AllattractionModal>[];

  String? currency() {
    if (currencies != null) {
      List<dynamic> countriesList = jsonDecode(currencies!);
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

  getAttraction() async {
    await AuthService().getCountry();
    log('getAttraction function called');
    sharedPreferences = await SharedPreferences.getInstance();
    Future.delayed(Duration.zero, () async {
      await AttractionController().getAllattractionList().then((value) {
        if (value != null) {
          isLoading = false;
          allattractionList.add(value);

          setState(() {
            countryCode = sharedPreferences!
                .getString(AppConstants.KEY_ACCESS_TOKEN_countryId);
            currencies = sharedPreferences!
                .getString(AppConstants.KEY_ACCESS_TOKEN_CurrenciesList);
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();

    getAttraction();
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        name = sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN_Name);
        log(name.toString());
        log('username');
      });
    });
    controller = FxControllerStore.put(HomeController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });
  }

//topatt
  Widget _buildProductList() {
    List<Widget> list = [];

    // for (Product product in controller.products!)
    for (var product in allattractionList.first.attractions.data) {
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: InkWell(
          onTap: () {
            controller.goToSingleProduct(product);
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
                      // tag: "excursion_id",
                      child: Image(
                        // image: AssetImage(product.image),
                        image: NetworkImage(
                            'https://a.walletbot.online/${product.images.first}'),
                        // image: AssetImage(product.images.first),
                        // height: 100,
                        height: 132,
                        width: 150,
                        fit: BoxFit.cover,
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
                                child: FxText.bodySmall(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  // 'Theme Park',
                                  product.category.categoryName.name,
                                  // 'Park',
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
                              child: FxText.bodySmall(
                                'Ticket',
                                fontWeight: 300,
                                color: Colors.white,
                                // color: theme.colorScheme.onPrimary,
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
                              child: FxText.bodySmall(
                                'Offer',
                                fontWeight: 300,
                                color: Colors.white,
                                // color: theme.colorScheme.onPrimary,
                              ),
                            ),
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
                            product.title,
                            fontWeight: 800,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        FxSpacing.height(4),
                        Hero(
                          tag: "${product.duration}",
                          child: FxText.labelLarge(
                            // '\$' + product.price.toString(),
                            "${product.duration} AED",
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
                                    '4.5',
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
    for (var product in allattractionList.first.attractions.data) {
      list.add(
          // car(controller.products![i])
          InkWell(
        onTap: () {
          controller.goToSingleProduct(product);
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
          height: 274,
          decoration: BoxDecoration(
              // color: Color(0xffe6e1e5),
              color: Colors.white,
              // color: Color(0xffe5fdfd),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey.shade300, width: 1)),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://a.walletbot.online/${product.images.first}'
                            // product.images.first.toString()
                            ),
                        fit: BoxFit.fill)),
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
                          child: FxText.bodySmall(
                            // 'Theme Park',
                            product.category.categoryName.name,
                            fontWeight: 300,
                            color: Colors.white,
                            // color: theme.colorScheme.onPrimary,
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
                          child: FxText.bodySmall(
                            'Ticket',
                            fontWeight: 300,
                            color: Colors.white,
                            // color: theme.colorScheme.onPrimary,
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
                          child: FxText.bodySmall(
                            'Offer',
                            fontWeight: 300,
                            color: Colors.white,
                            // color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                    Row(
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
                              product.averageRating.toString(),
                              fontWeight: 600,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(20),
              Container(
                height: 30,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: FxText.bodyLarge(
                    // 'Ferrari world',
                    product.title.toString(),
                    fontWeight: 800,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              FxSpacing.height(10),
              Padding(
                // padding: EdgeInsets.symmetric(horizontal: 0),
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
                                product.destination.name.name.toString(),
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
                      '${currency() ?? '\$'} ${product.activity.adultPrice.toString()}',
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
    if (allattractionList.isEmpty) {
      // log('home');
      // log(allattractionList.length.toString());
      // log('name' + allattractionList.first.attractions.id);

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
                      'Hey $name',
                      fontWeight: 700,
                    ),
                  ),
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
              const SearchPlace(),

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
                    GestureDetector(
                      onTap: () {
                        log('flight');
                        _tabbed = '2';
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
                                      : theme1.colorScheme.primaryContainer,
                                  width: _tabbed == '2' ? 0.0 : 1.0),
                              borderRadius: BorderRadius.circular(20.0)
                              // borderRadius:
                              //     new BorderRadius.all(Radius.elliptical(90, 45)),
                              ),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                    : theme1.colorScheme.primaryContainer,
                                width: _tabbed == '3' ? 0.0 : 1.0),
                            borderRadius: BorderRadius.circular(20.0)),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
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
                        log('flight');
                        _tabbed = '4';
                        setState(() {});
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
                                "assets/images/apps/shopping2/icons/visa.png",
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
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        log('Transfer');
                        _tabbed = '5';
                        setState(() {});
                      },
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                            color: _tabbed == '5'
                                ? const Color(0xff1529e8)
                                // theme1.colorScheme.primary
                                : Colors.transparent,
                            border: Border.all(
                                color: _tabbed == '5'
                                    ? Colors.transparent
                                    : theme1.colorScheme.primaryContainer,
                                width: _tabbed == '5' ? 0.0 : 1.0),
                            borderRadius: BorderRadius.circular(20.0)
                            // borderRadius:
                            //     new BorderRadius.all(Radius.elliptical(90, 45)),
                            ),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                                "assets/images/apps/shopping2/icons/card.png",
                                height: 20,
                                width: 20,
                                color: _tabbed == '5'
                                    ? Colors.white
                                    : Colors.black),
                            const SizedBox(
                              width: 7,
                            ),
                            FxText.bodyLarge(
                              'Transfer',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: _tabbed == '5'
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
