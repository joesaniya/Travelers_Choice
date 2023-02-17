import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import 'package:hotel_travel/models/all_attraction_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/attraction_Controller.dart';
import '../controllers/saved_controller.dart';
import '../loading_effect.dart';
import '../theme/app_theme.dart';
import 'full_app.dart';

class SavedScreen extends StatefulWidget {
  final List<AllattractionModal> favouriteMeals;
  const SavedScreen(this.favouriteMeals, {super.key});

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late SavedController controller;
  List<AllattractionModal>? allattractionList;
  SharedPreferences? sharedPreferences;

  bool isLoading = true;
  getAttraction(BuildContext context) async {
    // await AuthService().getCountry();
    log('getAttraction function called');
    sharedPreferences = await SharedPreferences.getInstance();
    Future.delayed(Duration.zero, () async {
      await AttractionController().getAllattractionList(context).then((value) {
        if (value != null) {
          isLoading = false;
          allattractionList = [];
          allattractionList!.add(value);
          log('All1:$allattractionList');
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAttraction(context);
    log('saved:${favouriteList.length}');
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(SavedController(this));
    log('Item:${favouriteList.map((e) => e.id)}');
  }

  Widget _buildSingleProduct(Datum product) {
    String text = product.category.categoryName.name;

    text = text.replaceAll("_", " ");

    List<String> words = text.split(" ");

    for (int i = 0; i < words.length; i++) {
      words[i] =
          words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
    }

    text = words.join(" ");

    return FadeTransition(
      opacity: controller.fadeAnimation,
      child: FxContainer(
        onTap: () {
          controller.goToSingleProduct(product);
        },
        color: Colors.white,
        borderColor: Colors.grey.shade300,
        border: Border.all(width: 1),
        borderRadiusAll: 4,
        paddingAll: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxContainer(
              paddingAll: 0,
              borderRadiusAll: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              // child: Stack(
              //   children: [
              //     Hero(
              //       tag: "product_image_${product.name}",
              //       child: Image(
              //         image: AssetImage(product.image),
              //         height: 160,
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //     Positioned(
              //       right: 8,
              //       top: 8,
              //       child: Icon(
              //         product.favorite
              //             ? Icons.favorite_rounded
              //             : Icons.favorite_outline_rounded,
              //         size: 20,
              //         color: theme.colorScheme.primary,
              //       ),
              //     ),
              //   ],
              // ),
              child: Hero(
                tag: "product_image_${product.images}",
                child: CachedNetworkImage(
                  height: 160,
                  fit: BoxFit.cover,
                  fadeOutDuration: const Duration(seconds: 1),
                  fadeInDuration: const Duration(seconds: 3),
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
                  imageUrl: 'https://a.walletbot.online${product.images.first}',
                ),
                // child: Image(
                //   image: NetworkImage(
                //       'https://a.walletbot.online${product.images.first}'),
                //   height: 160,
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            FxSpacing.height(6),
            Expanded(
                // flex: 1,
                child: Column(
              children: [
                Hero(
                  tag: "product_${product.title}",
                  child: FxText.bodyMedium(
                    product.title,
                    fontWeight: 600,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                FxSpacing.height(6),
                // Hero(
                //   tag: "${product.title}_${product.activity.adultPrice}",
                //   child: FxText.bodyMedium(
                //     '\$${product.activity.adultPrice}',
                //     fontWeight: 700,
                //   ),
                // ),
                // FxSpacing.height(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: "${product.title}_${product.averageRating}",
                      child: FxContainer(
                        borderRadiusAll: 4,
                        padding: FxSpacing.xy(8, 4),
                        color: Colors.blueGrey,
                        // color: theme.colorScheme.primary,
                        child: Row(
                          children: [
                            Icon(
                              FeatherIcons.star,
                              color: theme.colorScheme.onPrimary,
                              size: 12,
                            ),
                            FxSpacing.width(6),
                            FxText.bodySmall(
                              product.averageRating.toStringAsFixed(1),
                              fontWeight: 600,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    FxText.labelLarge(
                      "${product.activity.adultPrice} AED",
                      color: const Color(0xff1529e8),
                    )
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
      //todo
      // child: InkWell(
      //   onTap: () {
      //     // controller.goToSingleProduct(product);
      //   },
      //   child: Container(
      //     margin: const EdgeInsets.all(5.0),
      //     // height: 200,
      //     width: double.infinity,
      //     decoration: BoxDecoration(
      //         // color: Color(0xffe6e1e5),
      //         color: Colors.white,
      //         // color: Color(0xffe5fdfd),
      //         borderRadius: const BorderRadius.all(Radius.circular(10)),
      //         border: Border.all(color: Colors.grey.shade300, width: 1)),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Container(
      //           margin: const EdgeInsets.all(8),
      //           height: 100,
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(10),
      //               image: DecorationImage(
      //                   image: NetworkImage(
      //                       'https://a.walletbot.online${product.images.first}'
      //                       // product.images.first.toString()
      //                       ),
      //                   fit: BoxFit.fill)),
      //         ),
      //         FxSpacing.height(4),
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 8),
      //               child: FxText.bodyLarge(
      //                 product.title[0].toUpperCase() +
      //                     product.title.substring(1).toLowerCase(),
      //                 fontWeight: 800,
      //                 overflow: TextOverflow.ellipsis,
      //                 maxLines: 2,
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 8),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Row(
      //                     children: [
      //                       const Icon(
      //                         // FeatherIcons.star,
      //                         Icons.star,
      //                         color: Colors.yellow,
      //                         size: 12,
      //                       ),
      //                       FxSpacing.width(4),
      //                       FxText.bodySmall(
      //                         // '4.5',
      //                         product.averageRating.toStringAsFixed(1),
      //                         fontWeight: 600,
      //                         color: Colors.black,
      //                       ),
      //                       FxSpacing.width(4),
      //                       FxText.bodySmall(
      //                         "(${product.totalReviews})",
      //                         fontWeight: 600,
      //                         color: Colors.black,
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //         FxSpacing.height(10),
      //         Padding(
      //           padding: const EdgeInsets.only(right: 8),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               FxContainer(
      //                 borderRadiusAll: 8,
      //                 padding: FxSpacing.xy(8, 4),
      //                 // color: theme.colorScheme.primary,
      //                 // color: Colors.yellow.shade400,
      //                 color: Colors.white,
      //                 child: Row(
      //                   children: [
      //                     const Icon(
      //                       Iconsax.location,
      //                       color: Colors.black,
      //                       // color: theme.colorScheme.onPrimary,
      //                       size: 12,
      //                     ),
      //                     FxSpacing.width(4),
      //                     FxText.labelLarge(
      //                       // '\$' + product.price.toString(),
      //                       product.destination.name[0].toUpperCase() +
      //                           product.destination.name
      //                               .substring(1)
      //                               .toLowerCase(),

      //                       // product.price.toString() + " " + "AED",
      //                       // "\$" + product.price.toString() + "/hour",
      //                       // fontWeight: 700,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<SavedController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
      return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        body: Container(
            padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
            child: LoadingEffect.getCartLoadingScreen(
              context,
            )),
      );
    } else {
      return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: FxText.titleMedium(
            'Saved',
            fontWeight: 700,
          ),
          centerTitle: true,
          backgroundColor: const Color(0xfff5f5f5),
        ),
        body: favouriteList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // Lottie.asset('assets/lottie/confirmation.json',
                    //     height: 300, width: 300),
                    Text('You have no favourite yet - start adding some item!',
                        style: TextStyle(
                            fontFamily: 'inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 16))
                  ],
                ),
              )
            :

            /////
            // Container(
            //     child: SingleChildScrollView(
            //         child: Column(
            //       children: const [Text('data')],
            //     )),
            //   )
            GridView.builder(

                // padding: FxSpacing.zero,
                padding: FxSpacing.fromLTRB(
                    20,
                    // FxSpacing.safeAreaTop(context) + 20,
                    0,
                    20,
                    20),
                shrinkWrap: true,
                itemCount: favouriteList.length,
                // itemCount: controller.products!.length,
                physics: const ClampingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: controller.findAspectRatio(),
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return _buildSingleProduct(
                      // widget.favouriteMeals.first.attractions.data.first
                      favouriteList[index]);
                }),
      );
    }
  }
}
