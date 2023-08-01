// ignore_for_file: file_names

import 'dart:developer';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/controllers/Detail_controller.dart';
import 'package:hotel_travel/controllers/checkout_controller.dart';
import 'package:hotel_travel/models/all_attraction_modal.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../card_widgets/customsnackbar.dart';
import '../../loading_effect.dart';
import '../../models/Slot_Time.dart';
import '../../services/app_constants.dart';
import '../../theme/app_theme.dart';
import '../bottomSheet/Selected_Tours_Bottomsheet.dart';
import '../full_app.dart';

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
  // late ActivityController activitycontroller;
  late CheckOutController checkoutcontroller;
  //  List<String> favs = [];
  String? currencySymbol;
  double? conversionRate;
  // List<DetailattractionModal> detailattraction = <DetailattractionModal>[];
  bool isSelected = false;
  String stringValue = "No value";
  List<Datum> tempFavouriteList = favouriteList.map((e) => e).toList();

  //activity
  //
  bool clickedExcursion = true;
  List<TextEditingController> controllerTE = [];
  List<TextEditingController> SlotcontrollerTE = [];
  //map
  late GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = {}; //markers for google map
  static const LatLng showLocation =
      LatLng(27.7089427, 85.3086209); //location to show in map
  @override
  void initState() {
    super.initState();
    getAllSavedData();
    favouriteListCheck();
    favouriteListCheckActivity();
    log('isSelected555');
    initializingData();
    controller = FxControllerStore.put(DetailController(
      this,
      //  widget.productid
    ));
    // activitycontroller = FxControllerStore.put(ActivityController(this));
    checkoutcontroller = FxControllerStore.put(CheckOutController(this));
    log('isSelected:$isSelected');
    log('widget.productSlug${widget.productSlug}');

    controller.getDetailAttraction(
        widget.productid, widget.productSlug, setState);
    // var selectedData = controller.detailattraction!.first;

    // log(controller.person_count);

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

  Widget availabilityExpand() {
    return ExpandableNotifier(
        child: ScrollOnExpand(
      child: Card(
        elevation: 0,
        color: Colors.grey.shade200,
        clipBehavior: Clip.antiAlias,
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            iconColor: Colors.grey,
          ),
          header: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.titleMedium(
                  'Availability',
                  fontWeight: 600,
                  letterSpacing: 0,
                  color: const Color(0xff1529e8),
                ),
              ],
            ),
          ),
          collapsed: Container(),
          expanded: Padding(
              padding: const EdgeInsets.all(15),
              child: GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 7,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 2.5),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.white,
                      height: 90,
                      width: MediaQuery.of(context).size.width * 0.26,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          FxText.titleMedium(
                            capitalizeAllWord(controller.detailattraction!.first
                                .availability![index].day
                                .toString()),
                            fontWeight: 600,
                            letterSpacing: 0,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                  width: 40,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                    color:
                                        const Color(0xff1529e8).withAlpha(24),
                                  ),
                                  child: const Align(
                                    alignment: Alignment.centerRight,
                                    // child: ImageIcon(
                                    //   const AssetImage(
                                    //       "assets/icons/clock_plus.png"),
                                    //   color: const Color(0xff1529e8)
                                    //       .withAlpha(240),
                                    //   size: 17,
                                    // ),
                                    child: Icon(
                                      MdiIcons.clockIn,
                                      color: Color(0xff1529e8),
                                      // color: theme.colorScheme.onBackground,
                                      size: 16,
                                    ),
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              FxText.bodySmall(
                                controller.detailattraction!.first
                                    .availability![index].open!,
                                fontWeight: 300,
                                color: const Color(0xff1529e8).withAlpha(240),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Container(
                                  width: 40,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                    color:
                                        const Color(0xff1529e8).withAlpha(24),
                                  ),
                                  child: const Align(
                                    alignment: Alignment.centerRight,
                                    // child: ImageIcon(
                                    //   const AssetImage(
                                    //       "assets/icons/clock_reset.png"),
                                    //   color: const Color(0xff1529e8)
                                    //       .withAlpha(240),
                                    //   size: 15,
                                    // ),
                                    child: Icon(
                                      MdiIcons.clockOut,
                                      color: Color(0xff1529e8),
                                      // color: theme.colorScheme.onBackground,
                                      size: 16,
                                    ),
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              FxText.bodySmall(
                                controller.detailattraction!.first
                                    .availability![index].close!,
                                fontWeight: 300,
                                color: const Color(0xff1529e8),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  })),
        ),
      ),
    ));
  }

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

  favouriteListCheckActivity() async {
    isSelected = favouriteListCart.any((e) =>
        e.sId == controller.detailattraction!.first.activities!.first.sId);
    setState(() {
      isSelected;
    });
    log('Fav List Check:$isSelected');
  }

  Widget personCount(controller, cart, setState, theme,
      {isAdult = false, isChild = false, isInfant = false}) {
    return FxContainer(
      borderRadiusAll: 10,
      // padding: FxSpacing.xy(8, 4),
      padding: FxSpacing.xy(6, 2),
      color: const Color(0xff1529e8).withAlpha(24),
      // color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FxText.bodyMedium(
            isAdult
                ? 'Adult'
                : isChild
                    ? "Child"
                    : "Infant",
            fontWeight: 600,
          ),
          Row(
            children: [
              FxContainer(
                onTap: () async {
                  controller.personCountFn(cart,
                      isAdult: isAdult, isChild: isChild, isInfant: isInfant);
                  setState(() {});
                },
                paddingAll: 4,
                borderRadiusAll: 2,
                bordered: isDefault(controller, cart,
                    isAdult: isAdult, isChild: isChild, isInfant: isInfant),
                //  controller.decreaseAble(cart),
                border:
                    Border.all(color: const Color(0xff1529e8).withAlpha(120)),
                color: isDefault(controller, cart,
                        isAdult: isAdult, isChild: isChild, isInfant: isInfant)
                    ? const Color(0xff1529e8).withAlpha(28)
                    : theme.colorScheme.onBackground.withAlpha(200),
                child: Icon(
                  FeatherIcons.minus,
                  size: 12,
                  color: isDefault(controller, cart,
                          isAdult: isAdult,
                          isChild: isChild,
                          isInfant: isInfant)
                      ? const Color(0xff1529e8)
                      // theme.colorScheme.primary
                      : theme.colorScheme.onPrimary,
                ),
              ),
              FxSpacing.width(15),
              FxSpacing.height(8),
              FxText.bodyMedium(
                controller
                    .getCounts(cart.sId,
                        isAdult: isAdult, isChild: isChild, isInfant: isInfant)
                    .toString(),
                fontWeight: 700,
              ),
              FxSpacing.height(8),
              FxSpacing.width(15),
              FxContainer(
                onTap: () async {
                  controller.personCountFn(cart,
                      isIncrement: true,
                      isChild: isChild,
                      isAdult: isAdult,
                      isInfant: isInfant);
                  setState(() {});
                },
                bordered: isDefault(controller, cart,
                    isAdult: isAdult,
                    isChild: isChild,
                    isInfant: isInfant,
                    isIncrement: true),
                //  controller.increaseAble(cart),
                paddingAll: 4,
                borderRadiusAll: 2,
                border: Border.all(color: const Color(0xff1529e8)),
                color: isDefault(controller, cart,
                        isAdult: isAdult,
                        isChild: isChild,
                        isInfant: isInfant,
                        isIncrement: true)
                    ? const Color(0xff1529e8)
                    : theme.colorScheme.onBackground.withAlpha(200),
                child: Icon(
                  FeatherIcons.plus,
                  size: 12,
                  color: isDefault(controller, cart,
                          isAdult: isAdult,
                          isChild: isChild,
                          isInfant: isInfant,
                          isIncrement: true)
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool isDefault(controller, cart,
      {bool isAdult = false,
      bool isChild = false,
      bool isInfant = false,
      isIncrement = false}) {
    int value = controller.getCounts(cart.sId,
        isAdult: isAdult, isChild: isChild, isInfant: isInfant);
    if (isAdult) {
      return isIncrement ? value >= 1 : value != 1;
    } else {
      return isIncrement ? value >= 0 : value != 0;
    }
  }

  Widget smallCardsAvailable(String Sub, String text, IconData icon) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      // height: MediaQuery.of(context).size.height * 0.09,
      // height: 70,
      // width: MediaQuery.of(context).size.width * 0.16,
      // height: MediaQuery.of(context).size.height * 0.08,
      height: 110,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: const Color(0xff1529e8).withAlpha(40),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 13, color: const Color(0xff1529e8)),
          const SizedBox(
            height: 3,
          ),
          Center(
              child: FxText.bodyMedium(Sub,
                  color: const Color(0xff1529e8),
                  fontWeight: 500,
                  letterSpacing: -0.2)),
          const SizedBox(
            height: 3,
          ),
          FxText.bodyMedium(text,
              color: const Color(0xff1529e8),
              fontWeight: 500,
              letterSpacing: -0.2)
        ],
      ),
    );
  }

  Widget _buildCartList() {
    List<Widget> list = [];
    log('_buildCartList() calling');
    log(controller.detailattraction!.first.activities!.length.toString());

    for (var i = 0;
        i < controller.detailattraction!.first.activities!.length;
        i++) {
      List<TextEditingController> controllers = List.generate(
        controller.detailattraction!.first.activities!.length,
        (index) => TextEditingController(),
      );
      bool? isPrivate = controller
          .detailattraction!.first.activities![i].isPrivateTransferAvailable;
      bool? isShared = controller
          .detailattraction!.first.activities![i].isSharedTransferAvailable;
      controllerTE.add(TextEditingController());

      log(
          'Selected Tour Date:${controller.selectedtour.map((e) => e.selectedDate)}');
//slot
      List<TextEditingController> Slotcontrollers = List.generate(
        controller.detailattraction!.first.activities!.length,
        (index) => TextEditingController(),
      );
      SlotcontrollerTE.add(TextEditingController());

      //transfer
      if (controller.detailattraction!.first.activities![i]
                  .isPrivateTransferAvailable ==
              false &&
          controller.detailattraction!.first.activities![i]
                  .isSharedTransferAvailable ==
              false) {
        controller.itemValue.add(["Without Transfer"]);
      } else if (controller.detailattraction!.first.activities![i]
                  .isPrivateTransferAvailable ==
              true &&
          controller.detailattraction!.first.activities![i]
                  .isSharedTransferAvailable ==
              true) {
        controller.itemValue
            .add(["Without Transfer", "Private Transfer", "Shared Transfer"]);
        // if(detailAttractionResponse.attraction!.activities![i].isPrivateTransferAvailable==true){
        //   itemValue.add(["Without Transfer","Private Transfer", "Shared Transfer"]);
        //
        // }else {
        //   itemValue.add(["Without Transfer"]);
        // }
      } else if (controller.detailattraction!.first.activities![i]
                  .isPrivateTransferAvailable ==
              true &&
          controller.detailattraction!.first.activities![i]
                  .isSharedTransferAvailable ==
              false) {
        controller.itemValue.add(["Without Transfer", "Private Transfer"]);
      } else if (controller.detailattraction!.first.activities![i]
                  .isPrivateTransferAvailable ==
              false &&
          controller.detailattraction!.first.activities![i]
                  .isSharedTransferAvailable ==
              true) {
        controller.itemValue.add(["Without Transfer", "Shared Transfer"]);
      } else {
        controller.itemValue.add(["Without Transfer"]);
      }
      //
      list.add(SizedBox(
        //fade
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FxSpacing.height(10),
            GestureDetector(
              onTap: () {
                clickedExcursion = !clickedExcursion;

                setState(() {});

                // controller.updateTourSlot(currentSlot[i])
                controller.updateTours(
                    controller.detailattraction!.first.activities![i]);

                // log('Count:${controller.detailattraction!.first.activities![i].adultCount}${controller.detailattraction!.first.activities![i].childCount}${controller.detailattraction!.first.activities![i].infantCount}');
                // controller.SlotPick(
                //   controller.detailattraction!.first.activities![i].productId.toString(),
                //   controller.detailattraction!.first.activities![i].productCode.toString(),
                //   controller.detailattraction!.first.activities![i].selectedDate!.toString(),
                // );
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     content: !clickedExcursion
                //         ? const Text("Added this Excursion!!")
                //         : const Text("Removed this Excursion!!")));
              },
              child: Card(
                shadowColor: Colors.black,
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                // color: const Color(0xff5c69e0),
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 8,
                  ),
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      color: const Color(0xffF6F8FB),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // FxSpacing.height(10),S
                        // FxText.bodyLarge(
                        //   controller.detailattraction!.first.activities![i].name ?? '',
                        //   muted: true,
                        //   fontWeight: 900,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     GestureDetector(
                        //       child: AnimatedContainer(
                        //         // height: 40 ?? 28,
                        //         // width: 40 ?? 28,
                        //         height: 20,
                        //         width: 20,
                        //         duration: const Duration(milliseconds: 500),
                        //         curve: Curves.fastLinearToSlowEaseIn,
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(2.0),
                        //             color: controller.selectedtour.contains(
                        //                     controller.detailattraction!.first
                        //                         .activities![i])
                        //                 ? Colors.indigo
                        //                 : Colors.white,
                        //             border: Border.all(
                        //               color: controller.selectedtour.contains(
                        //                       controller.detailattraction!.first
                        //                           .activities![i])
                        //                   ? Colors.transparent
                        //                   : Colors.black,
                        //             )),
                        //         child: !controller.selectedtour.contains(
                        //                 controller.detailattraction!.first
                        //                     .activities![i])
                        //             ? null
                        //             : Icon(
                        //                 FeatherIcons.check,
                        //                 color: Colors.white.withAlpha(200),
                        //                 size: 20,
                        //               ),
                        //       ),
                        //     ),
                        //     FxSpacing.width(10),
                        //     Expanded(
                        //       child: Align(
                        //         alignment: Alignment.centerLeft,
                        //         child: FxText.bodyLarge(
                        //           controller.detailattraction!.first
                        //                   .activities![i].name ??
                        //               '',
                        //           muted: true,
                        //           fontWeight: 900,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // FxSpacing.height(20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FxText.bodyLarge(
                                controller.detailattraction!.first
                                        .activities![i].name ??
                                    '',
                                muted: true,
                                fontWeight: 900,
                              ),
                              controller.detailattraction!.first.activities![i]
                                          .isPromoCode ==
                                      true
                                  ? const SizedBox(
                                      width: 5,
                                    )
                                  : const SizedBox(),
                              controller.detailattraction!.first.activities![i]
                                          .isPromoCode ==
                                      true
                                  ? Flexible(
                                      child: FxContainer(
                                      borderRadiusAll: 10,
                                      // padding: FxSpacing.xy(8, 4),
                                      padding: FxSpacing.xy(6, 2),
                                      color: const Color(0xff1529e8),
                                      // color: Colors.blueGrey,
                                      child: Center(
                                        child: FxText.bodySmall(
                                          // '${((controller.detailattraction!.first.activities![i].promoAmount! * conversionRate!)).toStringAsFixed(2)} $currencySymbol OFF',
                                          '${controller.detailattraction!.first.activities![i].promoCode}',
                                          fontWeight: 900,
                                          color: Colors.white,
                                          // color: theme.colorScheme.onPrimary,
                                        ),
                                      ),
                                    ))
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        Column(children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FxText.bodySmall('per person*'),
                              controller.detailattraction!.first.activities![i]
                                          .adultPrice ==
                                      null
                                  ? FxText.bodyLarge(
                                      '0',
                                      fontWeight: 900,
                                    )
                                  : FxText.bodyLarge(
                                      '${((controller.detailattraction!.first.activities![i].lowPrice * conversionRate) as double).toStringAsFixed(2)} $currencySymbol',

                                      // '${controller.detailattraction!.first.activities![i].lowPrice.toString()} AED',
                                      fontWeight: 900,
                                    )
                            ],
                          ),
                          !controller.selectedtour.contains(controller
                                  .detailattraction!.first.activities![i])
                              ? const SizedBox(height: 0)
                              : Column(
                                  children: [
                                    // selectedIndex == i
                                    //     ? const SizedBox()
                                    //     : const Text('data'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        dropdownwidget(i),
                                        FxSpacing.width(10),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: theme.cardTheme.color,
                                              // color: const Color(0xff1529e8),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          height: 50,
                                          width: 150,
                                          child: TextFormField(
                                            style: FxTextStyle.bodyMedium(),
                                            // controller: controller.dateTE,
                                            // controller: controllers[i],
                                            controller: controllerTE[i],
                                            readOnly:
                                                true, //set it true, so that user will not able to edit text

                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate: DateTime
                                                              .now(), //DateTime.now() - not to allow to choose before today.
                                                          lastDate:
                                                              DateTime(2101))
                                                      .then((value) async {
                                                if (value != null) {
                                                  // log(
                                                  //     value); //pickedDate output format => 2021-03-10 00:00:00.000
                                                  String formattedDate =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(value);
                                                  log(formattedDate);
                                                  // dateTE.text = formattedDate;
                                                  controllerTE[i].text =
                                                      formattedDate;
                                                  controller
                                                          .detailattraction!
                                                          .first
                                                          .activities![i]
                                                          .selectedDate =
                                                      formattedDate;

                                                  // log('Selected Date:${controller.detailattraction!.first.activities![i].selectedDate}');

                                                  // var data =
                                                  //     await controller.SlotPick(
                                                  //   // controller
                                                  //   //     .processGetTimeSlot(
                                                  //   controller
                                                  //       .detailattraction!
                                                  //       .first
                                                  //       .activities![i]
                                                  //       .productId
                                                  //       .toString(),
                                                  //   controller
                                                  //       .detailattraction!
                                                  //       .first
                                                  //       .activities![i]
                                                  //       .productCode
                                                  //       .toString(),
                                                  //   controller
                                                  //       .detailattraction!
                                                  //       .first
                                                  //       .activities![i]
                                                  //       .selectedDate
                                                  //       .toString(),
                                                  //   controller
                                                  //       .detailattraction!
                                                  //       .first
                                                  //       .activities![i]
                                                  //       .sId
                                                  //       .toString(),
                                                  // );
                                                  setState(() {
                                                    // controller.slottimeget =
                                                    //     data!;
                                                    // CustomSlots? customslot =
                                                    //     FunctionGetSlots(widget
                                                    //         .excursions[i]
                                                    //         .productId
                                                    //         .toString());
                                                    // currentEvent =
                                                    //     customslot!.event;
                                                  });
                                                  // log('controller.slottimeget:${controller.slottimeget}');
                                                  // dataslot =
                                                  //     await controller.SlotPick(
                                                  //   controller.detailattraction!.first.activities![i].productId
                                                  //       .toString(),
                                                  //   widget
                                                  //       .excursions[i].productCode
                                                  //       .toString(),
                                                  //   controller.detailattraction!.first.activities![i]
                                                  //       .selectedDate!
                                                  //       .toString(),
                                                  // );

                                                  // setState(() {
                                                  //   dateinput.text = formattedDate; //set output date to TextField value.
                                                  // });
                                                } else {
                                                  log("Date is not selected");
                                                }
                                                return null;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                                filled: true,
                                                isDense: true,
                                                fillColor:
                                                    theme.cardTheme.color,
                                                hintText: "yyyy-mm-dd",
                                                border: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                contentPadding:
                                                    FxSpacing.all(16),
                                                hintStyle: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  letterSpacing: 0.4,
                                                ),
                                                // hintStyle: FxTextStyle.bodyMedium(),
                                                isCollapsed: true),
                                            autofocus: false,
                                            keyboardType:
                                                TextInputType.datetime,
                                          ),
                                        ),
                                      ],
                                    ),

                                    FxSpacing.height(4),

                                    //buton
                                    widget.productid ==
                                                '63ff12f5d7333637a938cad4' &&
                                            controllerTE[i].text.isNotEmpty
                                        ? Row(
                                            children: [
                                              Padding(
                                                padding: FxSpacing.fromLTRB(
                                                    0, 6, 0, 6),
                                                child: FxContainer(
                                                  onTap: () async {
                                                    log('Tour Datas=>${controller.detailattraction!.first.activities![i].sId.toString()}=>${controller.detailattraction!.first.activities![i].productId.toString()}=>${controller.detailattraction!.first.activities![i].productCode.toString()}=>${controller.detailattraction!.first.activities![i].selectedDate.toString()}');
                                                    if (controllerTE[i]
                                                        .text
                                                        .isEmpty) {
                                                      CustomSnackbar.show(
                                                        context: context,
                                                        message:
                                                            'Select Your Tour date',
                                                        backgroundColor:
                                                            const Color(
                                                                0xff1529e8),
                                                        duration:
                                                            const Duration(
                                                                seconds: 2),
                                                      );
                                                    } else {
                                                      var data = await controller
                                                          .processGetTimeSlot(
                                                        controller
                                                            .detailattraction!
                                                            .first
                                                            .activities![i]
                                                            .productId
                                                            .toString(),
                                                        controller
                                                            .detailattraction!
                                                            .first
                                                            .activities![i]
                                                            .productCode
                                                            .toString(),
                                                        controller
                                                            .detailattraction!
                                                            .first
                                                            .activities![i]
                                                            .selectedDate
                                                            .toString(),
                                                        controller
                                                            .detailattraction!
                                                            .first
                                                            .activities![i]
                                                            .sId
                                                            .toString(),
                                                      );

                                                      log('TTLc Datas=>${controller.detailattraction!.first.activities![i].sId.toString()}=>${controller.detailattraction!.first.activities![i].productId.toString()}=>${controller.detailattraction!.first.activities![i].productCode.toString()}=>${controller.detailattraction!.first.activities![i].selectedDate.toString()}');
                                                      setState(() {});

                                                      controller.timeSlotList =
                                                          data;
                                                      log("timeSlot $data");

                                                      controller.timeSlotList !=
                                                              null
                                                          ? showAlertDialog(
                                                              i,
                                                              controller
                                                                  .timeSlotList)
                                                          : CustomSnackbar.show(
                                                              context: context,
                                                              message:
                                                                  'No Time slot',
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xff1529e8),
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          2),
                                                            );
                                                    }
                                                  },
                                                  borderRadiusAll: 10,
                                                  // padding: FxSpacing.xy(8, 4),
                                                  padding: FxSpacing.xy(6, 15),
                                                  color:
                                                      const Color(0xff1529e8),

                                                  child: FxText.bodySmall(
                                                    'Select Time SLot',

                                                    fontWeight: 900,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Colors.white,
                                                    // color: theme.colorScheme.onPrimary,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: controller
                                                            .detailattraction!
                                                            .first
                                                            .activities![i]
                                                            .activityTimeSlot ==
                                                        null
                                                    ? Container()
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          FxText.bodyMedium(
                                                            getFormattedDate(controller
                                                                .detailattraction!
                                                                .first
                                                                .activities![i]
                                                                .activityTimeSlot!
                                                                .startDateTime
                                                                .toString()),
                                                            color: Colors.black,
                                                            fontWeight: 600,
                                                          ),
                                                          FxText.bodyMedium(
                                                            ' - ',
                                                            color: Colors.black,
                                                            fontWeight: 600,
                                                          ),
                                                          FxText.bodyMedium(
                                                            getFormattedDate(controller
                                                                .detailattraction!
                                                                .first
                                                                .activities![i]
                                                                .activityTimeSlot!
                                                                .endDateTime
                                                                .toString()),
                                                            color: Colors.black,
                                                            fontWeight: 600,
                                                          ),
                                                        ],
                                                      ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),

                                    FxSpacing.height(4),

                                    //transfer
                                    // controller
                                    //             .detailattraction!
                                    //             .first
                                    //             .activities![i]
                                    //             .privateTransfers!
                                    //             .isNotEmpty &&
                                    //         controller
                                    //                 .detailattraction!
                                    //                 .first
                                    //                 .activities![i]
                                    //                 .transferCode ==
                                    //             'private'
                                    //     ? privatetransferwidget(i)
                                    //     : const SizedBox(),
                                    // FxSpacing.height(4),

                                    //example
                                    controller
                                                .detailattraction!
                                                .first
                                                .activities![i]
                                                .privateTransfers!
                                                .isNotEmpty &&
                                            controller
                                                    .detailattraction!
                                                    .first
                                                    .activities![i]
                                                    .transferCode ==
                                                'private'
                                        ? PrivateTransferexample(i)
                                        : const SizedBox(),
                                    FxSpacing.height(8),

                                    Container(
                                      height: 50,
                                      color: Colors.transparent,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          personCount(
                                              controller,
                                              controller.detailattraction!.first
                                                  .activities![i],
                                              setState,
                                              theme,
                                              isAdult: true),
                                          //child
                                          FxSpacing.width(4),

                                          personCount(
                                              controller,
                                              controller.detailattraction!.first
                                                  .activities![i],
                                              setState,
                                              theme,
                                              isChild: true),
                                          FxSpacing.width(4),

                                          //infant

                                          personCount(
                                              controller,
                                              controller.detailattraction!.first
                                                  .activities![i],
                                              setState,
                                              theme,
                                              isInfant: true),
                                        ],
                                      ),
                                    ),

                                    FxSpacing.height(10),
                                    Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        FxText.bodyMedium(
                                          'Grand Total',
                                          fontWeight: 700,
                                          fontSize: 20,
                                          color: const Color(0xff1529e8),
                                        ),
                                        FxSpacing.width(10),
                                        FxText.bodyMedium(
                                          '${((controller.getGrandTotal(controller.detailattraction!.first.activities![i]) * conversionRate!)).toStringAsFixed(2)} $currencySymbol',
                                          fontWeight: 800,
                                          fontSize: 20,
                                          color: const Color(0xff1529e8),
                                        ),
                                      ],
                                    ),
                                    FxSpacing.height(10),
                                    // controller.isChecked == true
                                    //     ? Align(
                                    //         alignment: Alignment.centerRight,
                                    //         child: RichText(
                                    //           text: TextSpan(
                                    //             children: <TextSpan>[
                                    //               const TextSpan(
                                    //                   text: '🎉 You Saved ',
                                    //                   style: TextStyle(
                                    //                       // height: 2,
                                    //                       // letterSpacing: 1.0,
                                    //                       color: Colors.black,
                                    //                       fontSize: 15,
                                    //                       fontWeight:
                                    //                           FontWeight.w400)),
                                    //               TextSpan(
                                    //                   text:
                                    //                       '${((controller.detailattraction!.first.activities![i].promoAmount! * conversionRate!)).toStringAsFixed(2)} $currencySymbol',
                                    //                   style: const TextStyle(
                                    //                       color: Colors.black,
                                    //                       // decoration:
                                    //                       //     TextDecoration.underline,
                                    //                       fontSize: 15,
                                    //                       fontWeight:
                                    //                           FontWeight.w500)),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       )
                                    //     : const SizedBox(),

                                    FxSpacing.height(6),
                                    // controllerTE[i].text.isNotEmpty
                                    //     ? Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.end,
                                    //         // crossAxisAlignment: CrossAxisAlignment.start,
                                    //         children: [
                                    //           GestureDetector(
                                    //             onTap: () {
                                    //               controller.goToCheckout(
                                    //                   context,
                                    //                   widget.productid);
                                    //             },
                                    //             child: FxContainer(
                                    //               color: const Color(0xff1529e8)
                                    //                   .withAlpha(40),
                                    //               // paddingAll: controller
                                    //               //     .paddingAnimation.value,
                                    //               paddingAll: 9,

                                    //               child: Icon(
                                    //                 FeatherIcons.shoppingBag,
                                    //                 color:
                                    //                     const Color(0xff1529e8),
                                    //                 size: controller
                                    //                     .cartAnimation.value,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //           FxSpacing.width(10),
                                    //           FxContainer(
                                    //             onTap: controller.goToCheckout1,
                                    //             borderRadiusAll: 10,
                                    //             // padding: FxSpacing.xy(8, 4),
                                    //             padding: FxSpacing.xy(6, 10),
                                    //             color: const Color(0xff1529e8),
                                    //             child: FxText.bodyMedium(
                                    //               'CheckOut',
                                    //               fontWeight: 600,
                                    //               color: Colors.white,
                                    //             ),
                                    //           )
                                    //         ],
                                    //       )
                                    //     : const SizedBox()
                                  ],
                                )
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ));
    }
    return ListView(
      // physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      // padding: FxSpacing.nTop(20),
      padding: const EdgeInsets.only(top: 0, right: 20, left: 20, bottom: 0),
      children: list,
    );
  }

  Widget PrivateTransferexample(int i) {
    return Container(
      // height: 60,
      // width: double.infinity,
      // color: Colors.red,
      child: GridView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: controller
            .detailattraction!.first.activities![i].privateTransfers!.length,
        itemBuilder: (context, indexprivate) {
          return GestureDetector(
            onTap: () {
              setState(() {
                for (var element in controller
                    .detailattraction!.first.activities![i].privateTransfers!) {
                  element.isActive = false;
                }
                controller.detailattraction!.first.activities![i]
                    .privateTransfers![indexprivate].isActive = true;
              });
            },
            child: Container(
                decoration: BoxDecoration(
                    color: controller.detailattraction!.first.activities![i]
                            .privateTransfers![indexprivate].isActive
                        ? Colors.blue
                        : theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(8)),
                width: 50,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FxText.bodyMedium(
                      controller.detailattraction!.first.activities![i]
                          .privateTransfers![indexprivate].name
                          .toString(),
                      fontWeight: 900,
                      color: controller.detailattraction!.first.activities![i]
                              .privateTransfers![indexprivate].isActive
                          ? Colors.white
                          : Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FxText.bodyMedium(
                          'Seats:',
                          fontWeight: 600,
                          color: controller
                                  .detailattraction!
                                  .first
                                  .activities![i]
                                  .privateTransfers![indexprivate]
                                  .isActive
                              ? Colors.white
                              : Colors.black,
                        ),
                        FxText.bodyMedium(
                          controller.detailattraction!.first.activities![i]
                              .privateTransfers![indexprivate].maxCapacity
                              .toString(),
                          color: controller
                                  .detailattraction!
                                  .first
                                  .activities![i]
                                  .privateTransfers![indexprivate]
                                  .isActive
                              ? Colors.white
                              : Colors.black,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FxText.bodyMedium(
                          // 'Cost(1 person):',
                          'Cost:',
                          fontWeight: 600,
                          color: controller
                                  .detailattraction!
                                  .first
                                  .activities![i]
                                  .privateTransfers![indexprivate]
                                  .isActive
                              ? Colors.white
                              : Colors.black,
                        ),
                        FxText.bodyMedium(
                          controller.detailattraction!.first.activities![i]
                              .privateTransfers![indexprivate].price
                              .toString(),
                          color: controller
                                  .detailattraction!
                                  .first
                                  .activities![i]
                                  .privateTransfers![indexprivate]
                                  .isActive
                              ? Colors.white
                              : Colors.black,
                        ),
                      ],
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }

  Widget privatetransferwidget(int i) {
    return Container(
      height: 60,
      color: Colors.transparent,
      child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          // scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemCount: controller
              .detailattraction!.first.activities![i].privateTransfers!.length,
          itemBuilder: (context, indexprivate) {
            return Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        for (var element in controller.detailattraction!.first
                            .activities![i].privateTransfers!) {
                          element.isActive = false;
                        }
                        controller.detailattraction!.first.activities![i]
                            .privateTransfers![indexprivate].isActive = true;
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: controller
                                    .detailattraction!
                                    .first
                                    .activities![i]
                                    .privateTransfers![indexprivate]
                                    .isActive
                                ? Colors.blue
                                : theme.cardTheme.color,
                            borderRadius: BorderRadius.circular(8)),
                        width: 50,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FxText.bodyMedium(
                              controller.detailattraction!.first.activities![i]
                                  .privateTransfers![indexprivate].name
                                  .toString(),
                              fontWeight: 900,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FxText.bodyMedium(
                                  'Seats:',
                                  fontWeight: 600,
                                ),
                                FxText.bodyMedium(controller
                                    .detailattraction!
                                    .first
                                    .activities![i]
                                    .privateTransfers![indexprivate]
                                    .maxCapacity
                                    .toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FxText.bodyMedium(
                                  // 'Cost(1 person):',
                                  'Cost:',
                                  fontWeight: 600,
                                ),
                                FxText.bodyMedium(controller
                                    .detailattraction!
                                    .first
                                    .activities![i]
                                    .privateTransfers![indexprivate]
                                    .price
                                    .toString()),
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
                Expanded(child: Container())
              ],
            );
          }),
    );
  }

  // Widget privatetransferwidget(int i) {
  //   log('privatetransferwidget()');
  //   return SizedBox(
  //       height: 50,
  //       // decoration: BoxDecoration(
  //       //     color: theme.cardTheme.color,
  //       //     // color: const Color(0xff1529e8),
  //       //     borderRadius: BorderRadius.circular(8)),
  //       child: ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: controller.detailattraction!.first.activities![i]
  //               .privateTransfers!.length,
  //           // itemCount: 2,
  //           // scrollDirection: Axis.horizontal,
  //           itemBuilder: (context, indexprivate) {
  //             return Row(
  //               children: [
  //                 Expanded(
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       setState(() {
  //                         for (var element in controller.detailattraction!.first
  //                             .activities![i].privateTransfers!) {
  //                           element.isActive = false;
  //                         }
  //                         controller.detailattraction!.first.activities![i]
  //                             .privateTransfers![indexprivate].isActive = true;
  //                       });
  //                     },
  //                     child: Container(
  //                         decoration: BoxDecoration(
  //                             color: controller
  //                                     .detailattraction!
  //                                     .first
  //                                     .activities![i]
  //                                     .privateTransfers![indexprivate]
  //                                     .isActive
  //                                 ? Colors.blue
  //                                 : theme.cardTheme.color,
  //                             borderRadius: BorderRadius.circular(8)),
  //                         width: 50,
  //                         child: Padding(
  //                           padding: FxSpacing.y(5),
  //                           child: Column(
  //                             // mainAxisAlignment: MainAxisAlignment.start,
  //                             // crossAxisAlignment: CrossAxisAlignment.start,
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             crossAxisAlignment: CrossAxisAlignment.center,
  //                             children: [
  //                               FxText.bodyMedium(
  //                                 controller
  //                                     .detailattraction!
  //                                     .first
  //                                     .activities![i]
  //                                     .privateTransfers![indexprivate]
  //                                     .name
  //                                     .toString(),
  //                                 fontWeight: 900,
  //                               ),
  //                               Row(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 crossAxisAlignment: CrossAxisAlignment.center,
  //                                 children: [
  //                                   FxText.bodyMedium(
  //                                     'Seats:',
  //                                     fontWeight: 600,
  //                                   ),
  //                                   FxText.bodyMedium(controller
  //                                       .detailattraction!
  //                                       .first
  //                                       .activities![i]
  //                                       .privateTransfers![indexprivate]
  //                                       .maxCapacity
  //                                       .toString()),
  //                                 ],
  //                               ),
  //                               Row(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 crossAxisAlignment: CrossAxisAlignment.center,
  //                                 children: [
  //                                   FxText.bodyMedium(
  //                                     'Cost(1 person):',
  //                                     fontWeight: 600,
  //                                   ),
  //                                   FxText.bodyMedium(controller
  //                                       .detailattraction!
  //                                       .first
  //                                       .activities![i]
  //                                       .privateTransfers![indexprivate]
  //                                       .cost
  //                                       .toString()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                         )),
  //                   ),
  //                 ),
  //                 Expanded(child: Container())
  //               ],
  //             );
  //           }));
  // }

//alert
  showAlertDialog(index, List<SlotTime> timeSlotList) async {
    AlertDialog alert = AlertDialog(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: FxText(
            "Select Time Slot",
            fontWeight: 700,
            textAlign: TextAlign.center,
            // color: Colors.white,
            color: const Color(0xff1529e8),
            // textAlign: TextAlign.center,
            // style: TextStyle(color: Colors.white),
          ),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Expanded(
                      flex: 14,
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int preIndex) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                for (var element in timeSlotList) {
                                  if (element.eventId ==
                                      timeSlotList[preIndex].eventId) {
                                    if (int.parse(
                                            timeSlotList[preIndex].available) ==
                                        0) {
                                      element.isSelected = false;
                                    } else {
                                      element.isSelected = true;
                                    }
                                    element.isSelected = true;
                                    if (element.isSelected == true) {
                                      controller.listSLotDetails.add(element);
                                    }
                                  } else {
                                    element.isSelected = false;
                                    log('isSele:${element.isSelected} ');
                                  }
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      timeSlotList[preIndex].isSelected == false
                                          ? const Color(0xffB9DDFF)
                                          : Colors.green
                                  // color:
                                  //     (timeSlotList[preIndex].isSelected == false
                                  //         ? int.parse(timeSlotList[preIndex]
                                  //                     .available) >=
                                  //                 10
                                  //             ? Colors.blueGrey
                                  //             : int.parse(timeSlotList[preIndex]
                                  //                         .available) ==
                                  //                     0
                                  //                 ? Colors.red
                                  //                 : Colors.yellow
                                  //         : Colors.green),
                                  ),
                              // width: 100,
                              // height: 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: FxText.bodyMedium(
                                          getFormattedDate(
                                              timeSlotList[preIndex]
                                                  .startDateTime
                                                  .toString()),
                                          color: Colors.black,
                                          fontWeight: 600,
                                        ),
                                      ),
                                      FxText.bodyMedium(
                                        '-',
                                        color: Colors.black,
                                        fontWeight: 600,
                                      ),
                                      Expanded(
                                        child: FxText.bodyMedium(
                                          getFormattedDate(
                                              timeSlotList[preIndex]
                                                  .endDateTime
                                                  .toString()),
                                          color: Colors.black,
                                          fontWeight: 600,
                                        ),
                                      )
                                    ],
                                  ),

                                  // Text(timeSlotList[preIndex].startDateTime.toString().substring(11, 16) + "-"+"${timeSlotList[preIndex].endDateTime.toString().substring(11, 16)}",
                                  //   style:TextStyle(color:Colors.white),),

                                  Column(
                                    children: [
                                      FxText.bodyMedium(
                                        "Adult Cost",
                                        color: Colors.black,
                                        fontWeight: 600,
                                      ),
                                      FxText.bodyMedium(
                                        '${timeSlotList[preIndex].adultPrice} AED',
                                        // "${timeSlotList[preIndex].adultPrice * widget.conversionRate} ${widget.currencySymbol}",
                                        color: Colors.black,
                                        fontWeight: 600,
                                      ),
                                      FxText.bodyMedium(
                                        "Child Cost",
                                        color: Colors.black,
                                        fontWeight: 600,
                                      ),
                                      FxText.bodyMedium(
                                        '${timeSlotList[preIndex].childPrice} AED',
                                        color: Colors.black,
                                        fontWeight: 600,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: timeSlotList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1.05
                                // childAspectRatio: 1.17
                                // childAspectRatio: 3 / 4
                                ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff1529e8),
                                ),
                                onPressed: () {
                                  setState(() {
                                    controller
                                            .detailattraction!
                                            .first
                                            .activities![index]
                                            .activityTimeSlot =
                                        controller.listSLotDetails.last;
                                    // controller.detailattraction!.first.activities[index].activityTimeSlot
                                    //     !.add(activitycontroller
                                    //         .listSLotDetails.last);
                                  });
                                  // activitiesListTime.add(listSLotDetails.last);
                                  // log(activitiesListTime);
                                  log('Apply Date:${controller.listSLotDetails.last.endDateTime}');
                                  log('Apply Default DateL:${controller.detailattraction!.first.activities![index].activityTimeSlot!.endDateTime}');

                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Apply",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                ));
          },
        ));

    // show the dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    setState(() {});
  }

  String timeconverted(String startEnd) {
    // void timeconverted() {
    var result = startEnd;
    // String originalDateTime = '2023-08-20T17:45:00';

    String originalDateTime = result;
    // String originalDateTime = '2023-06-30T17:45:00';
    // String originalDateTime = '2023-06-30T18:15:00';

    DateTime parsedDateTime = DateTime.parse(originalDateTime);
    String formattedTime = DateFormat('HH:mm:ss').format(parsedDateTime);

    log('formattedTime:$formattedTime');

    String originalTime = formattedTime;

    DateTime parsedTime = DateFormat('HH:mm:ss').parseStrict(originalTime);
    String formattedAMPN = DateFormat('h:mm a').format(parsedTime);

    log('Start and End:$formattedAMPN');
    return result;
  }

  // //expad
  //       Widget overviewExpand() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20),
  //     child: ExpandableNotifier(
  //         child: ScrollOnExpand(
  //       child: Card(
  //         elevation: 0,
  //         color: theme.cardTheme.color,
  //         clipBehavior: Clip.antiAlias,
  //         child: ExpandablePanel(
  //           theme: const ExpandableThemeData(
  //             iconColor: Colors.grey,
  //           ),
  //           header: Padding(
  //             padding: const EdgeInsets.all(10),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 FxText.bodyMedium(
  //                   'Description',
  //                  fontWeight: 900,
  //                 ),
  //               ],
  //             ),
  //           ),
  //           collapsed: Container(),
  //           expanded: Padding(
  //               padding: EdgeInsets.all(15),
  //               child: ListView.builder(
  //                   shrinkWrap: true,
  //                   physics: const NeverScrollableScrollPhysics(),
  //                   itemCount:1,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.only(left: 10),
  //                           child: Text(
  //                            controller.detailattraction.first.sections.,
  //                             style: RegularTextStyle.regular14400(backColor),
  //                           ),
  //                         ),
  //                         Html(
  //                           data: detailAttractionResponse
  //                               .attraction!.sections![index].body,
  //                           style: {
  //                             "p": Style(
  //                               fontFamily: "LexendLight",
  //                               color: expandTextColor,
  //                               fontSize: const FontSize(14),
  //                               fontWeight: FontWeight.w300,
  //                             )
  //                           },
  //                         ),
  //                       ],
  //                     );
  //                   })),
  //         ),
  //       ),
  //     )),
  //   );
  // }

  Widget detailwidget() {
    return ListView(
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
                  itemCount: controller.detailattraction!.first.images!.length,
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
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            imageUrl:
                                'https://secure.mytravellerschoice.com${controller.detailattraction!.first.images![index]}',
                            imageBuilder: (context, imageProvider) => Container(
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
                              capitalizeAllWord(controller.detailattraction!
                                  .first.category!.categoryName!),
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
                        controller.detailattraction!.first.isOffer == false
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
                        splashColor: const Color(0xff1529e8).withAlpha(100),
                        highlightColor: const Color(0xff1529e8).withAlpha(20),
                        child: SizedBox(
                            width: 44,
                            height: 44,
                            child: Icon(
                              MdiIcons.shareOutline,
                              size: 22,
                              color: const Color(0xff1529e8).withAlpha(240),
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
                                highlightColor:
                                    const Color(0xff1529e8).withAlpha(20),
                                splashColor:
                                    const Color(0xff1529e8).withAlpha(100),
                                child: SizedBox(
                                    width: 44,
                                    height: 44,
                                    child: Icon(
                                      // MdiIcons.heartOutline,
                                      isSelected
                                          ? MdiIcons.heart
                                          : MdiIcons.heartOutline,
                                      color: controller.colorAnimation.value,
                                      size: controller.sizeAnimation.value,

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
                                      favouriteList.remove(widget.productdatum);
                                    } else {
                                      favouriteList.add(widget.productdatum);
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
                                    favouriteList.add(widget.productdatum);
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
                                      await SharedPreferences.getInstance();
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
          padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
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
                              controller.detailattraction!.first.averageRating
                                  .toStringAsFixed(1),
                              fontWeight: 700),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 4),
                            child: FxStarRating(
                                rating: controller
                                        .detailattraction!.first.averageRating
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

        //tour options
        // Container(
        //   padding: const EdgeInsets.all(16),
        //   child: Column(
        //     children: [
        //       FxText.titleMedium('Tour Options',
        //           fontWeight: 600, letterSpacing: 0),
        //       _buildCartList()
        //     ],
        //   ),
        // ),
        //  GridView.builder(
        //   scrollDirection: Axis.vertical,
        //   shrinkWrap: true,
        //   physics: const AlwaysScrollableScrollPhysics(),
        //   itemBuilder: (BuildContext context, int preIndex) {
        //     return Container(
        //       padding: const EdgeInsets.all(5),
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(5),
        //           color: const Color(0xffB9DDFF),

        //       ),
        //       child:  Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //  smallCardsAvailable(
        //           'availability', 'daily', Icons.calendar_today),
        //       smallCardsAvailable(
        //           'Duration', '1 hour', Icons.access_time_rounded),
        //       smallCardsAvailable('TimeSlot', '00:00-22:00', Icons.sunny),
        //       smallCardsAvailable(
        //           '', 'Instant Confirmation', Icons.flash_on_outlined),
        //       smallCardsAvailable('Free Cancellation', '24 hours',
        //           Icons.edit_calendar_outlined),
        //         ],
        //       ),

        //     );
        //   },
        //   itemCount: 1,
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 3,
        //       crossAxisSpacing: 10,
        //       mainAxisSpacing: 10,
        //       childAspectRatio: 1.17
        //       // childAspectRatio: 3 / 4
        //       ),
        // ),

        // SizedBox(
        //   height: 110,
        //     child: ListView.separated(
        //   itemCount: 1,
        //   shrinkWrap: true,

        //   separatorBuilder: (context, index) {
        //     return FxSpacing.width(6);
        //   },
        //   itemBuilder: (context, index) {
        //     return Row(
        //       children: [
        //         smallCardsAvailable(
        //             'availability', 'daily', Icons.calendar_today),
        //         smallCardsAvailable(
        //             'Duration', '1 hour', Icons.access_time_rounded),
        //         smallCardsAvailable('TimeSlot', '00:00-22:00', Icons.sunny),
        //         smallCardsAvailable(
        //             '', 'Instant Confirmation', Icons.flash_on_outlined),
        //         smallCardsAvailable('Free Cancellation', '24 hours',
        //             Icons.edit_calendar_outlined),
        //       ],
        //     );
        //   },
        // )),

        Padding(
          padding: const EdgeInsets.only(bottom: 2, left: 16, right: 16),
          child: FxText.titleMedium(
            'Tour Options',
            fontWeight: 900,
            letterSpacing: 0,
            color: const Color(0xff1529e8),
          ),
        ),
        _buildCartList(),
        // TourWidgets(controller.detailattraction!.first,widget.productid),

        // details
        Container(
          // padding: const EdgeInsets.all(32.0),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: Color(0xfff5f5f5),
            // color: Colors.red
          ),
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
              availabilityExpand(),
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
                        color: theme.colorScheme.onBackground.withAlpha(180),
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
                      //             'Lorem Ipsum is simply dummy text of the loging and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown loger took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
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
                          ? SizedBox(
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        data: controller.detailattraction!.first
                                            .itineraryDescription,
                                      ),
                                FxSpacing.height(40)
                              ],
                            ))

                          // FxText.bodyMedium(
                          //     'Lorem Ipsum is simply dummy text of the loging and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown loger took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                          //     // color: theme.colorScheme.onPrimary,
                          //     // color: Colors.black,
                          //     letterSpacing: 0.4,
                          //     fontSize: 11,
                          //   )
                          : SizedBox(
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    data: controller.detailattraction!.first
                                        .sections![index].body),
                                FxSpacing.height(40)
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
                        data: controller.detailattraction!.first.highlights,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                              color:
                                  theme.colorScheme.onBackground.withAlpha(180),
                              height: 1.2,
                            );
                          },
                          itemCount:
                              controller.detailattraction!.first.faqs!.length)
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

              const SizedBox(height: 10.0),
            ],
          ),
        ),
        FxSpacing.height(40)
      ],
    );
  }

  Widget dropdownwidget(int i) {
    ///transfr
    List<String> tempTransferCodes = [];
    bool? isPrivate = controller
        .detailattraction!.first.activities![i].isPrivateTransferAvailable;
    bool? isShared = controller
        .detailattraction!.first.activities![i].isSharedTransferAvailable;

    log("TransferCode Private => $isPrivate Shared => $isShared");
    if (((isPrivate != null && !isPrivate) &&
            (isShared != null && !isShared)) ||
        ((isPrivate != null && isPrivate) && (isShared != null && isShared))) {
      if (!tempTransferCodes.contains("without")) {
        tempTransferCodes.add("without");
      }
    }
    if (isPrivate != null && isPrivate) {
      if (!tempTransferCodes.contains("private")) {
        tempTransferCodes.add("private");
      }
    }
    if (isShared != null && isShared) {
      if (!tempTransferCodes.contains("shared")) {
        tempTransferCodes.add("shared");
      }
    }

    controller.TransferCodes = tempTransferCodes;

    log("TransferCode =>   ${controller.TransferCodes}");

    return Container(
      decoration: BoxDecoration(
          color: theme.cardTheme.color,
          // color: const Color(0xff1529e8),
          borderRadius: BorderRadius.circular(8)),
      height: 50,
      width: 150,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: [
              Expanded(
                  child: FxText.labelLarge(
                // activitycontroller.TransferCodes[0],

                'Select Transfer',
                fontWeight: 600,
                color: Colors.black,
                letterSpacing: 0.4,
              )),
            ],
          ),
          value: controller.detailattraction!.first.activities![i].transferCode
          // ??
          //     activitycontroller.TransferCodes[0]
          /*controller.detailattraction!.first.activities[i].isSharing
              ? activitycontroller.TransferCodes[2]
              : controller.detailattraction!.first.activities[i].isPrivate
                  ? activitycontroller.TransferCodes[1]
                  : activitycontroller.TransferCodes[0]*/
          ,
          items: controller.TransferCodes.map((String value) {
            return DropdownMenuItem<String>(
                value: value,
                // value: value == 'without' ? 'Without Transfer' : value,
                child: Center(
                  child: Text(
                    // value,
                    value == 'without' ? 'Without Transfer' : value,
                    style: FxTextStyle.bodyMedium(),
                  ),
                ));
          }).toList(),
          onChanged: (value) {
            setState(() {
              controller.detailattraction!.first.activities![i].transferCode =
                  value.toString();
              log('Transfer:${controller.selectedtransfer}');
            });
            controller.addisPrivateORsharing(
                controller.detailattraction!.first.activities![i],
                isPrivate: controller
                        .detailattraction!.first.activities![i].transferCode ==
                    "private",
                isSharing: controller
                        .detailattraction!.first.activities![i].transferCode ==
                    "shared");
          },
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 20,
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.black,
          buttonHeight: 30,
          buttonWidth: 200,
          buttonPadding:
              const EdgeInsets.only(left: 14, right: 14, top: 4, bottom: 4),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: theme.cardTheme.color,
          ),
          itemHeight: 40,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownPadding: null,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 2,
          scrollbarAlwaysShow: true,
          offset: const Offset(0, 0),
        ),
      ),
    );
  }

  String getFormattedDate(String date) {
    //selectedslotdate
    // DateTime now = date;

    // String formattedSlotDate = DateFormat.yMMMd().format(now);
    // log('formattedSlotDate:$formattedSlotDate');
    // log('Start Time:${controller.customSlots!.event!.startDateTime}');
    String StartTime = date;

    // String StartTime=date;
    DateTime parsedStartTime = DateTime.parse(StartTime);
    String formattedStartTime = DateFormat('HH:mm:ss').format(parsedStartTime);

    log('formattedTime:$formattedStartTime');

    String originalStartTime = formattedStartTime;

    DateTime parsedTimeStart =
        DateFormat('HH:mm:ss').parseStrict(originalStartTime);
    String formattedStartAMPN = DateFormat('h:mm a').format(parsedTimeStart);

    log('Start:$formattedStartAMPN');
    // log('currentSlot!.length:${currentSlot!.length}');

    return formattedStartAMPN;
  }

  Widget _buildSelect1() {
    if (controller.selectedtour.isNotEmpty) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey.shade300, width: 1)),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: FxText.bodyMedium(
                    '${controller.selectedtour.length} Selected',
                    fontWeight: 800,
                  )),
                  FxText.bodyLarge(
                    // controller.selectedtour.first.GrandTotalAmount.toString(),
                    // '${controller.grandSelectedTourAmount().toString()} AED',
                    '${((controller.grandSelectedTourAmount() * conversionRate) as double).toStringAsFixed(2)} $currencySymbol',

                    fontWeight: 700,
                    color: const Color(0xff1529e8),
                  ),
                ],
              )
            ],
          ));
    } else {
      return const SizedBox();
    }
  }

  Widget _buildnew() {
    log("currencysymbol detail $currencySymbol");
    log("currencysymbol detail $conversionRate");

    // log("currencysymbol detail ${widget.conversionRate}");
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
          key: controller.snackkey,
          backgroundColor: const Color(0xfff5f5f5),
          // bottomNavigationBar: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
          //   child: FxButton.block(
          //     onPressed: () {
          //       controller.bookNow(
          //           controller.detailattraction!.first, widget.productid);
          //       // cartController.carts.add(Cart());
          //     },
          //     backgroundColor: const Color(0xff1529e8),
          //     // backgroundColor: customTheme.estatePrimary,
          //     borderRadiusAll: 12,

          //     elevation: 0,
          //     child: FxText.bodyMedium(
          //       'View package',
          //       color: Colors.white,
          //       // color: customTheme.estateOnPrimary,
          //       fontWeight: 700,
          //     ),
          //   ),
          // ),

          body: Stack(children: [
            detailwidget(),
            // widget.productid == '63ff12f5d7333637a938cad4' &&
            //         controller.listSLotDetails.last == null
            //     // &&  controller.        detailattraction!
            //     //         .map((e) =>
            //     //             e.activities!.map((e) => e.activityTimeSlot == null))
            //     //         .toList() ==
            //     //     null
            //     ? const Text('i')
            //     :
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: FxSpacing.xy(12, 8),
                child: PhysicalModel(
                  color: theme.cardTheme.color!.withAlpha(200),
                  elevation: 12,
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                  shadowColor: theme.colorScheme.onBackground.withAlpha(12),
                  shape: BoxShape.rectangle,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.cardTheme.color!.withAlpha(200),
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                    ),
                    padding: FxSpacing.xy(16, 12),
                    child: Column(
                      children: <Widget>[
                        // _buildSelect1(),
                        Row(
                          children: [
                            AnimatedBuilder(
                              animation: controller.cartController,
                              builder: (BuildContext context, _) {
                                return GestureDetector(
                                  onTap: controller.selectedtour.isEmpty
                                      ? null
                                      : () async {
                                          bool existing = false;

                                          log('Fav Item Slot:${favouriteListCart.map((e) => e.sId)}');

                                          log(
                                              "controller.selectedtour ${controller.selectedtour}");

                                          favouriteListCart
                                              .addAll(controller.selectedtour);

                                          /*SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.setBool("youKey", isSelected);
                                          setState(() {
                                            favouriteListCart;
                                            isSelected = !isSelected;
                                          });*/ //fav
                                          setState(() {
                                            favouriteListCart;
                                          });
                                          bool? isHasCheckout;
                                          /*  if (controller.detailattraction != null) {
                                      for (var activity in controller
                                          .detailattraction!
                                          .first
                                          .activities!) {
                                        if (controller.selectedtour
                                            .contains(activity)) {
                                          int i = controller.selectedtour
                                              .indexOf(activity);
                                          if (controller.selectedtour[i]
                                                  .selectedDate !=
                                              null) {
                                            isHasCheckout = true;
                                          } else {
                                            isHasCheckout = false;
                                          }
                                        }
                                      }
                                    } */
                                          bool isBurjkhalifa =
                                              widget.productid ==
                                                  '63ff12f5d7333637a938cad4';
                                          if (isBurjkhalifa) {
                                            for (var e
                                                in controller.selectedtour) {
                                              if (e.activityTimeSlot != null) {
                                                isHasCheckout ??= true;
                                                isHasCheckout = isHasCheckout
                                                    ? true
                                                    : false;
                                              } else {
                                                isHasCheckout ??= false;
                                                isHasCheckout = false;
                                              }
                                            }
                                          } else {
                                            for (var e
                                                in controller.selectedtour) {
                                              log("Selected Date => ${e.selectedDate}");
                                              if (e.selectedDate != null) {
                                                isHasCheckout ??= true;
                                                isHasCheckout = isHasCheckout
                                                    ? true
                                                    : false;
                                              } else {
                                                isHasCheckout ??= false;
                                                isHasCheckout = false;
                                              }
                                            }
                                          }
                                          log('Selected Date:${controller.selectedtour.map((e) => e.selectedDate).toList()}');

                                          !isHasCheckout!
                                              ? CustomSnackbar.show(
                                                  context: context,
                                                  message: isBurjkhalifa
                                                      ? 'Select Your Tour time slots'
                                                      : 'Select Your Tour date',
                                                  backgroundColor:
                                                      const Color(0xff1529e8),
                                                  duration: const Duration(
                                                      seconds: 2),
                                                )

                                              // controller.selectedtour.first
                                              //                 .selectedDate ==
                                              //             null &&
                                              //         controller.selectedtour.isEmpty
                                              //     ? CustomSnackbar.show(
                                              //         context: context,
                                              //         message: 'Select Your Tour date',
                                              //         backgroundColor:
                                              //             const Color(0xff1529e8),
                                              //         duration:
                                              //             const Duration(seconds: 2),
                                              //       )
                                              : controller.goToCheckout(context,
                                                  widget.productid, controller);
                                        },
                                  child: Stack(
                                    children: [
                                      FxContainer(
                                        color: const Color(0xff1529e8)
                                            .withAlpha(40),
                                        paddingAll:
                                            controller.paddingAnimation.value,
                                        child: Icon(
                                          FeatherIcons.shoppingBag,
                                          color: const Color(0xff1529e8),
                                          size: controller.cartAnimation.value,
                                        ),
                                      ),
                                      // controller.addCart
                                      //     ?
                                      Positioned(
                                        right: 10,
                                        top: 8,
                                        child: FxContainer.rounded(
                                          color: const Color(0xff1529e8),
                                          paddingAll: 4,
                                          child: FxText.bodySmall(
                                            controller.selectedtour.length
                                                .toString(),
                                            color: theme.colorScheme.onPrimary,
                                            fontSize: 8,
                                            fontWeight: 700,
                                          ),
                                        ),
                                      )
                                      // : Container(),
                                    ],
                                  ),
                                );
                              },
                            ),
                            FxSpacing.width(20),
                            Expanded(
                              //fadeanim
                              child: FxButton.block(
                                  onPressed: controller.selectedtour.isEmpty
                                      ? null
                                      : () async {
                                          // widget.productid ==
                                          //         '63ff12f5d7333637a938cad4'
                                          //     ? log(
                                          //         'TimeSlot:${controller.listSLotDetails.last}')
                                          //     : log('No Picked');

                                          bool? isHasCheckout;
                                          /*  if (controller.detailattraction != null) {
                                      for (var activity in controller
                                          .detailattraction!
                                          .first
                                          .activities!) {
                                        if (controller.selectedtour
                                            .contains(activity)) {
                                          int i = controller.selectedtour
                                              .indexOf(activity);
                                          if (controller.selectedtour[i]
                                                  .selectedDate !=
                                              null) {
                                            isHasCheckout = true;
                                          } else {
                                            isHasCheckout = false;
                                          }
                                        }
                                      }
                                    } */
                                          bool isBurjkhalifa =
                                              widget.productid ==
                                                  '63ff12f5d7333637a938cad4';
                                          if (isBurjkhalifa) {
                                            for (var e
                                                in controller.selectedtour) {
                                              if (e.activityTimeSlot != null) {
                                                isHasCheckout ??= true;
                                                isHasCheckout = isHasCheckout
                                                    ? true
                                                    : false;
                                              } else {
                                                isHasCheckout ??= false;
                                                isHasCheckout = false;
                                              }
                                            }
                                          } else {
                                            for (var e
                                                in controller.selectedtour) {
                                              log("Selected Date => ${e.selectedDate}");
                                              if (e.selectedDate != null) {
                                                isHasCheckout ??= true;
                                                isHasCheckout = isHasCheckout
                                                    ? true
                                                    : false;
                                              } else {
                                                isHasCheckout ??= false;
                                                isHasCheckout = false;
                                              }
                                            }
                                          }
                                          log('Selected Date:${controller.selectedtour.map((e) => e.selectedDate).toList()}');
                                          // controller.selectedtour[i].selectedDate ==
                                          //             null &&
                                          //         controller.selectedtour.isEmpty
                                          // controllerTE[index].text.isNotEmpty
                                          !isHasCheckout!
                                              ? CustomSnackbar.show(
                                                  context: context,
                                                  message: isBurjkhalifa
                                                      ? 'Select Your Tour time slots'
                                                      : 'Select Your Tour date',
                                                  backgroundColor:
                                                      const Color(0xff1529e8),
                                                  duration: const Duration(
                                                      seconds: 2),
                                                )
                                              : await showModalBottomSheet(
                                                  context: context,
                                                  builder: (BuildContext
                                                      buildContext) {
                                                    return SelectedTourBottomSheet(
                                                      // pid: widget.productid,

                                                      // //  _toggleFavorite, _isMealFavorite,
                                                      // Datas: widget.productdatum,
                                                      // ProductSlug: widget.productSlug,
                                                      len: controller
                                                          .selectedtour.length,
                                                      controller: controller,

                                                      Option: controller
                                                          .selectedtour,
                                                      textdate: controller
                                                          .dateTE.text,
                                                      Transfer: controller
                                                          .selectedtransfer,
                                                      totalAmount: controller
                                                          .grandSelectedTourAmount(),
                                                      // Total: controller
                                                      //     .grandSelectedTourAmount()
                                                    );
                                                  });
                                          setState(() {});
                                          // : controller.goToCheckout1();
                                          //       var data = await showModalBottomSheet(
                                          // context: context,
                                          // builder: (BuildContext buildContext) {
                                          //   return CategoriesBottomSheet(
                                          //     categoryplace: widget.place,
                                          //   );
                                          // });
                                        },
                                  backgroundColor: const Color(0xff1529e8),
                                  // backgroundColor: theme.colorScheme.primary,
                                  elevation: 0,
                                  borderRadiusAll: 4,
                                  child: Row(
                                    children: [
                                      Image(
                                        height: 22,
                                        width: 22,
                                        color: theme.colorScheme.onPrimary,
                                        image: const AssetImage(
                                            'assets/images/apps/shopping2/icons/clear_cart_outline.png'),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: FxText.bodyMedium(
                                            'Checkout',
                                            fontWeight: 600,
                                            color: theme.colorScheme.onPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]),
        );
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
