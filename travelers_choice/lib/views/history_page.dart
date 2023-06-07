import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/models/order_attraction_modal.dart';
import 'package:hotel_travel/services/attraction_Service.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/history_controller.dart';
import '../models/tickets.dart';
import '../services/app_constants.dart';
import '../theme/app_theme.dart';
import 'bottomSheet/filter_bookings.dart';
import 'bottomSheet/sort_allbooking.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;
  // late OutlineInputBorder outlineInputBorder;
  late HistoryController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = FxControllerStore.put(HistoryController(this));
    theme = AppTheme.shoppingTheme;
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        controller.token =
            sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN)!;
        log("auth token ${controller.token!}");
      });
      fetchData();
      // AttractionService().getAttractionOrders(context,);
    });
    // VisaService().getSelectVisa(widget.place.id);
    // fetchData();
    // theme = AppTheme.shoppingTheme;

    // outlineInputBorder = const OutlineInputBorder(
    //     borderSide: BorderSide(
    //         color: Color(0xff1529e8),
    //         // color: Colors.lightBlueAccent,
    //         width: 0));
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

  fetchData() {
    Future.delayed(Duration.zero, () async {
      await getOrder(context).then((value) {
        if (value) {
          isLoading = false;
          setState(() {});
        }
      });
    });
  }

  AllAttractionOrders? orders;
  bool isOrdersLoading = true;
  Future getOrder(context) async {
    isOrdersLoading = true;
    try {
      var data = await AttractionService()
          .getAttractionOrders(controller.token!, context);
      if (data != null) {
        setState(() {});
        // countryList.add(data);
        orders = data;

        isOrdersLoading = false;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  bool disableCard = false;
  List<String> lastString = [
    "Policy",
    "Terms and settings",
    "Partners",
    "About"
  ];
  String searchText = "";

//   Widget attrctionHistory(){
// if(controller.token==null){

// }
// else{
//   return
// }
//   }

  Widget _buildflightList() {
    log('calling flight');
    List<Widget> list = [];

    for (Tickets ticket1 in controller.tickets!) {
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 500,
              height: 200,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              child: Column(
                children: <Widget>[
                  Row(
                    children: const [
                      Icon(Icons.airplane_ticket_sharp,
                          color: Colors.green, size: 35),
                      SizedBox(width: 10),
                      Text("USA Airways",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold)),
                      SizedBox(width: 50),
                      Text("\$999",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _itemDepartment(),
                      _locationPlane(),
                      _itemDepartment2()
                    ],
                  )
                ],
              ),
            )),
      ));
    }

    return Column(
      children: list,
    );
  }

  Widget attractionList() {
    if (orders == null) {
      log('You have no attractions orders');
      return const Text("You have no attractions orders");
    } else {
      if (orders!.result == null) {
        log('You have no attractions');
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              // Lottie.asset('assets/lottie/confirmation.json',
              //     height: 300, width: 300),
              Text('No Order History!!',
                  style: TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16))
            ],
          ),
        );
        // return const Text("You have no attractions");
      }
      String? orderlength;
      orderlength = orders!.result!.totalOrders.toString();
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  // padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        // color: Colors.grey.shade400,
                        color: const Color(0xff1529e8).withOpacity(0.4),
                        blurRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    style: FxTextStyle.bodyMedium(),
                    controller: controller.SearchTE,
                    cursorColor: theme.colorScheme.primary,

                    //2
                    onChanged: (value) {},

                    decoration: InputDecoration(
                      hintText: "Search your Order ...",
                      hintStyle: FxTextStyle.bodySmall(
                          color: theme.colorScheme.onBackground),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      filled: true,
                      // fillColor: const Color(0xffcfd2ff),
                      fillColor: theme.cardTheme.color,
                      prefixIcon: Icon(
                        FeatherIcons.search,
                        size: 16,
                        color: theme.colorScheme.onBackground.withAlpha(150),
                      ),
                      isDense: true,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
              ),
              FxSpacing.width(4),
              FxContainer(
                paddingAll: 12,
                borderRadiusAll: 4,
                onTap: () async {
                  var data = await showModalBottomSheet(
                      context: context,
                      builder: (BuildContext buildContext) {
                        return const SortAllBooking();
                      });
                  setState(() {});
                },
                color: const Color(0xff1529e8).withAlpha(40),
                child: const Icon(
                  Iconsax.sort,
                  color: Color(0xff1529e8),
                  size: 20,
                ),
              ),
              FxSpacing.width(4),
              FxContainer(
                paddingAll: 12,
                borderRadiusAll: 4,
                onTap: () async {
                  var data = await showModalBottomSheet(
                      context: context,
                      builder: (BuildContext buildContext) {
                        return const FilterAllBooking();
                      });
                  setState(() {});
                },
                color: const Color(0xff1529e8).withAlpha(40),
                child: const Icon(
                  FeatherIcons.sliders,
                  color: Color(0xff1529e8),
                  size: 20,
                ),
              ),
            ],
          ),
          FxSpacing.height(20),
          Expanded(
            child: ListView.builder(
              // itemCount: orderlength.length,
              // itemCount: orders!.result!.totalOrders,
              itemCount: orders!.result!.data!.length,
              itemBuilder: (BuildContext context, int index) {
                // log('Order Length history:${orderlength!.length}');
                var date = orders!.result!.data![index].activities!.date;
                var newDate = date!.toLocal().toString().substring(0, 10);
                print(newDate);
                return FxContainer(
                  margin: FxSpacing.bottom(20),
                  borderRadiusAll: 4,
                  color: Colors.white,
                  paddingAll: 12,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FxText.bodyLarge(
                                'Status:',

                                // textAlign: TextAlign.left,
                                letterSpacing: 0,
                                fontWeight: 600,
                              ),
                              FxSpacing.width(10),
                              FxText.bodyLarge(
                                orders!.result!.data![index].activities!.status
                                    .toString(),
                                color: orders!.result!.data![index].activities!
                                            .status ==
                                        'confirmed'
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: 600,
                                // color: const Color(0xff1529e8),
                              )
                            ]),
                      ),
                      FxSpacing.height(10),
                      FxDashedDivider(
                        dashSpace: 4,
                        dashWidth: 8,
                        color: theme.colorScheme.onBackground.withAlpha(180),
                        height: 1.2,
                      ),
                      FxSpacing.height(10),
                      Row(
                        children: [
                          FxContainer(
                            paddingAll: 0,
                            borderRadiusAll: 4,
                            height: MediaQuery.of(context).size.height * 0.11,
                            width: MediaQuery.of(context).size.width * 0.2,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: CachedNetworkImage(
                              height: MediaQuery.of(context).size.height * 0.11,
                              width: MediaQuery.of(context).size.width * 0.2,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                  value: progress.progress,
                                ),
                              ),
                              imageUrl:
                                  'https://a.walletbot.online${orders!.result!.data![index].attraction!.images!.first}',
                            ),
                          ),
                          FxSpacing.width(10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FxText.titleMedium(
                                  orders!.result!.data![index].activities!
                                      .activity!.name!,
                                  fontWeight: 700,
                                ),
                                FxSpacing.height(8),
                                FxText.bodyMedium(
                                  '${orders!.result!.data![index].totalAmount.toString()} AED',
                                  fontWeight: 700,
                                ),
                                FxSpacing.height(8),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    FxText.bodyMedium(
                                      'Pax',
                                      fontWeight: 600,
                                    ),
                                    FxSpacing.width(7),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: FxContainer(
                                              padding: FxSpacing.fromLTRB(
                                                  5, 6, 1, 6),
                                              color: const Color(0xff1529e8)
                                                  .withAlpha(40),
                                              child: Row(
                                                children: [
                                                  FxText.bodyMedium(
                                                      orders!
                                                          .result!
                                                          .data![index]
                                                          .activities!
                                                          .adultsCount!
                                                          .toString(),
                                                      color: const Color(
                                                          0xff1529e8),
                                                      // color: customTheme.groceryPrimary,
                                                      fontWeight: 500,
                                                      letterSpacing: -0.2),
                                                  FxSpacing.width(2),
                                                  FxText.bodyMedium('Adult',
                                                      color: const Color(
                                                          0xff1529e8),
                                                      // color: customTheme.groceryPrimary,
                                                      fontWeight: 500,
                                                      letterSpacing: -0.2),
                                                ],
                                              ),
                                            ),
                                          ),
                                          FxSpacing.width(8),
                                          Expanded(
                                            child: FxContainer(
                                              padding: FxSpacing.fromLTRB(
                                                  5, 6, 1, 6),
                                              color: const Color(0xff1529e8)
                                                  .withAlpha(40),
                                              child: Row(
                                                children: [
                                                  FxText.bodyMedium(
                                                      orders!
                                                          .result!
                                                          .data![index]
                                                          .activities!
                                                          .childrenCount!
                                                          .toString(),
                                                      color: const Color(
                                                          0xff1529e8),
                                                      // color: customTheme.groceryPrimary,
                                                      fontWeight: 500,
                                                      letterSpacing: -0.2),
                                                  FxSpacing.width(2),
                                                  FxText.bodyMedium('Child',
                                                      color: const Color(
                                                          0xff1529e8),
                                                      // color: customTheme.groceryPrimary,
                                                      fontWeight: 500,
                                                      letterSpacing: -0.2),
                                                ],
                                              ),
                                            ),
                                          ),
                                          FxSpacing.width(8),
                                          Expanded(
                                            child: FxContainer(
                                              padding: FxSpacing.fromLTRB(
                                                  5, 6, 1, 6),
                                              color: const Color(0xff1529e8)
                                                  .withAlpha(40),
                                              child: Row(
                                                children: [
                                                  FxText.bodyMedium(
                                                      orders!
                                                          .result!
                                                          .data![index]
                                                          .activities!
                                                          .infantCount
                                                          .toString(),
                                                      color: const Color(
                                                          0xff1529e8),
                                                      // color: customTheme.groceryPrimary,
                                                      fontWeight: 500,
                                                      letterSpacing: -0.2),
                                                  FxSpacing.width(2),
                                                  FxText.bodyMedium('Infant',
                                                      color: const Color(
                                                          0xff1529e8),
                                                      // color: customTheme.groceryPrimary,
                                                      fontWeight: 500,
                                                      letterSpacing: -0.2),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                FxText.bodyMedium(
                                  "Date: $newDate",
                                  fontWeight: 700,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  Widget visaList() {
    return ListView(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FxText.bodyMedium(
              "30 days single entry visa",
              fontWeight: 700,
            ),
            const SizedBox(
              height: 5,
            ),
            FxText.bodyMedium(
              "285 AED",
              fontWeight: 700,
            ),
            const SizedBox(
              height: 5,
            ),
            FxText.bodyMedium(
              "Date: 02/02/2022",
              fontWeight: 700,
            )
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FxText.bodyMedium(
              "60 days single entry visa",
              fontWeight: 700,
            ),
            const SizedBox(
              height: 5,
            ),
            FxText.bodyMedium(
              "450 AED",
              fontWeight: 700,
            ),
            const SizedBox(
              height: 5,
            ),
            FxText.bodyMedium(
              "Date: 16/01/2022",
              fontWeight: 700,
            )
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FxText.bodyMedium(
              "12 days work visa",
              fontWeight: 700,
            ),
            const SizedBox(
              height: 5,
            ),
            FxText.bodyMedium(
              "1000 AED",
              fontWeight: 700,
            ),
            const SizedBox(
              height: 5,
            ),
            FxText.bodyMedium(
              "Date: 31/12/2022",
              fontWeight: 700,
            )
          ]),
        ),
      ],
    );
  }

  Widget flightList() {
    return SizedBox(
      child: ListView(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Container(
                  // padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        // color: Colors.grey.shade400,
                        color: const Color(0xff1529e8).withOpacity(0.4),
                        blurRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    style: FxTextStyle.bodyMedium(),
                    controller: controller.SearchTE,
                    cursorColor: theme.colorScheme.primary,

                    //2
                    onChanged: (value) {},

                    decoration: InputDecoration(
                      hintText: "Search your Order ...",
                      hintStyle: FxTextStyle.bodySmall(
                          color: theme.colorScheme.onBackground),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      filled: true,
                      // fillColor: const Color(0xffcfd2ff),
                      fillColor: theme.cardTheme.color,
                      prefixIcon: Icon(
                        FeatherIcons.search,
                        size: 16,
                        color: theme.colorScheme.onBackground.withAlpha(150),
                      ),
                      isDense: true,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
              ),
              FxSpacing.width(4),
              FxContainer(
                paddingAll: 12,
                borderRadiusAll: 4,
                onTap: () async {
                  var data = await showModalBottomSheet(
                      context: context,
                      builder: (BuildContext buildContext) {
                        return const SortAllBooking();
                      });
                  setState(() {});
                },
                color: const Color(0xff1529e8).withAlpha(40),
                child: const Icon(
                  Iconsax.sort,
                  color: Color(0xff1529e8),
                  size: 20,
                ),
              ),
              FxSpacing.width(4),
              FxContainer(
                paddingAll: 12,
                borderRadiusAll: 4,
                onTap: () async {
                  var data = await showModalBottomSheet(
                      context: context,
                      builder: (BuildContext buildContext) {
                        return const FilterAllBooking();
                      });
                  setState(() {});
                },
                color: const Color(0xff1529e8).withAlpha(40),
                child: const Icon(
                  FeatherIcons.sliders,
                  color: Color(0xff1529e8),
                  size: 20,
                ),
              ),
            ],
          ),
          FxSpacing.height(20),
          _reservationsItem(),
          _reservationsItem(),
          _reservationsItem(),
          _reservationsItem(),
          _reservationsItem(),
        ],
      ),
    );
  }

  Widget HotelList() {
    if (orders == null) {
      log('You have no Bookings');
      return const Text("You have no Bookings!!");
    } else {
      if (orders!.result == null) {
        log('You have no Booking!!');
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              // Lottie.asset('assets/lottie/confirmation.json',
              //     height: 300, width: 300),
              Text('No Order History!!',
                  style: TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16))
            ],
          ),
        );
        // return const Text("You have no attractions");
      }
      String? orderlength;
      orderlength = orders!.result!.totalOrders.toString();
      // return const Text('Hotel History Screen',
      //     style: TextStyle(
      //         fontFamily: 'inter', fontWeight: FontWeight.w400, fontSize: 16));
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  // padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        // color: Colors.grey.shade400,
                        color: const Color(0xff1529e8).withOpacity(0.4),
                        blurRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    style: FxTextStyle.bodyMedium(),
                    controller: controller.SearchTE,
                    cursorColor: theme.colorScheme.primary,

                    //2
                    onChanged: (value) {},

                    decoration: InputDecoration(
                      hintText: "Search your Order ...",
                      hintStyle: FxTextStyle.bodySmall(
                          color: theme.colorScheme.onBackground),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      filled: true,
                      // fillColor: const Color(0xffcfd2ff),
                      fillColor: theme.cardTheme.color,
                      prefixIcon: Icon(
                        FeatherIcons.search,
                        size: 16,
                        color: theme.colorScheme.onBackground.withAlpha(150),
                      ),
                      isDense: true,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
              ),
              FxSpacing.width(4),
              FxContainer(
                paddingAll: 12,
                borderRadiusAll: 4,
                onTap: () async {
                  var data = await showModalBottomSheet(
                      context: context,
                      builder: (BuildContext buildContext) {
                        return const SortAllBooking();
                      });
                  setState(() {});
                },
                color: const Color(0xff1529e8).withAlpha(40),
                child: const Icon(
                  Iconsax.sort,
                  color: Color(0xff1529e8),
                  size: 20,
                ),
              ),
              FxSpacing.width(4),
              FxContainer(
                paddingAll: 12,
                borderRadiusAll: 4,
                onTap: () async {
                  var data = await showModalBottomSheet(
                      context: context,
                      builder: (BuildContext buildContext) {
                        return const FilterAllBooking();
                      });
                  setState(() {});
                },
                color: const Color(0xff1529e8).withAlpha(40),
                child: const Icon(
                  FeatherIcons.sliders,
                  color: Color(0xff1529e8),
                  size: 20,
                ),
              ),
            ],
          ),
          FxSpacing.height(20),
          Expanded(
            child: ListView.builder(
              // itemCount: orderlength.length,
              // itemCount: orders!.result!.totalOrders,
              itemCount: orders!.result!.data!.length,
              itemBuilder: (BuildContext context, int index) {
                // log('Order Length history:${orderlength!.length}');
                var date = orders!.result!.data![index].activities!.date;
                var newDate = date!.toLocal().toString().substring(0, 10);
                print(newDate);
                return FxContainer(
                  margin: FxSpacing.bottom(20),
                  borderRadiusAll: 4,
                  color: Colors.white,
                  paddingAll: 12,
                  child: Row(
                    children: [
                      FxContainer(
                        paddingAll: 0,
                        borderRadiusAll: 4,
                        height: MediaQuery.of(context).size.height * 0.11,
                        width: MediaQuery.of(context).size.width * 0.2,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: CachedNetworkImage(
                            height: MediaQuery.of(context).size.height * 0.11,
                            width: MediaQuery.of(context).size.width * 0.2,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                                      child: CircularProgressIndicator(
                                        value: progress.progress,
                                      ),
                                    ),
                            imageUrl:
                                'https://secure.mytravellerschoice.com/public/images/hotels/images-1682593932493-438110354.jpg'
                            // 'https://a.walletbot.online${orders!.result!.data![index].attraction!.images!.first}',
                            ),
                      ),
                      FxSpacing.width(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FxText.titleMedium(
                              'Nikki Beach Resort & Spa Dubai',
                              fontWeight: 700,
                            ),
                            FxSpacing.height(8),
                            FxText.bodyMedium(
                              '7234.35 AED',
                              fontWeight: 700,
                            ),
                            FxSpacing.height(8),
                            // Row(
                            //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     FxText.bodyMedium(
                            //       'Selected Pax:',
                            //       fontWeight: 600,
                            //     ),
                            //     FxSpacing.width(7),
                            //     Expanded(
                            //       child: FxContainer(
                            //         padding: FxSpacing.fromLTRB(5, 6, 1, 6),
                            //         color: const Color(0xff1529e8).withAlpha(40),
                            //         child: FxText.bodyMedium(
                            //             'Double Deleuxe with Bed and Breakfast',
                            //             color: const Color(0xff1529e8),
                            //             // color: customTheme.groceryPrimary,
                            //             fontWeight: 500,
                            //             letterSpacing: -0.2),
                            //       ),
                            //     )
                            //   ],
                            // ),
                            // //total nength of stay
                            // FxSpacing.height(8),
                            // Row(
                            //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     FxText.bodyMedium(
                            //       'Total Length of Stay:',
                            //       fontWeight: 600,
                            //     ),
                            //     FxSpacing.width(7),
                            //     Expanded(
                            //       child: FxContainer(
                            //         padding: FxSpacing.fromLTRB(5, 6, 1, 6),
                            //         color: const Color(0xff1529e8).withAlpha(40),
                            //         child: FxText.bodyMedium('1 Night & 0 days',
                            //             color: const Color(0xff1529e8),
                            //             fontWeight: 500,
                            //             letterSpacing: -0.2),
                            //       ),
                            //     )
                            //   ],
                            // ),

                            // const SizedBox(
                            //   height: 5,
                            // ),
                            Row(
                              children: [
                                Expanded(
                                  child: FxText.bodyMedium(
                                    "Check In: $newDate",
                                    fontWeight: 700,
                                  ),
                                ),
                                Expanded(
                                  child: FxText.bodyMedium(
                                    "Check Out: $newDate",
                                    fontWeight: 700,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  Widget _reservationsItem() {
    return FxContainer(
      margin: FxSpacing.bottom(20),
      borderRadiusAll: 4,
      color: Colors.white,
      paddingAll: 12,
      child: Column(
        children: <Widget>[
          Row(
            children: const [
              Icon(Icons.airplane_ticket_sharp, color: Colors.green, size: 35),
              SizedBox(width: 10),
              Text("USA Airways",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              SizedBox(width: 50),
              Text("\$999",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _itemDepartment(),
              _locationPlane(),
              _itemDepartment2()
            ],
          )
        ],
      ),
    );
  }

  Widget _itemDepartment() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Departure",
              style: TextStyle(color: Color.fromARGB(255, 36, 35, 35))),
          SizedBox(height: 10),
          Text("10:20",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          SizedBox(height: 1),
          Text("AUS", style: TextStyle(color: Colors.black54)),
          SizedBox(height: 20),
          Text("08:40",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          SizedBox(height: 1),
          Text("USA", style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _itemDepartment2() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Arrive",
              style: TextStyle(color: Color.fromARGB(255, 36, 35, 35))),
          SizedBox(height: 10),
          Text("06:10",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          SizedBox(height: 1),
          Text("USA", style: TextStyle(color: Colors.black54)),
          SizedBox(height: 20),
          Text("12:30",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          SizedBox(height: 1),
          Text("AUS", style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _locationPlane() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: const [
              Icon(Icons.flight_takeoff,
                  color: Color.fromARGB(255, 13, 170, 8), size: 21),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.location_on,
                  color: Color.fromARGB(255, 172, 67, 7), size: 21),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Icon(Icons.location_on,
                  color: Color.fromARGB(255, 172, 67, 7), size: 21),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.flight_takeoff,
                  color: Color.fromARGB(255, 13, 170, 8), size: 21),
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          // Row(
          //   children: [
          //     ElevatedButton(
          //         onPressed: () {},
          //         child: const Text(
          //           "Print Ticket",
          //           style: TextStyle(color: Colors.black),
          //         ))
          //   ],
          // )
          Center(
              child: FxButton.rounded(
            onPressed: () {
              controller.BoardingScreen();
            },
            elevation: 2,
            backgroundColor: const Color(0xff1529e8),
            child: FxText.labelLarge(
              "Print Ticket",
              color: Colors.white,
            ),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<HistoryController>(
        controller: controller,
        builder: (controller) {
          return _historyWidget();
        });
  }

  Widget _historyWidget() {
    // if (selectVisa == null) {
    //   return Scaffold(
    //       body: Padding(
    //         padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
    //         child: LoadingEffect.getHomeLoadingScreen
    //         // getProductLoadingScreen->profile
    //         //getDatingHomeScreen->detail
    //
    //           (
    //           context,
    //           // theme, theme.colorScheme
    //         ),
    //       ));
    // }else {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: const Color(0xfff5f5f5),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: FxText.titleMedium(
              'History',
              fontWeight: 700,
            ),
            centerTitle: true,
            backgroundColor: const Color(0xfff5f5f5),
            bottom: TabBar(
              labelColor: Colors.black,
              isScrollable: true,
              unselectedLabelColor: Colors.black,
              controller: controller.tabController,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: const Color(0xff1529e8),
              // BoxDecoration(
              //     color: Color(0xff1529e8),
              //     borderRadius: BorderRadius.circular(25)
              // ),
    
              // labelStyle: TextStyle(color: Colors.white) ,
              //   unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(
                    // text: "credits",
                    child: Text(
                  "Attraction",
                  style: TextStyle(fontSize: 16),
                )),
                Tab(
                  child: Text(
                    "Visa",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Tab(
                  child: Text(
                    "Flight",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Tab(
                  child: Text(
                    "Hotel",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      attractionList(), visaList(),
                      // _buildflightList()
                      flightList(),
                      HotelList()
                    ],
                  ),
                ),
                FxSpacing.height(60),
              ],
            ),
          )),
    );
  }
}
