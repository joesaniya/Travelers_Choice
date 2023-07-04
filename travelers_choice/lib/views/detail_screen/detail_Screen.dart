import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/controllers/Detail_controller.dart';
import 'package:hotel_travel/models/all_attraction_modal.dart';
import 'package:line_icons/line_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../loading_effect.dart';
import '../../services/app_constants.dart';
import '../../theme/app_theme.dart';
import '../full_app.dart';
import 'package:share_plus/share_plus.dart';

class DetailScreen extends StatefulWidget {
  final String productid;
  // final Function toggleFavourite;

  // final Function isFavourite;
  final Datum productdatum;
  final String productSlug;
  String? currencySymbol;
  double? conversionRate;

  DetailScreen(
      this.productid,
      // this.toggleFavourite, this.isFavourite,
      this.productdatum,
      this.productSlug,
      {super.key,
      this.currencySymbol,
      this.conversionRate});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late OutlineInputBorder outlineInputBorder;
  late DetailController controller;
  //  List<String> favs = [];
  String? currencySymbol;
  double? conversionRate;
  // List<DetailattractionModal> detailattraction = <DetailattractionModal>[];
  bool isSelected = false;
  String stringValue = "No value";
  List<Datum> tempFavouriteList = favouriteList.map((e) => e).toList();
  //map
  late GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = {}; //markers for google map
  static const LatLng showLocation =
      LatLng(27.7089427, 85.3086209); //location to show in map

  Set<Marker> getmarkers() {
    //markers to place on map
    log('Get Mare');
    markers.add(Marker(
      //add first marker
      markerId: MarkerId(showLocation.toString()),
      position: showLocation, //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Marker Title First ',
        snippet: 'My Custom Subtitle',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker(
      //add second marker
      markerId: MarkerId(showLocation.toString()),
      position: const LatLng(27.7099116, 85.3132343), //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Marker Title Second ',
        snippet: 'My Custom Subtitle',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker(
      //add third marker
      markerId: MarkerId(showLocation.toString()),
      position: const LatLng(27.7137735, 85.315626), //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Marker Title Third ',
        snippet: 'My Custom Subtitle',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    //add more markers here

    return markers;
  }

  void launchMap(String? urllocation) async {
    String? maplink = urllocation;
    // Uri googleUrl =
    //     Uri.parse('https://www.google.com/maps/search/?api=1&query=Googleplex');
    Uri googleUrl = Uri.parse(maplink!);
    log('Map:$maplink');

    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void initState() {
    super.initState();
    getAllSavedData();
    favouriteListCheck();
    log('isSelected555');
    initializingData();
    controller = FxControllerStore.put(DetailController(
      this,
      //  widget.productid
    ));
    log('isSelected:$isSelected');
    log('widget.productSlug${widget.productSlug}');

    controller.getDetailAttraction(
        widget.productid, widget.productSlug, setState);

    log('isSelected:$isSelected');
    theme = AppTheme.shoppingTheme;

    outlineInputBorder = const OutlineInputBorder(
        borderSide: BorderSide(
            color: Color(0xff1529e8),
            // color: Colors.lightBlueAccent,
            width: 0));
  }

  void initializingData() {
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        conversionRate = sharedPrefValue.getDouble(AppConstants.rate);
        log('conversionRate:$conversionRate');
        currencySymbol = sharedPrefValue.getString(AppConstants.symbol);
        log('currencySymbol:$currencySymbol');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<DetailController>(
        controller: controller,
        builder: (controller) {
          return _buildnew();
        });
  }

  Widget _buildnew() {
    print("currencysymbol detail $currencySymbol");
    print("currencysymbol detail $conversionRate");

    // print("currencysymbol detail ${widget.conversionRate}");
    final mealId = widget.productid;
    // log('Meal Id:${widget.productid}');
    final selectedMeal = controller.allattractionList
        .contains((Meal) => Meal.attractions.data.first.id == mealId);
    if (controller.detailattraction == null) {
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
      if (controller.detailattraction!.isEmpty)
      // if (controller.uiLoading)
      {
        log('detail');
        log(controller.detailattraction!.length.toString());
        log('name${controller.detailattraction}');
        return const Scaffold(body: Center(child: Text("No Data found")));
      } else {
        return Scaffold(
            backgroundColor: const Color(0xfff5f5f5),
            bottomNavigationBar: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: FxButton.block(
                onPressed: () {
                  controller.bookNow(
                      controller.detailattraction!.first, widget.productid);
                  // cartController.carts.add(Cart());
                },
                backgroundColor: const Color(0xff1529e8),
                // backgroundColor: customTheme.estatePrimary,
                borderRadiusAll: 12,

                elevation: 0,
                child: FxText.bodyMedium(
                  'View package',
                  color: Colors.white,
                  // color: customTheme.estateOnPrimary,
                  fontWeight: 700,
                ),
              ),
            ),
            body: ListView(
              padding: EdgeInsets.zero,
              // physics: const NeverScrollableScrollPhysics(),
              physics: const AlwaysScrollableScrollPhysics(),
              // physics: const ClampingScrollPhysics(),
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: PageView.builder(
                          pageSnapping: true,
                          physics: const ClampingScrollPhysics(),
                          controller: controller.pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              controller.currentPage = page;
                            });
                          },
                          itemCount:
                              controller.detailattraction!.first.images!.length,
                          itemBuilder: (context, index) {
                            return Hero(
                                tag:
                                    "product_image_${controller.detailattraction!.first.images!.first}",
                                child: Container(
                                  // child: Image(
                                  //   image: NetworkImage(
                                  //       'https://a.walletbot.online${controller.detailattraction!.first.images![index]}'),
                                  //   height:
                                  //       MediaQuery.of(context).size.height / 3,
                                  //   width: MediaQuery.of(context).size.width,
                                  //   fit: BoxFit.fill,
                                  // ),
                                  child: CachedNetworkImage(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width: MediaQuery.of(context).size.width,
                                    imageUrl:
                                        'https://secure.mytravellerschoice.com${controller.detailattraction!.first.images![index]}',
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator(
                                      color: Color(0xff1529e8),
                                    )),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fadeOutDuration: const Duration(seconds: 1),
                                    fadeInDuration: const Duration(seconds: 3),
                                  ),
                                ));
                          }),
                    ),
                    Positioned(
                      top: 24,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          MdiIcons.chevronLeft,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
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
                                      // categoryname(controller.detailattraction
                                      //         .first.category!.categoryName)
                                      // 'Theme Park',
                                      // controller.detailattraction!.first
                                      //             .category!.categoryName![0]
                                      //             .toUpperCase() +
                                      //         controller.detailattraction!.first
                                      //             .category!.categoryName!
                                      //             .substring(1)
                                      //             .toLowerCase() ??
                                      //     '',
                                      capitalizeAllWord(controller
                                          .detailattraction!
                                          .first
                                          .category!
                                          .categoryName!),
                                      // controller.product.bookingType.toString(),
                                      fontWeight: 300,
                                      color: Colors.white,
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
                                      // controller.detailattraction!.first
                                      //             .bookingType![0]
                                      //             .toUpperCase() +
                                      //         controller.detailattraction!.first
                                      //             .bookingType!
                                      //             .substring(1)
                                      //             .toLowerCase() ??
                                      //     '',
                                      capitalizeAllWord(controller
                                          .detailattraction!.first.bookingType
                                          .toString()),
                                      fontWeight: 300,
                                      color: Colors.white,
                                      // color: theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                controller.detailattraction!.first.isOffer ==
                                        false
                                    ? const SizedBox()
                                    : FxContainer(
                                        borderRadiusAll: 10,
                                        // padding: FxSpacing.xy(8, 4),
                                        padding: FxSpacing.xy(6, 2),
                                        // color: Color(0xff1529e8),
                                        color: Colors.blueGrey,
                                        child: Center(
                                          child: FxText.bodySmall(
                                            // controller.detailattraction.first.category
                                            //     .categoryName,
                                            'Offer',
                                            // '${controller.detailattraction.first.duration}${controller.detailattraction.first.durationType}',

                                            fontWeight: 300,
                                            color: Colors.white,
                                            // color: theme.colorScheme.onPrimary,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            FxSpacing.height(10),
                            Hero(
                              tag:
                                  "product_title_${controller.detailattraction!.first.title}",
                              child: FxText.titleMedium(
                                  // controller.product.title,
                                  // controller.detailattraction!.first.title![0]
                                  //             .toUpperCase() +
                                  //         controller
                                  //             .detailattraction!.first.title!
                                  //             .substring(1)
                                  //             .toLowerCase() ??
                                  //     '',
                                  capitalizelocation(controller
                                      .detailattraction!.first.title
                                      .toString()),
                                  fontWeight: 600,
                                  letterSpacing: 0),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    MdiIcons.mapMarker,
                                    color: theme.colorScheme.onBackground,
                                    size: 16,
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(left: 2),
                                      child: FxText.bodySmall(
                                          // controller.detailattraction!.first
                                          //             .destination!.name[0]
                                          //             .toUpperCase() +
                                          //         controller.detailattraction!
                                          //             .first.destination!.name
                                          //             .substring(1) ??
                                          //     '',
                                          capitalizelocation(controller
                                              .detailattraction!
                                              .first
                                              .destination!
                                              .name),
                                          fontWeight: 500)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          ClipOval(
                            child: Material(
                              color: const Color(0xff1529e8).withAlpha(24),
                              child: InkWell(
                                splashColor:
                                    const Color(0xff1529e8).withAlpha(100),
                                highlightColor:
                                    const Color(0xff1529e8).withAlpha(20),
                                child: SizedBox(
                                    width: 44,
                                    height: 44,
                                    child: Icon(
                                      MdiIcons.shareOutline,
                                      size: 22,
                                      color: const Color(0xff1529e8)
                                          .withAlpha(240),
                                    )),
                                onTap: () async {
                                  log('Share Button clicked');
                                  final urlPreview =
                                      "https://secure.mytravellerschoice.com/${widget.productid}";
                                  final title =
                                      '${controller.detailattraction!.first.title}';
                                  await Share.share(
                                      'Share Excursions\n\n $title \n\n$urlPreview');
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: ClipOval(
                              child: Material(
                                color: const Color(0xff1529e8).withAlpha(24),
                                child: AnimatedBuilder(
                                  animation: controller.animationController,
                                  builder: (BuildContext context, _) {
                                    return Container(
                                      child: InkWell(
                                        highlightColor: const Color(0xff1529e8)
                                            .withAlpha(20),
                                        splashColor: const Color(0xff1529e8)
                                            .withAlpha(100),
                                        child: SizedBox(
                                            width: 44,
                                            height: 44,
                                            child: Icon(
                                              // MdiIcons.heartOutline,
                                              isSelected
                                                  ? MdiIcons.heart
                                                  : MdiIcons.heartOutline,
                                              color: controller
                                                  .colorAnimation.value,
                                              size: controller
                                                  .sizeAnimation.value,

                                              // size: 20,
                                              // color: const Color(0xff1529e8),
                                            )),
                                        onTap: () async {
                                          bool existing = false;
                                          // controller.isFav
                                          //     ? controller.animationController
                                          //         .reverse()
                                          //     : controller.animationController
                                          //         .forward();
                                          log('Fav Item:${favouriteList.map((e) => e.id)}');
                                          log('Sel Id:${widget.productdatum.id}');
                                          if (favouriteList.isNotEmpty) {
                                            for (var i = 0;
                                                i < favouriteList.length;
                                                i++) {
                                              if (favouriteList[i].id ==
                                                  widget.productdatum.id) {
                                                // favouriteList
                                                //     .remove(favouriteList[i]);
                                                existing = true;
                                              } else {
                                                existing = false;
                                                // favouriteList
                                                //     .add(widget.productdatum);
                                              }
                                            }
                                            log('Existing:$existing');
                                            if (existing) {
                                              favouriteList
                                                  .remove(widget.productdatum);
                                            } else {
                                              favouriteList
                                                  .add(widget.productdatum);
                                            }
                                            // tempFavouriteList.map((e) {
                                            //   if (e.id ==
                                            //       widget.productdatum.id) {
                                            //     favouriteList.remove(e);
                                            //   } else {
                                            //     favouriteList
                                            //         .add(widget.productdatum);
                                            //   }
                                            // }).toList();
                                          } else {
                                            favouriteList
                                                .add(widget.productdatum);
                                          }

                                          // if (isSelected) {
                                          //   // widget.productdatum.favourite =
                                          //   //     false;
                                          //   favouriteList
                                          //       .remove(widget.productdatum);

                                          //   //api
                                          // } else {
                                          //   // widget.productdatum.favourite =
                                          //   //     true;
                                          //   favouriteList
                                          //       .add(widget.productdatum);
                                          //   log('Fav Item:${favouriteList.first.id}');
                                          //   //api
                                          //   log('Excursion Id Else:$mealId');
                                          // }
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.setBool("youKey", isSelected);
                                          setState(() {
                                            favouriteList;
                                            isSelected = !isSelected;

                                            // widget.toggleFavourite(mealId);
                                          });
                                          log('Detail:${favouriteList.map((e) => e.id)}');
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FxText.bodyMedium("Starting From", fontWeight: 500),
                          FxText.bodyMedium(
                              // "350 \$",
                              // controller.detailattraction!.first.activities!
                              //             .first.privateTransfers ==
                              //         null
                              //     ? '350 AED'
                              //     // ? '${controller.detailattraction!.first.activities!.first.adultPrice} AED'
                              //     : '${controller.detailattraction!.first.activities!.first.privateTransfers!.first.price} AED',
                              // // '${controller.detailattraction.first.activities.first.adultPrice} ${controller.currency() ?? '\$'}',
                              // '${(controller.detailattraction!.first.activities!.first.lowPrice* conversionRate

                              // )} AED'
                              '${((controller.detailattraction!.first.activities!.first.lowPrice * conversionRate) as double).toStringAsFixed(2)} $currencySymbol',
                              // as double).toStringAsFixed(2)} ${widget.currencySymbol}'

                              // controller.product.price.toString(),
                              fontWeight: 700)
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FxText.bodyMedium("Rating", fontWeight: 500),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Hero(
                                  tag:
                                      "product_raing_${controller.detailattraction!.first.averageRating}",
                                  child: FxText.bodyMedium(
                                      controller
                                          .detailattraction!.first.averageRating
                                          .toStringAsFixed(1),
                                      fontWeight: 700),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 4),
                                    child: FxStarRating(
                                        rating: controller.detailattraction!
                                                .first.averageRating
                                                .toDouble() ??
                                            2.55))
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(child: Container()),
                      FxContainer(
                        onTap: () {
                          log('review Screen clicked');
                          // controller.REviewPage(
                          //     controller.detailattraction!.first);
                          controller.REviewPage(widget.productid);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ReviewScreen()));
                        },
                        padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                        color: const Color(0xff1529e8).withAlpha(40),
                        // color:Color(0xff6874E8),
                        // customTheme.groceryPrimary.withAlpha(40),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // controller.detailattraction.first.totalRating.toDouble()?
                            controller.detailattraction!.first.reviews!.isEmpty
                                ? FxText.bodyMedium("(0 review)",
                                    color: const Color(0xff1529e8),
                                    fontWeight: 500,
                                    letterSpacing: -0.2)
                                : FxText.bodyMedium(
                                    '(${controller.detailattraction!.first.reviews!.length} reviews)',
                                    color: const Color(0xff1529e8),
                                    fontWeight: 500,
                                    letterSpacing: -0.2),
                            // FxText.bodyMedium("(243 review)",
                            //     color: const Color(0xff1529e8),
                            //     // color: customTheme.groceryPrimary,
                            //     fontWeight: 500,
                            //     letterSpacing: -0.2),
                            const Icon(
                              MdiIcons.chevronRight,
                              size: 14,
                              color: Color(0xff1529e8),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  // padding: const EdgeInsets.all(32.0),
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      color: Color(0xfff5f5f5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Container(
                      //     height: 300,
                      //     width: MediaQuery.of(context).size.width,
                      //     color: Colors.blueGrey,
                      //     child: const GoogleMap(
                      //         initialCameraPosition: CameraPosition(
                      //             target: LatLng(25.229584, 55.3156746),
                      //             zoom: 15))),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      // Container(
                      //   height: 300,
                      //   width: MediaQuery.of(context).size.width,
                      //   color: Colors.white,
                      //   child: GoogleMap(
                      //     //Map widget from google_maps_flutter package
                      //     zoomGesturesEnabled:
                      //         true, //enable Zoom in, out on map
                      //     initialCameraPosition: const CameraPosition(
                      //       //innital position in map
                      //       target: showLocation, //initial position
                      //       zoom: 15.0, //initial zoom level
                      //     ),
                      //     markers: getmarkers(), //markers to show on map
                      //     mapType: MapType.normal, //map type
                      //     onMapCreated: (controller) {
                      //       //method called when map is created
                      //       setState(() {
                      //         mapController = controller;
                      //       });
                      //     },
                      //   ),
                      // ),

                      //tabbar
                      Container(
                        // height: 60,
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        child: TabBar(
                          controller: controller.tabController,
                          onTap: (index) {
                            setState(() {
                              controller.tabController.index = index;
                            });
                          },
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black.withOpacity(0.6),
                          labelStyle: const TextStyle(
                              fontFamily: 'inter', fontWeight: FontWeight.w500),
                          indicatorColor: const Color(0xff1529e8),
                          isScrollable: true,
                          tabs: const [
                            Tab(
                              text: 'Description',
                            ),
                            Tab(
                                // text: 'Overview',
                                text: 'Directions'),
                            Tab(
                              text: 'Highlights',
                            ),
                            Tab(
                              text: 'FAQ\'s',
                            ),
                          ],
                        ),
                      ),

                      FxSpacing.height(20),

                      //indexedStack
                      IndexedStack(
                        index: controller.tabController.index,
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: 1,
                            // itemCount: controller
                            //     .detailattraction!.first.sections!.length,

                            // itemCount: controller.product.description.length,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return FxDashedDivider(
                                dashSpace: 4,
                                dashWidth: 8,
                                color: theme.colorScheme.onBackground
                                    .withAlpha(180),
                                height: 1.2,
                              );
                            },
                            itemBuilder: (context, index) {
                              log('detail iternary');
                              log('Iternary:${controller.detailattraction!.first.itineraryDescription}');
                              log('HighLights:${controller.detailattraction!.first.highlights}');
                              // return Html(
                              //   data: controller
                              //       .detailattraction.first.sections.first.body
                              //       .toString(),
                              //   style: {
                              //     'p': Style(color: Colors.grey),
                              //     'h4': Style(color: Colors.redAccent)
                              //   },
                              // );
                              // return SizedBox(
                              //     // child: controller.detailattraction!.first
                              //     //         .category!.description!.isEmpty
                              //     child: controller.detailattraction!.first
                              //             .sections![index].body!.isEmpty
                              //         // child: controller
                              //         //         .detailattraction!
                              //         //         .first
                              //         //         .activities!
                              //         //         .first
                              //         //         .description!
                              //         //         .isEmpty
                              //         ? FxText.bodyMedium(
                              //             'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                              //             // color: theme.colorScheme.onPrimary,
                              //             // color: Colors.black,
                              //             letterSpacing: 0.4,
                              //             fontSize: 11,
                              //           )
                              //         : Html(
                              //             // data: controller.detailattraction!
                              //             // .first.category!.description
                              //             // .toString(),
                              //             data: controller.detailattraction!
                              //                 .first.sections![index].body!,
                              //             // data: controller
                              //             //     .detailattraction!
                              //             //     .first
                              //             //     .activities!
                              //             //     .first
                              //             //     .description
                              //             //     .toString(),
                              //             // style: {
                              //             //   'p': Style(color: Colors.grey),
                              //             //   'h4': Style(color: Colors.redAccent)
                              //             // },
                              //           ));

                              // return controller.detailattraction!.first
                              //             .sections!.isEmpty ||
                              //         controller.detailattraction!.first
                              //                 .sections ==
                              //             null
                              return controller
                                      .detailattraction!.first.sections!.isEmpty
                                  //      ||
                                  // controller.detailattraction!.first
                                  //         .sections ==
                                  //     null
                                  ?
                                  // Html(
                                  //     data: controller.detailattraction!.first
                                  //         .itineraryDescription)
                                  SizedBox(
                                      child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // FxText.bodyLarge(
                                        //   controller.detailattraction!.first
                                        //       .sections![index].title
                                        //       .toString(),
                                        //   color: Colors.indigo,
                                        //   fontWeight: 900,
                                        //   textAlign: TextAlign.left,
                                        // ),
//todo
                                        controller.detailattraction!.first
                                                    .itineraryDescription ==
                                                null
                                            ? Html(
                                                // data: controller
                                                //         .detailattraction!
                                                //         .first
                                                //         .itineraryDescription ??
                                                //     'hhh'
                                                data:
                                                    "<p>Experience “At The Top at Burj Khalifa” it is an unmissable\r\nextraordinary experience of being on top of the world’s tallest building, while\r\nyou visit the 124th &amp; 125th floor. </p><p><br></p><p>After seeing the Burj Khalifa, you can relax at the Dubai Mall and\r\nyou can enjoy the world’s largest mall, you can spend time shopping for all\r\nkind of stuff. \r\n&nbsp;</p><p><br></p><p>At the end of the evening, enjoy a captivating water, music and\r\nlight spectacle while viewing the Dubai Fountain which is the world’s tallest\r\nperforming fountain. At over 900 ft in length – equivalent to over two football\r\npitches – The Dubai Fountain is situated on the 30-acre Burj Lake and performs\r\nto a selection of different melodies.</p>",
                                              )
                                            : Html(
                                                data: controller
                                                    .detailattraction!
                                                    .first
                                                    .itineraryDescription,
                                              ),
                                      ],
                                    ))

                                  // FxText.bodyMedium(
                                  //     'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                                  //     // color: theme.colorScheme.onPrimary,
                                  //     // color: Colors.black,
                                  //     letterSpacing: 0.4,
                                  //     fontSize: 11,
                                  //   )
                                  : SizedBox(
                                      child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FxText.bodyLarge(
                                          controller.detailattraction!.first
                                              .sections![index].title
                                              .toString(),
                                          color: Colors.indigo,
                                          fontWeight: 900,
                                          textAlign: TextAlign.left,
                                        ),
                                        // Html(
                                        //     data: controller.detailattraction!
                                        //         .first.sections![index].title),
                                        Html(
                                            data: controller.detailattraction!
                                                .first.sections![index].body),
                                      ],
                                    ));
                            },
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: 1,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              // return Html(
                              //   data: controller.detailattraction!.first
                              //       .sections!.first.body,
                              //   style: {
                              //     'p': Style(color: Colors.black),
                              //   },
                              // );

                              //maptodo
                              return buildBlurredImage(
                                  controller.detailattraction!.first.mapLink);

                              //to

                              // return StepTile(
                              //   // data: widget.data.tutorial[index],
                              //   data: widget.product,
                              // );
                            },
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: 1,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Html(
                                data: controller
                                    .detailattraction!.first.highlights,
                                //  controller
                                //     .detailattraction!.first.highlights
                                //     .toString(),
                                style: {
                                  'p': Style(color: Colors.black),
                                  'h4': Style(color: Colors.redAccent)
                                },
                              );
                            },
                          ),
                          //faq
                          controller.detailattraction!.first.faqs!.isEmpty
                              ? Center(
                                  child: FxText.bodyLarge(
                                    'No FaQ\'s',
                                    color: Colors.black,
                                    fontWeight: 900,
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FxText.bodyLarge(
                                            controller.detailattraction!.first
                                                .faqs![index].question
                                                .toString(),
                                            color: Colors.black,
                                            fontWeight: 900,
                                            textAlign: TextAlign.left,
                                          ),
                                          FxText.bodyMedium(
                                            controller.detailattraction!.first
                                                .faqs![index].answer
                                                .toString(),
                                            color: Colors.black,
                                            fontWeight: 500,
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      color: theme.colorScheme.onBackground
                                          .withAlpha(180),
                                      height: 1.2,
                                    );
                                  },
                                  itemCount: controller
                                      .detailattraction!.first.faqs!.length)
                        ],
                      ),

                      //touroption
                      // FxSpacing.height(15),
                      // _billingWidget(),
                      // _buildoption(),

                      // Container(
                      //     decoration: BoxDecoration(
                      //         // color: Color(0xffe6e1e5),
                      //         color: Colors.white,
                      //         // color: Color(0xffe5fdfd),
                      //         borderRadius:
                      //             const BorderRadius.all(Radius.circular(10)),
                      //         border: Border.all(
                      //             color: Colors.grey.shade300, width: 1)),
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 8, vertical: 15),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           "Contact Details".toUpperCase(),
                      //           style: const TextStyle(
                      //               fontWeight: FontWeight.w600, fontSize: 14.0),
                      //         ),
                      //         const SizedBox(height: 10.0),
                      //         FxText.bodyLarge(
                      //           'Sheikh Zayed Rd - Dubai - United Arab Emirates\n www.dubaiparksandresorts.com \n ph.No:+9718002629464',
                      //           textAlign: TextAlign.justify,
                      //           // style: TextStyle(
                      //           //     fontWeight: FontWeight.w300, fontSize: 14.0),
                      //         ),
                      //       ],
                      //     )),

                      // const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ));
      }
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

  favouriteListCheck() async {
    isSelected = favouriteList.any((e) => e.id == widget.productid);
    setState(() {
      isSelected;
    });
    log('Fav List Check:$isSelected');
  }

  getAllSavedData() async {
    log('get saved data');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? value = prefs.getBool("youKey");

    // For first time you get null data so no value
    // is assigned so it will not assign anything
    if (value != null) stringValue = value.toString();

    setState(() {});
  }

  Widget buildBlurredImage(String? locationmapurl) => GestureDetector(
        onTap: () {
          log('open map');
          launchMap(locationmapurl);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(children: [
            Image.asset(
              'assets/images/apps/shopping2/images/location_direction.png',
              fit: BoxFit.cover,
            ),
            Positioned.fill(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                        color: Colors.black.withOpacity(0.2),
                        //  color: Colors.white.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FxText.titleMedium(
                                  // controller.detailattraction!.first.title![0]
                                  //             .toUpperCase() +
                                  //         controller
                                  //             .detailattraction!.first.title!
                                  //             .substring(1)
                                  //             .toLowerCase() ??
                                  //     '',
                                  capitalizeAllWord(controller
                                      .detailattraction!.first.title
                                      .toString()),
                                  // 'Yas',
                                  fontWeight: 600,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  color: const Color(0xff1529e8).withAlpha(240),
                                  // color: const Color(0xff16A34A),
                                  letterSpacing: 0),
                              const Icon(
                                LineIcons.shareSquare,
                                color: Color(0xff16A34A),
                              )
                            ],
                          ),
                        ))))
          ]),
        ),
      );
}
