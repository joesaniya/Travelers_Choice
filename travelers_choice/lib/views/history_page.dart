import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/models/order_attraction_modal.dart';
import 'package:hotel_travel/services/attraction_Service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/history_controller.dart';
import '../services/app_constants.dart';
import '../theme/app_theme.dart';

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
      return ListView.builder(
        itemCount: orders!.result!.totalOrders,
        itemBuilder: (BuildContext context, int index) {
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
                          color:
                              orders!.result!.data![index].activities!.status ==
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
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
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
                            orders!.result!.data![index].activities!.activity!
                                .name!,
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: FxContainer(
                                        padding: FxSpacing.fromLTRB(5, 6, 1, 6),
                                        color: const Color(0xff1529e8)
                                            .withAlpha(40),
                                        child: Row(
                                          children: [
                                            FxText.bodyMedium(
                                                orders!.result!.data![index]
                                                    .activities!.adultsCount!
                                                    .toString(),
                                                color: const Color(0xff1529e8),
                                                // color: customTheme.groceryPrimary,
                                                fontWeight: 500,
                                                letterSpacing: -0.2),
                                            FxSpacing.width(2),
                                            FxText.bodyMedium('Adult',
                                                color: const Color(0xff1529e8),
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
                                        padding: FxSpacing.fromLTRB(5, 6, 1, 6),
                                        color: const Color(0xff1529e8)
                                            .withAlpha(40),
                                        child: Row(
                                          children: [
                                            FxText.bodyMedium(
                                                orders!.result!.data![index]
                                                    .activities!.childrenCount!
                                                    .toString(),
                                                color: const Color(0xff1529e8),
                                                // color: customTheme.groceryPrimary,
                                                fontWeight: 500,
                                                letterSpacing: -0.2),
                                            FxSpacing.width(2),
                                            FxText.bodyMedium('Child',
                                                color: const Color(0xff1529e8),
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
                                        padding: FxSpacing.fromLTRB(5, 6, 1, 6),
                                        color: const Color(0xff1529e8)
                                            .withAlpha(40),
                                        child: Row(
                                          children: [
                                            FxText.bodyMedium(
                                                orders!.result!.data![index]
                                                    .activities!.infantCount
                                                    .toString(),
                                                color: const Color(0xff1529e8),
                                                // color: customTheme.groceryPrimary,
                                                fontWeight: 500,
                                                letterSpacing: -0.2),
                                            FxSpacing.width(2),
                                            FxText.bodyMedium('Infant',
                                                color: const Color(0xff1529e8),
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
    return Scaffold(
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
                "Attraction order",
                style: TextStyle(fontSize: 16),
              )),
              Tab(
                child: Text(
                  "Visa order",
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
                  children: [attractionList(), visaList()],
                ),
              ),
              FxSpacing.height(60),
            ],
          ),
        ));
  }
}
