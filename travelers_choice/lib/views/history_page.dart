
import 'dart:developer';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/models/order_attraction_modal.dart';
import 'package:hotel_travel/models/select_visa_modal.dart';
import 'package:hotel_travel/models/visa_country_modal.dart';
import 'package:hotel_travel/services/attraction_Service.dart';
import 'package:hotel_travel/services/visa_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../controllers/history_controller.dart';
import '../controllers/visa_controller.dart';
import '../loading_effect.dart';
import '../services/app_constants.dart';
import '../theme/app_theme.dart';
import 'apply_visa.dart';


class HistoryScreen extends StatefulWidget {

  const HistoryScreen({Key? key,}) : super(key: key);

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
      await getOrder().then((value) {
        if (value) {
          isLoading = false;
          setState(() {});
        }
      });
    });
  }

  AllAttractionOrders? orders ;
  bool isOrdersLoading = true;
  Future getOrder() async {
    isOrdersLoading = true;
    try {
      var data = await AttractionService().getAttractionOrders(controller.token!);
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
  String searchText="";

  Widget attractionList(){

    if(orders == null ){

      return Text("You have no attractions");
    }else{
      if(orders!.result == null){
        return Text("You have no attractions");
      }
      return ListView.builder(
        itemCount: orders!.result!.totalOrders,
        itemBuilder: (BuildContext context, int index) {
          var date = orders!.result!.data![index].activities!.date;
          var newDate = date!.toLocal().toString().substring(0,10);
          print(newDate);
          return  FxContainer(
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
                    FxSpacing.width(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FxText.titleMedium(
                            orders!.result!.data![index].activities!.activity!.name!,
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
                                    color: const Color(0xff1529e8).withAlpha(40),
                                    child: Row(
                                      children: [
                                        FxText.bodyMedium(
                                            orders!.result!.data![index].activities!.adultsCount!.toString(),
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
                                    color: const Color(0xff1529e8).withAlpha(40),
                                    child: Row(
                                      children: [
                                        FxText.bodyMedium(
                                            orders!.result!.data![index].activities!.childrenCount!.toString(),
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
                                    color: const Color(0xff1529e8).withAlpha(40),
                                    child: Row(
                                      children: [
                                        FxText.bodyMedium(
                                            orders!.result!.data![index].activities!.infantCount.toString(),
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
                          SizedBox(height: 5,),
                          FxText.bodyMedium("Date: $newDate",fontWeight: 700,)

                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        // children: [
        //
        //   SizedBox(height: 10,),
        //
        //   FxContainer(
        //     color: Colors.white,
        //     margin: FxSpacing.bottom(20),
        //     borderRadiusAll: 4,
        //     paddingAll: 12,
        //     child: Column(
        //       children: [
        //         Row(
        //           children: [
        //             FxContainer(
        //               paddingAll: 0,
        //               borderRadiusAll: 4,
        //               height: 80,
        //               width: 80,
        //               clipBehavior: Clip.antiAliasWithSaveLayer,
        //               child: Image(
        //                 fit: BoxFit.cover,
        //                 image: AssetImage("assets/images/place/paris.jpg"),
        //               ),
        //             ),
        //             FxSpacing.width(16),
        //             Expanded(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   FxText.titleMedium(
        //                     "Yas water world",
        //                     fontWeight: 700,
        //                   ),
        //                   FxSpacing.height(8),
        //                   FxText.bodyMedium(
        //                     '540 AED',
        //                     fontWeight: 700,
        //                   ),
        //                   FxSpacing.height(8),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       FxText.bodyMedium(
        //                         'Pax',
        //                         fontWeight: 600,
        //                       ),
        //                       Expanded(child: Container()),
        //                       Row(
        //                         crossAxisAlignment: CrossAxisAlignment.end,
        //                         children: [
        //                           FxContainer(
        //                             padding: FxSpacing.fromLTRB(8, 6, 8, 6),
        //                             color: const Color(0xff1529e8).withAlpha(40),
        //                             child: Row(
        //                               children: [
        //                                 FxText.bodyMedium(
        //                                     "2",
        //                                     color: const Color(0xff1529e8),
        //                                     // color: customTheme.groceryPrimary,
        //                                     fontWeight: 500,
        //                                     letterSpacing: -0.2),
        //                                 FxSpacing.width(4),
        //                                 FxText.bodyMedium('Adult',
        //                                     color: const Color(0xff1529e8),
        //                                     // color: customTheme.groceryPrimary,
        //                                     fontWeight: 500,
        //                                     letterSpacing: -0.2),
        //                               ],
        //                             ),
        //                           ),
        //                           FxSpacing.width(10),
        //                           FxContainer(
        //                             padding: FxSpacing.fromLTRB(8, 6, 8, 6),
        //                             color: const Color(0xff1529e8).withAlpha(40),
        //                             child: Row(
        //                               children: [
        //                                 FxText.bodyMedium(
        //                                     "0",
        //                                     color: const Color(0xff1529e8),
        //                                     // color: customTheme.groceryPrimary,
        //                                     fontWeight: 500,
        //                                     letterSpacing: -0.2),
        //                                 FxSpacing.width(4),
        //                                 FxText.bodyMedium('child',
        //                                     color: const Color(0xff1529e8),
        //                                     // color: customTheme.groceryPrimary,
        //                                     fontWeight: 500,
        //                                     letterSpacing: -0.2),
        //                               ],
        //                             ),
        //                           ),
        //                           FxSpacing.width(10),
        //                           FxContainer(
        //                             padding: FxSpacing.fromLTRB(8, 6, 8, 6),
        //                             color: const Color(0xff1529e8).withAlpha(40),
        //                             child: Row(
        //                               children: [
        //                                 FxText.bodyMedium(
        //                                     "0",
        //                                     color: const Color(0xff1529e8),
        //                                     // color: customTheme.groceryPrimary,
        //                                     fontWeight: 500,
        //                                     letterSpacing: -0.2),
        //                                 FxSpacing.width(4),
        //                                 FxText.bodyMedium('Infant',
        //                                     color: const Color(0xff1529e8),
        //                                     // color: customTheme.groceryPrimary,
        //                                     fontWeight: 500,
        //                                     letterSpacing: -0.2),
        //                               ],
        //                             ),
        //                           )
        //                         ],
        //                       )
        //                     ],
        //                   ),
        //                   SizedBox(height: 5,),
        //                   FxText.bodyMedium("Date: 10/01/2023",fontWeight: 700,)
        //                 ],
        //               ),
        //             ),
        //
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        //   FxContainer(
        //     color: Colors.white,
        //     margin: FxSpacing.bottom(20),
        //     borderRadiusAll: 4,
        //     paddingAll: 12,
        //     child: Column(
        //       children: [
        //         Row(
        //           children: [
        //             FxContainer(
        //               paddingAll: 0,
        //               borderRadiusAll: 4,
        //               height: 80,
        //               width: 80,
        //               clipBehavior: Clip.antiAliasWithSaveLayer,
        //               child: Image(
        //                 fit: BoxFit.cover,
        //                 image: AssetImage("assets/images/place/cuba.jpg"),
        //               ),
        //             ),
        //             FxSpacing.width(16),
        //             Expanded(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   FxText.titleMedium(
        //                     "Qasr al watan",
        //                     fontWeight: 700,
        //                   ),
        //                   FxSpacing.height(8),
        //                   FxText.bodyMedium(
        //                     '216 AED',
        //                     fontWeight: 700,
        //                   ),
        //                   FxSpacing.height(8),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       FxText.bodyMedium(
        //                         'Pax',
        //                         fontWeight: 700,
        //                       ),
        //                       Expanded(child: Container()),
        //                       Row(
        //                         crossAxisAlignment: CrossAxisAlignment.end,
        //                         children: [
        //                           FxContainer(
        //                             padding: FxSpacing.fromLTRB(8, 6, 8, 6),
        //                             color: const Color(0xff1529e8).withAlpha(40),
        //                             child: Row(
        //                               children: [
        //                                 FxText.bodyMedium(
        //                                     "3",
        //                                     color: const Color(0xff1529e8),
        //                                     // color: customTheme.groceryPrimary,
        //                                     fontWeight: 500,
        //                                     letterSpacing: -0.2),
        //                                 FxSpacing.width(4),
        //                                 FxText.bodyMedium('Adult',
        //                                     color: const Color(0xff1529e8),
        //                                     // color: customTheme.groceryPrimary,
        //                                     fontWeight: 500,
        //                                     letterSpacing: -0.2),
        //                               ],
        //                             ),
        //                           ),
        //                           FxSpacing.width(10),
        //                           FxContainer(
        //                             padding: FxSpacing.fromLTRB(8, 6, 8, 6),
        //                             color: const Color(0xff1529e8).withAlpha(40),
        //                             child: Row(
        //                               children: [
        //                                 FxText.bodyMedium(
        //                                     "1",
        //                                     color: const Color(0xff1529e8),
        //                                     // color: customTheme.groceryPrimary,
        //                                     fontWeight: 500,
        //                                     letterSpacing: -0.2),
        //                                 FxSpacing.width(4),
        //                                 FxText.bodyMedium('child',
        //                                     color: const Color(0xff1529e8),
        //                                     // color: customTheme.groceryPrimary,
        //                                     fontWeight: 500,
        //                                     letterSpacing: -0.2),
        //                               ],
        //                             ),
        //                           ),
        //                           FxSpacing.width(10),
        //                           FxContainer(
        //                             padding: FxSpacing.fromLTRB(8, 6, 8, 6),
        //                             color: const Color(0xff1529e8).withAlpha(40),
        //                             child: Row(
        //                               children: [
        //                                 FxText.bodyMedium(
        //                                     "0",
        //                                     color: const Color(0xff1529e8),
        //                                     // color: customTheme.groceryPrimary,
        //                                     fontWeight: 500,
        //                                     letterSpacing: -0.2),
        //                                 FxSpacing.width(4),
        //                                 FxText.bodyMedium('Infant',
        //                                     color: const Color(0xff1529e8),
        //                                     // color: customTheme.groceryPrimary,
        //                                     fontWeight: 500,
        //                                     letterSpacing: -0.2),
        //                               ],
        //                             ),
        //                           )
        //                         ],
        //                       )
        //                     ],
        //                   ),
        //                   SizedBox(height: 5,),
        //                   FxText.bodyMedium("Date: 20/01/2023",fontWeight: 700,)
        //                 ],
        //               ),
        //             ),
        //
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ]

      );
    }

  }

  Widget visaList(){
    return ListView(
      children: [
        SizedBox(height: 10,),
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FxText.bodyMedium("30 days single entry visa",fontWeight: 700,),
              SizedBox(height: 5,),
              FxText.bodyMedium("285 AED",fontWeight: 700,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     FxText.bodyMedium(
              //       'Pax',
              //       fontWeight: 600,
              //     ),
              //     Expanded(child: Container()),
              //     Row(
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         FxContainer(
              //           padding: FxSpacing.fromLTRB(8, 6, 8, 6),
              //           color: const Color(0xff1529e8).withAlpha(40),
              //           child: Row(
              //             children: [
              //               FxText.bodyMedium(
              //                   "1",
              //                   color: const Color(0xff1529e8),
              //                   // color: customTheme.groceryPrimary,
              //                   fontWeight: 500,
              //                   letterSpacing: -0.2),
              //               FxSpacing.width(4),
              //               FxText.bodyMedium('Adult',
              //                   color: const Color(0xff1529e8),
              //                   // color: customTheme.groceryPrimary,
              //                   fontWeight: 500,
              //                   letterSpacing: -0.2),
              //             ],
              //           ),
              //         ),
              //         FxSpacing.width(10),
              //         FxContainer(
              //           padding: FxSpacing.fromLTRB(8, 6, 8, 6),
              //           color: const Color(0xff1529e8).withAlpha(40),
              //           child: Row(
              //             children: [
              //               FxText.bodyMedium(
              //                   "0",
              //                   color: const Color(0xff1529e8),
              //                   // color: customTheme.groceryPrimary,
              //                   fontWeight: 500,
              //                   letterSpacing: -0.2),
              //               FxSpacing.width(4),
              //               FxText.bodyMedium('child',
              //                   color: const Color(0xff1529e8),
              //                   // color: customTheme.groceryPrimary,
              //                   fontWeight: 500,
              //                   letterSpacing: -0.2),
              //             ],
              //           ),
              //         ),
              //         FxSpacing.width(10),
              //         FxContainer(
              //           padding: FxSpacing.fromLTRB(8, 6, 8, 6),
              //           color: const Color(0xff1529e8).withAlpha(40),
              //           child: Row(
              //             children: [
              //               FxText.bodyMedium(
              //                   "0",
              //                   color: const Color(0xff1529e8),
              //                   // color: customTheme.groceryPrimary,
              //                   fontWeight: 500,
              //                   letterSpacing: -0.2),
              //               FxSpacing.width(4),
              //               FxText.bodyMedium('Infant',
              //                   color: const Color(0xff1529e8),
              //                   // color: customTheme.groceryPrimary,
              //                   fontWeight: 500,
              //                   letterSpacing: -0.2),
              //             ],
              //           ),
              //         )
              //       ],
              //     )
              //   ],
              // ),
              SizedBox(height: 5,),
              FxText.bodyMedium("Date: 02/02/2022",fontWeight: 700,)
            ]
          ),
        ),
        SizedBox(height: 10,),
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.bodyMedium("60 days single entry visa",fontWeight: 700,),
                SizedBox(height: 5,),
                FxText.bodyMedium("450 AED",fontWeight: 700,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     FxText.bodyMedium(
                //       'Pax',
                //       fontWeight: 600,
                //     ),
                //     Expanded(child: Container()),
                //     Row(
                //       crossAxisAlignment: CrossAxisAlignment.end,
                //       children: [
                //         FxContainer(
                //           padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                //           color: const Color(0xff1529e8).withAlpha(40),
                //           child: Row(
                //             children: [
                //               FxText.bodyMedium(
                //                   "1",
                //                   color: const Color(0xff1529e8),
                //                   // color: customTheme.groceryPrimary,
                //                   fontWeight: 500,
                //                   letterSpacing: -0.2),
                //               FxSpacing.width(4),
                //               FxText.bodyMedium('Adult',
                //                   color: const Color(0xff1529e8),
                //                   // color: customTheme.groceryPrimary,
                //                   fontWeight: 500,
                //                   letterSpacing: -0.2),
                //             ],
                //           ),
                //         ),
                //         FxSpacing.width(10),
                //         FxContainer(
                //           padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                //           color: const Color(0xff1529e8).withAlpha(40),
                //           child: Row(
                //             children: [
                //               FxText.bodyMedium(
                //                   "0",
                //                   color: const Color(0xff1529e8),
                //                   // color: customTheme.groceryPrimary,
                //                   fontWeight: 500,
                //                   letterSpacing: -0.2),
                //               FxSpacing.width(4),
                //               FxText.bodyMedium('child',
                //                   color: const Color(0xff1529e8),
                //                   // color: customTheme.groceryPrimary,
                //                   fontWeight: 500,
                //                   letterSpacing: -0.2),
                //             ],
                //           ),
                //         ),
                //         FxSpacing.width(10),
                //         FxContainer(
                //           padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                //           color: const Color(0xff1529e8).withAlpha(40),
                //           child: Row(
                //             children: [
                //               FxText.bodyMedium(
                //                   "0",
                //                   color: const Color(0xff1529e8),
                //                   // color: customTheme.groceryPrimary,
                //                   fontWeight: 500,
                //                   letterSpacing: -0.2),
                //               FxSpacing.width(4),
                //               FxText.bodyMedium('Infant',
                //                   color: const Color(0xff1529e8),
                //                   // color: customTheme.groceryPrimary,
                //                   fontWeight: 500,
                //                   letterSpacing: -0.2),
                //             ],
                //           ),
                //         )
                //       ],
                //     )
                //   ],
                // ),
                SizedBox(height: 5,),
                FxText.bodyMedium("Date: 16/01/2022",fontWeight: 700,)
              ]
          ),
        ),
        SizedBox(height: 10,),
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.bodyMedium("12 days work visa",fontWeight: 700,),
                SizedBox(height: 5,),
                FxText.bodyMedium("1000 AED",fontWeight: 700,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     FxText.bodyMedium(
                //       'Pax',
                //       fontWeight: 600,
                //     ),
                //     Expanded(child: Container()),
                //     Row(
                //       crossAxisAlignment: CrossAxisAlignment.end,
                //       children: [
                //         FxContainer(
                //           padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                //           color: const Color(0xff1529e8).withAlpha(40),
                //           child: Row(
                //             children: [
                //               FxText.bodyMedium(
                //                   "1",
                //                   color: const Color(0xff1529e8),
                //                   // color: customTheme.groceryPrimary,
                //                   fontWeight: 500,
                //                   letterSpacing: -0.2),
                //               FxSpacing.width(4),
                //               FxText.bodyMedium('Adult',
                //                   color: const Color(0xff1529e8),
                //                   // color: customTheme.groceryPrimary,
                //                   fontWeight: 500,
                //                   letterSpacing: -0.2),
                //             ],
                //           ),
                //         ),
                //         FxSpacing.width(10),
                //         FxContainer(
                //           padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                //           color: const Color(0xff1529e8).withAlpha(40),
                //           child: Row(
                //             children: [
                //               FxText.bodyMedium(
                //                   "0",
                //                   color: const Color(0xff1529e8),
                //                   // color: customTheme.groceryPrimary,
                //                   fontWeight: 500,
                //                   letterSpacing: -0.2),
                //               FxSpacing.width(4),
                //               FxText.bodyMedium('child',
                //                   color: const Color(0xff1529e8),
                //                   // color: customTheme.groceryPrimary,
                //                   fontWeight: 500,
                //                   letterSpacing: -0.2),
                //             ],
                //           ),
                //         ),
                //         FxSpacing.width(10),
                //         FxContainer(
                //           padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                //           color: const Color(0xff1529e8).withAlpha(40),
                //           child: Row(
                //             children: [
                //               FxText.bodyMedium(
                //                   "0",
                //                   color: const Color(0xff1529e8),
                //                   // color: customTheme.groceryPrimary,
                //                   fontWeight: 500,
                //                   letterSpacing: -0.2),
                //               FxSpacing.width(4),
                //               FxText.bodyMedium('Infant',
                //                   color: const Color(0xff1529e8),
                //                   // color: customTheme.groceryPrimary,
                //                   fontWeight: 500,
                //                   letterSpacing: -0.2),
                //             ],
                //           ),
                //         )
                //       ],
                //     )
                //   ],
                // ),
                SizedBox(height: 5,),
                FxText.bodyMedium("Date: 31/12/2022",fontWeight: 700,)
              ]
          ),
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
            elevation: 0,
            title: Center(child: Text("History",style: TextStyle(color: Colors.black),)),
            bottom: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black,
              controller: controller.tabController,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Color(0xff1529e8),
              // BoxDecoration(
              //     color: Color(0xff1529e8),
              //     borderRadius: BorderRadius.circular(25)
              // ),

              // labelStyle: TextStyle(color: Colors.white) ,
              //   unselectedLabelColor: Colors.black,
              tabs:  [
                Tab(
                  // text: "credits",
                    child: Text("Attraction order",
                      style: TextStyle(fontSize: 16),
                    )
                ),
                Tab(
                  child: Text("Visa order",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          body:     Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                // Container(
                //   height: 45,
                //   decoration: BoxDecoration(
                //     color:Colors.white,
                //     borderRadius: BorderRadius.circular(
                //       25.0,
                //     ),
                //   ),
                //   child: TabBar(
                //     labelColor: Colors.white,
                //     unselectedLabelColor: Colors.black,
                //     controller: controller.tabController,
                //     indicatorSize: TabBarIndicatorSize.tab,
                //     indicator: BoxDecoration(
                //         color: Color(0xff1529e8),
                //         borderRadius: BorderRadius.circular(25)
                //     ),
                //
                //     // labelStyle: TextStyle(color: Colors.white) ,
                //     //   unselectedLabelColor: Colors.black,
                //     tabs:  [
                //       Tab(
                //         // text: "credits",
                //         child: Text("Attraction order",
                //         )
                //       ),
                //       Tab(
                //         child: Text("Visa order"),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 10,),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      attractionList(),
                      visaList()
                    ],
                  ),
                ),
              ],
            ),
          )
      );
  }


  }


