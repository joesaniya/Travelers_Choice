import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/Hotel_folder/widgets/section_title.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../models/tickets.dart';
import '../../theme/app_theme.dart';
import '../controller/popular_list_controller.dart';

class PopularList extends StatefulWidget {
  final List items;

  const PopularList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<PopularList> createState() => _PopularListState();
}

class _PopularListState extends State<PopularList>
    with TickerProviderStateMixin {
  late PopularListController controller;
  late ThemeData theme, theme1;

  @override
  void initState() {
    super.initState();

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(PopularListController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FadeInUp(
  //     duration: const Duration(milliseconds: 1100),
  //     child: Column(
  //       children: [
  //         const SectionTitle(title: 'Most Popular'),
  //         SingleChildScrollView(
  //           scrollDirection: Axis.horizontal,
  //           child: _buildProductList(),
  //         ),
  //         // Container(
  //         //   height: 239,
  //         //   margin: const EdgeInsets.only(bottom: 25),
  //         //   child: Padding(
  //         //     padding: const EdgeInsets.only(left: 24),
  //         //     child: ListView.builder(
  //         //       shrinkWrap: true,
  //         //       scrollDirection: Axis.horizontal,
  //         //       itemCount: items.length,
  //         //       itemBuilder: (context, index) {
  //         //         var item = items[index];

  //         //         return PopularItem(
  //         //           imageUrl: item['imageUrl'],
  //         //           name: item['name'],
  //         //           price: item['price'],
  //         //           rating: item['rating'],
  //         //         );
  //         //       },
  //         //     ),
  //         //   ),
  //         // ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<PopularListController>(
        controller: controller,
        builder: (controller) {
          return _popularcard();
        });
  }

  Widget _popularcard() {
    if (controller.uiLoading) {
      return const CircularProgressIndicator();
    } else {
      return FadeInUp(
        duration: const Duration(milliseconds: 1100),
        child: Column(
          children: [
            const SectionTitle(title: 'Most Popular'),
            Padding(
                padding: FxSpacing.fromLTRB(
                    20,
                    //  FxSpacing.safeAreaTop(context) + 20,
                    0,
                    20,
                    0),
                child: TopCard())
          ],
        ),
      );
    }
  }

  Widget TopCard() {
    List<Widget> list = [];
    for (Tickets ticket1 in controller.tickets!) {
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: GestureDetector(
            onTap: () {
              // controller.Bookseat();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SizedBox(
                height: 239,
                width: 178,
                child: InkWell(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => DetailScreen(
                    //       imageUrl: imageUrl,
                    //       title: name,
                    //       price: price,
                    //       rawRating: rating,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Stack(
                    children: [
                      Hero(
                        tag: 'imageUrl',
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            child: Image.asset(
                              'assets/hotel/luxuary.jpg',
                              scale: 4,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          margin: const EdgeInsets.only(left: 8),
                          child: ClipOval(
                            child: Material(
                              color: const Color(0xff1529e8).withAlpha(24),
                              child: Container(
                                child: InkWell(
                                  highlightColor:
                                      const Color(0xff1529e8).withAlpha(20),
                                  splashColor:
                                      const Color(0xff1529e8).withAlpha(100),
                                  child: const SizedBox(
                                      width: 44,
                                      height: 44,
                                      child: Icon(
                                        MdiIcons.heartOutline,
                                        // isSelected
                                        //     ? MdiIcons.heart
                                        //     : MdiIcons.heartOutline,
                                        // color: controller
                                        //     .colorAnimation.value,
                                        // size: controller
                                        //     .sizeAnimation.value,
                                      )),
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ),
                        ),

                        // child: ClipOval(
                        //   child: Container(
                        //     height: 23,
                        //     width: 23,
                        //     color: kTextColor,
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5),
                        //       child: SvgPicture.asset(
                        //         'assets/icons/heart.svg',
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ),
                      Positioned(
                        bottom: 15,
                        left: 15,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FxText.bodyMedium(
                                  'Hotel Grand',
                                  fontWeight: 900,
                                  color: Colors.white,
                                ),
                                FxText.bodyMedium(
                                  '120 AED',
                                  fontWeight: 500,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    // SvgPicture.asset('assets/icons/star.svg'),
                                    FxSpacing.width(4),
                                    FxText.bodyMedium("4.5",
                                        color: Colors.white, fontWeight: 500),
                                  ],
                                ),
                                // Container(
                                //   margin: const EdgeInsets.only(left: 32),
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: <Widget>[
                                //       FxText.bodyMedium("Rating",
                                //           fontWeight: 500),
                                //       Row(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.center,
                                //         children: <Widget>[
                                //           Hero(
                                //             tag: "product_raing",
                                //             child: FxText.bodyMedium('4',
                                //                 fontWeight: 700),
                                //           ),
                                //           Container(
                                //               margin: const EdgeInsets.only(
                                //                   left: 4),
                                //               child: FxStarRating(rating: 2.55))
                                //         ],
                                //       )
                                //     ],
                                //   ),
                                // ),

                                FxText.bodySmall(
                                  'per night',
                                  // controller.product.bookingType.toString(),
                                  fontWeight: 300,
                                  color: Colors.white,
                                  // color: theme.colorScheme.onPrimary,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }
}
