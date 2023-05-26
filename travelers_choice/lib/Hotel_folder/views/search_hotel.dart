import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:iconsax/iconsax.dart';

import '../../flight_module/controller/search_hotel_controller.dart';
import '../../loading_effect.dart';
import '../../models/tickets.dart';
import '../../theme/app_theme.dart';
import '../bottomsheet.dart/filter_sheet.dart';
import '../bottomsheet.dart/sort_sheet.dart';
import 'demo_detail.dart';

class SearchHotel extends StatefulWidget {
  const SearchHotel({super.key});

  @override
  State<SearchHotel> createState() => _SearchHotelState();
}

class _SearchHotelState extends State<SearchHotel>
    with TickerProviderStateMixin {
  late SearchHotelController controller;
  late ThemeData theme, theme1;
  double? customwidth;
  @override
  void initState() {
    super.initState();

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(SearchHotelController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<SearchHotelController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
      return Scaffold(
          body: Padding(
        padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
        child: LoadingEffect.getReviewLoadingScreen(
          context,
          // theme, theme.colorScheme
        ),
      ));
    } else {
      return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        // body: SafeArea(
        //   child: _buildHotel(),
        // ),
        body: ListView(
            padding: FxSpacing.fromLTRB(
                20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
            // physics: const NeverScrollableScrollPhysics(),
            children: [
              Container(
                // color:  const Color(0xff1529e8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: const Color(0xff1529e8),
                  color: const Color(0xff1529e8).withAlpha(40),
                  border: Border.all(
                      width: 1,
                      //  color: Colors.grey.shade300
                      color: const Color(0xff1529e8)),
                ),
                padding: FxSpacing.xy(6, 9),

                child: Center(
                  child: FxText.bodyMedium(
                    'You Selected:2 Rooms for 4 Adults and 2 Children',
                    fontWeight: 500,
                    letterSpacing: -0.2,
                    color: const Color(0xff1529e8),
                  ),
                ),
              ),

              FxSpacing.height(8),
              Container(
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
                    hintText: "Search your place ...",
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
              FxSpacing.height(20),
              //btn
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      var data = await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext buildContext) {
                            return const SortSeat();
                          });
                      setState(() {});
                      // showModalBottomSheet(
                      //   context: context,
                      //   backgroundColor: Colors.white,
                      //   shape: const RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.only(
                      //           topLeft: Radiaus.circular(20),
                      //           topRight: Radius.circular(20))),
                      //   isScrollControlled: true,
                      //   builder: (context) {
                      //     return const CategoriesBottomSheet();
                      //   },
                      // );
                    },
                    child: FxContainer(
                      borderRadiusAll: 10,
                      height: 30,
                      width: 80,
                      // padding: FxSpacing.xy(8, 4),
                      padding: FxSpacing.xy(6, 9),
                      color: const Color(0xff1529e8),
                      child: Center(
                        child: FxText.bodySmall(
                          'Sort',
                          fontWeight: 300,
                          color: Colors.white,
                          // color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    // onTap: () {
                    //   // showModalBottomSheet(
                    //   //     context: context,
                    //   //     builder: (BuildContext buildContext) {
                    //   //       return const FilterSheet();
                    //   //     });
                    //   showModalBottomSheet(
                    //     context: context,
                    //     backgroundColor: Colors.white,
                    //     shape: const RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.only(
                    //             topLeft: Radius.circular(20),
                    //             topRight: Radius.circular(20))),
                    //     isScrollControlled: true,
                    //     builder: (context) {
                    //       return const FilterSheet();
                    //     },
                    //   );
                    // },
                    onTap: () async {
                      var data = await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext buildContext) {
                            return const HotelFilterSheet();
                          });
                      setState(() {});
                      // showModalBottomSheet(
                      //   context: context,
                      //   backgroundColor: Colors.white,
                      //   shape: const RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(20),
                      //           topRight: Radius.circular(20))),
                      //   isScrollControlled: true,
                      //   builder: (context) {
                      //     return const CategoriesBottomSheet();
                      //   },
                      // );
                    },
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                          color: const Color(0xff1529e8),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: FxText.bodySmall(
                          'Filter',
                          fontWeight: 300,
                          color: Colors.white,
                          // color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              FxSpacing.height(20),
              // SingleChildScrollView(
              //   scrollDirection: Axis.vertical,
              //   physics: const AlwaysScrollableScrollPhysics(),
              //   child: _buildHotel(),
              // ),
              _buildHotel()
            ]),
      );
    }
  }

  Widget _buildHotel() {
    log('calling Hotel');
    List<Widget> list = [];
    for (Tickets ticket1 in controller.tickets!) {
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: GestureDetector(
          onTap: () {
            // controller.Bookseat();
            Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
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
                pageBuilder: (_, __, ___) =>
                    // const HotelDetail()
                    const SingleProductScreen()));
          },
          child: Container(
            // margin: const EdgeInsets.only(top: 10),
            // decoration: BoxDecoration(
            //     color: Colors.blueGrey,
            //     borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.only(
              bottom: 10,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.grey.shade300, width: 1)),
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      child: Image.asset(
                        'assets/hotel/luxuary.jpg',
                        height: 142,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    )),
                Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FxText.bodyLarge(
                              'Grand Palace',
                              fontWeight: 800,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          FxSpacing.height(5),
                          Row(
                            children: [
                              const Icon(
                                Iconsax.location,
                              ),
                              FxSpacing.height(5),
                              FxText.bodyMedium(
                                'Abu Dhabi',
                                fontWeight: 500,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              FxSpacing.height(5),
                            ],
                          ),
                          Row(
                            children: [
                              FxStarRating(rating: 2.55),
                              FxSpacing.height(5),
                              FxText.bodyMedium('2.5', fontWeight: 700)
                            ],
                          ),
                          // const CustomRating(ratingScore: 4.7)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: const TextSpan(
                                // style:
                                //     TextStyle(color: Colors.black, fontSize: 36),
                                children: <TextSpan>[
                                  TextSpan(
                                      // text: '\$${140}',
                                      text: '140 AED',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900)),
                                  TextSpan(
                                      text: '/night',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
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
}

class CustomRating extends StatelessWidget {
  final double ratingScore;
  const CustomRating({super.key, required this.ratingScore});

  @override
  Widget build(BuildContext context) {
    const customsize = 15.0;
    return Row(
      children: [
        for (int i = 1; i <= 5; i++)
          Container(
            height: customsize,
            width: customsize,
            margin: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
                color: i <= ratingScore ? Colors.yellow : Colors.grey),
          )
      ],
    );
  }
}
