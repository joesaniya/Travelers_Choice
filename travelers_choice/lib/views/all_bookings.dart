import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slimy_card/slimy_card.dart';
import '../controllers/all_bookings.dart';
import '../loading_effect.dart';
import '../models/order_attraction_modal.dart';
import '../models/product.dart';
import '../services/app_constants.dart';
import '../services/attraction_Service.dart';
import '../theme/app_theme.dart';

class AllBookings extends StatefulWidget {
  const AllBookings({Key? key}) : super(key: key);

  @override
  State<AllBookings> createState() => _AllBookingsState();
}

class _AllBookingsState extends State<AllBookings>
    with TickerProviderStateMixin {
  late AllBookingController controller;
  late ThemeData theme, theme1;
  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        controller.token =
            sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN)!;
        log("auth token ${controller.token!}");
      });
      fetchData();
      // AttractionService().getAttractionOrders(context,);
    });
    controller = FxControllerStore.put(AllBookingController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  bool isLoading = true;
  fetchData() {
    log('fetcdata');
    Future.delayed(Duration.zero, () async {
      await getOrder().then((value) {
        if (value) {
          isLoading = false;
          setState(() {});
        }
      });
    });
  }

  AllAttractionOrders? orders;
  bool isOrdersLoading = true;
  Future getOrder() async {
    isOrdersLoading = true;
    try {
      var data =
          await AttractionService().getAttractionOrders(controller.token!);
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

  Widget attractionList() {
    if (orders == null) {
      log('loading..');
      return const Text("Loading....!");
    } else {
      if (orders!.result!.data!.isEmpty) {
        log('You have no attractions');
        return const Text("You have no attractions");
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
                Row(
                  children: [
                    FxContainer(
                      paddingAll: 0,
                      borderRadiusAll: 4,
                      height: 100,
                      width: 100,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: CachedNetworkImage(
                        height: 100,
                        width: 100,
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
                    FxSpacing.width(16),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FxText.bodyMedium(
                                'Pax',
                                fontWeight: 600,
                              ),
                              Expanded(child: Container()),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  FxContainer(
                                    padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                                    color:
                                        const Color(0xff1529e8).withAlpha(40),
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
                                        FxSpacing.width(4),
                                        FxText.bodyMedium('Adult',
                                            color: const Color(0xff1529e8),
                                            // color: customTheme.groceryPrimary,
                                            fontWeight: 500,
                                            letterSpacing: -0.2),
                                      ],
                                    ),
                                  ),
                                  FxSpacing.width(10),
                                  FxContainer(
                                    padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                                    color:
                                        const Color(0xff1529e8).withAlpha(40),
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
                                        FxSpacing.width(4),
                                        FxText.bodyMedium('child',
                                            color: const Color(0xff1529e8),
                                            // color: customTheme.groceryPrimary,
                                            fontWeight: 500,
                                            letterSpacing: -0.2),
                                      ],
                                    ),
                                  ),
                                  FxSpacing.width(10),
                                  FxContainer(
                                    padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                                    color:
                                        const Color(0xff1529e8).withAlpha(40),
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
                                        FxSpacing.width(4),
                                        FxText.bodyMedium('Infant',
                                            color: const Color(0xff1529e8),
                                            // color: customTheme.groceryPrimary,
                                            fontWeight: 500,
                                            letterSpacing: -0.2),
                                      ],
                                    ),
                                  )
                                ],
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

  Widget _buildBody() {
    if (orders == null) {
      return Scaffold(
          body: Padding(
        padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
        child: LoadingEffect.getHomeLoadingScreen(
          context,
          // theme, theme.colorScheme
        ),
      ));
    } else {
      if (orders!.result == null) {
        log('You have no attractions');
        return const Text("You have no attractions");
      }
      return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: FxText.titleLarge(
            'All Bookings',
            fontWeight: 600,
          ),
          backgroundColor: Colors.transparent,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                FeatherIcons.chevronLeft,
                size: 20,
                color: Color(0xff1529e8),
              )),
        ),
        body: Padding(
          padding: FxSpacing.fromLTRB(
              20,
              // FxSpacing.safeAreaTop(context) + 20,
              // FxSpacing.safeAreaTop(context) + 5,
              0,
              20,
              0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            // child: _buildProductList(),
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: orders!.result!.totalOrders!.toInt(),
              itemBuilder: (BuildContext context, int index) {
                var date = orders!.result!.data![index].activities!.date;
                String createdatae =
                    orders!.result!.data![index].createdAt.toString();
                log('Created Date:$createdatae');
                DateTime dateTime = DateTime.parse(createdatae);
                String formattedDatecreate =
                    "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
                log('Format:$formattedDatecreate');
                var newDate = date!.toLocal().toString().substring(0, 10);
                log('New Date:$newDate');
                // return Container(
                //   // height: 212,
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: const BorderRadius.all(Radius.circular(10)),
                //       border:
                //           Border.all(color: Colors.grey.shade300, width: 1)),
                //   // margin: const EdgeInsets.only(
                //   //   bottom: 20,
                //   // ),
                //   child: Column(
                //     children: [
                //       Container(
                //         margin: const EdgeInsets.all(8),
                //         child: Column(
                //           children: [
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Container(
                //                   child: Row(children: [
                //                     FxText.bodyLarge(
                //                       'Status:',

                //                       // textAlign: TextAlign.left,
                //                       letterSpacing: 0,
                //                       fontWeight: 600,
                //                     ),
                //                     FxSpacing.width(10),
                //                     FxText.bodyLarge(
                //                       orders!.result!.data![index].orderStatus
                //                           .toString(),

                //                       color: orders!.result!.data![index]
                //                                   .orderStatus ==
                //                               'confirmed'
                //                           ? Colors.green
                //                           : Colors.red,
                //                       fontWeight: 600,
                //                       // color: const Color(0xff1529e8),
                //                     )
                //                   ]),
                //                 ),
                //                 Container(
                //                   child: Row(children: [
                //                     FxText.bodyLarge(
                //                       'Date:',

                //                       // textAlign: TextAlign.left,
                //                       letterSpacing: 0,
                //                       fontWeight: 600,
                //                     ),
                //                     FxSpacing.width(10),
                //                     FxText.bodyLarge(
                //                       formattedDatecreate,
                //                       fontWeight: 600,
                //                       color: const Color(0xff1529e8),
                //                     )
                //                   ]),
                //                 )
                //               ],
                //             ),
                //             FxSpacing.height(10),
                //             FxDashedDivider(
                //               dashSpace: 4,
                //               dashWidth: 8,
                //               color:
                //                   theme.colorScheme.onBackground.withAlpha(180),
                //               height: 1.2,
                //             ),
                //           ],
                //         ),
                //       ),
                //       Container(
                //         margin: const EdgeInsets.all(8),
                //         child: Row(
                //           children: [
                //             Container(

                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(10),
                //               ),
                //               clipBehavior: Clip.antiAliasWithSaveLayer,
                //               child: CachedNetworkImage(
                //                 height: 100,
                //                 width: 100,
                //                 fit: BoxFit.cover,
                //                 progressIndicatorBuilder:
                //                     (context, url, progress) => Center(
                //                   child: CircularProgressIndicator(
                //                     value: progress.progress,
                //                   ),
                //                 ),
                //                 imageUrl:
                //                     'https://a.walletbot.online${orders!.result!.data![index].attraction!.images!.first}',
                //               ),
                //             ),
                //             FxSpacing.width(20),
                //             Expanded(
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 children: [

                //                   Hero(
                //                     tag:
                //                         "product_${orders!.result!.data![index].activities!.activity!.name!}",
                //                     // child: FxText.bodyLarge(
                //                     //   product.name,
                //                     //   // fontWeight: 500,
                //                     // ),
                //                     child: FxText.bodyLarge(
                //                       orders!.result!.data![index].activities!
                //                           .activity!.name!,
                //                       fontWeight: 800,
                //                       overflow: TextOverflow.ellipsis,
                //                       maxLines: 2,
                //                     ),
                //                   ),
                //                   FxSpacing.height(4),
                //                   Container(
                //                     child: Column(
                //                       children: [
                //                         Row(
                //                           children: [
                //                             FxText.bodySmall(
                //                               'Adult:',
                //                               fontWeight: 900,
                //                               color: Colors.black,
                //                             ),
                //                             FxSpacing.width(10),
                //                             FxText.bodySmall(
                //                               orders!.result!.data![index]
                //                                   .activities!.adultsCount
                //                                   .toString(),
                //                               fontWeight: 600,
                //                               color: Colors.black,
                //                             ),
                //                           ],
                //                         ),
                //                         Row(
                //                           children: [
                //                             FxText.bodySmall(
                //                               'Child:',
                //                               fontWeight: 900,
                //                               color: Colors.black,
                //                             ),
                //                             FxSpacing.width(10),
                //                             FxText.bodySmall(
                //                               orders!.result!.data![index]
                //                                   .activities!.childrenCount
                //                                   .toString(),
                //                               fontWeight: 600,
                //                               color: Colors.black,
                //                             ),
                //                           ],
                //                         ),
                //                         Row(
                //                           children: [
                //                             FxText.bodySmall(
                //                               'Infant:',
                //                               fontWeight: 900,
                //                               color: Colors.black,
                //                             ),
                //                             FxSpacing.width(10),
                //                             FxText.bodySmall(
                //                               orders!.result!.data![index]
                //                                   .activities!.infantCount
                //                                   .toString(),
                //                               fontWeight: 600,
                //                               color: Colors.black,
                //                             ),
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   FxSpacing.height(4),
                //                   Hero(
                //                     tag:
                //                         "${orders!.result!.data![index].activities!.activity!.name!}_${orders!.result!.data![index].totalAmount}",
                //                     child: FxText.labelLarge(
                //                       "${orders!.result!.data![index].totalAmount} AED",
                //                       // "\$" + product.price.toString() + "/hour",
                //                       fontWeight: 700,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // );
                return SlimyCard(
                  color: const Color(0xff1529e8),
                  width: MediaQuery.of(context).size.width,
                  topCardHeight: 195,
                  bottomCardHeight: 100,
                  borderRadius: 15,
                  topCardWidget: Container(
                    // height: 212,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),

                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(children: [
                                      FxText.bodyLarge(
                                        'Status:',

                                        // textAlign: TextAlign.left,
                                        letterSpacing: 0,
                                        fontWeight: 600,
                                      ),
                                      FxSpacing.width(10),
                                      FxText.bodyLarge(
                                        orders!.result!.data![index].orderStatus
                                            .toString(),

                                        color: orders!.result!.data![index]
                                                    .orderStatus ==
                                                'confirmed'
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: 600,
                                        // color: const Color(0xff1529e8),
                                      )
                                    ]),
                                  ),
                                  Container(
                                    child: Row(children: [
                                      FxText.bodyLarge(
                                        'Date:',

                                        // textAlign: TextAlign.left,
                                        letterSpacing: 0,
                                        fontWeight: 600,
                                      ),
                                      FxSpacing.width(10),
                                      FxText.bodyLarge(
                                        formattedDatecreate,
                                        fontWeight: 600,
                                        color: const Color(0xff1529e8),
                                      )
                                    ]),
                                  )
                                ],
                              ),
                              FxSpacing.height(10),
                              FxDashedDivider(
                                dashSpace: 4,
                                dashWidth: 8,
                                color: theme.colorScheme.onBackground
                                    .withAlpha(180),
                                height: 1.2,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: CachedNetworkImage(
                                  height: 100,
                                  width: 100,
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
                              FxSpacing.width(20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Row(
                                    //   children: [
                                    //     FxContainer(
                                    //       borderRadiusAll: 10,
                                    //       // padding: FxSpacing.xy(8, 4),
                                    //       padding: FxSpacing.xy(6, 2),
                                    //       // color: Color(0xff1529e8),
                                    //       color: Colors.blueGrey,
                                    //       child: FxText.bodySmall(
                                    //         overflow: TextOverflow.ellipsis,
                                    //         maxLines: 1,
                                    //         // 'Theme Park',
                                    //         'Park',
                                    //         fontWeight: 300,
                                    //         color: Colors.white,
                                    //         // color: theme.colorScheme.onPrimary,
                                    //       ),
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 5,
                                    //     ),
                                    //     FxContainer(
                                    //       borderRadiusAll: 10,
                                    //       // padding: FxSpacing.xy(8, 4),
                                    //       padding: FxSpacing.xy(6, 2),
                                    //       // color: Color(0xff1529e8),
                                    //       color: Colors.blueGrey,
                                    //       child: FxText.bodySmall(
                                    //         'Ticket',
                                    //         fontWeight: 300,
                                    //         color: Colors.white,
                                    //         // color: theme.colorScheme.onPrimary,
                                    //       ),
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 5,
                                    //     ),
                                    //     FxContainer(
                                    //       borderRadiusAll: 10,
                                    //       // padding: FxSpacing.xy(8, 4),
                                    //       padding: FxSpacing.xy(6, 2),
                                    //       // color: Color(0xff1529e8),
                                    //       color: Colors.blueGrey,
                                    //       child: FxText.bodySmall(
                                    //         'Offer',
                                    //         fontWeight: 300,
                                    //         color: Colors.white,
                                    //         // color: theme.colorScheme.onPrimary,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // FxSpacing.height(8),
                                    Hero(
                                      tag:
                                          "product_${orders!.result!.data![index].activities!.activity!.name!}",
                                      child: FxText.bodyLarge(
                                        orders!.result!.data![index].activities!
                                            .activity!.name!,
                                        fontWeight: 800,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    FxSpacing.height(4),
                                    Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              FxText.bodySmall(
                                                'Adult:',
                                                fontWeight: 900,
                                                color: Colors.black,
                                              ),
                                              FxSpacing.width(10),
                                              FxText.bodySmall(
                                                orders!.result!.data![index]
                                                    .activities!.adultsCount
                                                    .toString(),
                                                fontWeight: 600,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              FxText.bodySmall(
                                                'Child:',
                                                fontWeight: 900,
                                                color: Colors.black,
                                              ),
                                              FxSpacing.width(10),
                                              FxText.bodySmall(
                                                orders!.result!.data![index]
                                                    .activities!.childrenCount
                                                    .toString(),
                                                fontWeight: 600,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              FxText.bodySmall(
                                                'Infant:',
                                                fontWeight: 900,
                                                color: Colors.black,
                                              ),
                                              FxSpacing.width(10),
                                              FxText.bodySmall(
                                                orders!.result!.data![index]
                                                    .activities!.infantCount
                                                    .toString(),
                                                fontWeight: 600,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    FxSpacing.height(4),
                                    Hero(
                                      tag:
                                          "${orders!.result!.data![index].activities!.activity!.name!}_${orders!.result!.data![index].totalAmount}",
                                      child: FxText.labelLarge(
                                        "${orders!.result!.data![index].totalAmount} AED",
                                        // "\$" + product.price.toString() + "/hour",
                                        fontWeight: 700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomCardWidget: Container(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xff919EB0),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1)),
                          child: Row(
                            children: [
                              FxText.bodyLarge('Ref No:',

                                  // textAlign: TextAlign.left,
                                  letterSpacing: 0,
                                  fontWeight: 600,
                                  color: Colors.white),
                              FxSpacing.width(10),
                              FxText.bodyLarge(
                                orders!.result!.data![index].referenceNumber
                                    .toString(),
                                color: Colors.white,

                                fontWeight: 600,
                                // color: const Color(0xff1529e8),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  slimeEnabled: true,
                );
              },
            ),
          ),
        ),
      );
    }
  }

  Widget _buildProductList() {
    List<Widget> list = [];

    // for (var  product in orders!.result!.totalOrders)
    for (Product product in controller.products!) {
      //orders!.result!.totalOrders
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: InkWell(
          onTap: () {
            controller.goToSingleProduct(product);
          },
          child: Container(
            height: 212,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey.shade300, width: 1)),
            margin: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(children: [
                              FxText.bodyLarge(
                                'Status:',

                                // textAlign: TextAlign.left,
                                letterSpacing: 0,
                                fontWeight: 600,
                              ),
                              FxSpacing.width(10),
                              FxText.bodyLarge(
                                product.status,
                                color: product.status == 'confirmed'
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: 600,
                                // color: const Color(0xff1529e8),
                              )
                            ]),
                          ),
                          Container(
                            child: Row(children: [
                              FxText.bodyLarge(
                                'Date:',

                                // textAlign: TextAlign.left,
                                letterSpacing: 0,
                                fontWeight: 600,
                              ),
                              FxSpacing.width(10),
                              FxText.bodyLarge(
                                '15-02-2023',
                                fontWeight: 600,
                                color: const Color(0xff1529e8),
                              )
                            ]),
                          )
                        ],
                      ),
                      FxSpacing.height(10),
                      FxDashedDivider(
                        dashSpace: 4,
                        dashWidth: 8,
                        color: theme.colorScheme.onBackground.withAlpha(180),
                        height: 1.2,
                      ),
                    ],
                  ),
                ),
                Container(
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
                        child: Hero(
                          tag: "product_image_${product.name}",
                          child: Image(
                            image: AssetImage(product.image),
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
                                FxContainer(
                                  borderRadiusAll: 10,
                                  // padding: FxSpacing.xy(8, 4),
                                  padding: FxSpacing.xy(6, 2),
                                  // color: Color(0xff1529e8),
                                  color: Colors.blueGrey,
                                  child: FxText.bodySmall(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    // 'Theme Park',
                                    'Park',
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
                            FxSpacing.height(8),
                            Hero(
                              tag: "product_${product.name}",
                              // child: FxText.bodyLarge(
                              //   product.name,
                              //   // fontWeight: 500,
                              // ),
                              child: FxText.bodyLarge(
                                product.name,
                                fontWeight: 800,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            FxSpacing.height(4),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      FxText.bodySmall(
                                        'Adult:',
                                        fontWeight: 900,
                                        color: Colors.black,
                                      ),
                                      FxSpacing.width(10),
                                      FxText.bodySmall(
                                        '4',
                                        fontWeight: 600,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FxText.bodySmall(
                                        'Child:',
                                        fontWeight: 900,
                                        color: Colors.black,
                                      ),
                                      FxSpacing.width(10),
                                      FxText.bodySmall(
                                        '0',
                                        fontWeight: 600,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FxText.bodySmall(
                                        'Infant:',
                                        fontWeight: 900,
                                        color: Colors.black,
                                      ),
                                      FxSpacing.width(10),
                                      FxText.bodySmall(
                                        '0',
                                        fontWeight: 600,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            FxSpacing.height(4),
                            Hero(
                              tag: "${product.name}_${product.price}",
                              child: FxText.labelLarge(
                                // '\$' + product.price.toString(),
                                "${product.price} AED",
                                // "\$" + product.price.toString() + "/hour",
                                fontWeight: 700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
    return FxBuilder<AllBookingController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }
}
