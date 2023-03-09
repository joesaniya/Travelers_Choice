import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/review_controller.dart';
import '../../loading_effect.dart';
import '../../services/app_constants.dart';
import '../../theme/app_theme.dart';
import '../bottomSheet/post_review_screen.dart';

class ReviewScreen extends StatefulWidget {
  // List<Reviews>? reviews;
  dynamic rating;
  String? Id;
  dynamic? TotalRatingCount;
  ReviewScreen(
      {super.key,
      // this.reviews,
      this.Id,
      this.rating,
      this.TotalRatingCount});
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen>
    with SingleTickerProviderStateMixin {
  late CustomTheme customTheme;
  late ThemeData theme;
  late ReviewController controller;
  String? token;

  @override
  initState() {
    super.initState();
    initializingData();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    controller = FxControllerStore.put(ReviewController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });
    controller.getReviews(widget.Id, setState);
    // log('Length:${widget.reviews!.length}');
    log('Id:${widget.Id}');
    log('Rating:${widget.rating}');
    log('TotalRating Count:${widget.TotalRatingCount}');
  }

  void initializingData() {
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        token = sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN)!;
        log('Review Token:${token!}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<ReviewController>(
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
      return Theme(
        data: theme.copyWith(
            colorScheme: theme.colorScheme
                .copyWith(secondary: customTheme.groceryPrimary)),
        child: Scaffold(
            // backgroundColor: Colors.yellow,
            backgroundColor: const Color(0xfff5f5f5),
            appBar: AppBar(
              backgroundColor: const Color(0xfff5f5f5),
              elevation: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  MdiIcons.chevronLeft,
                  size: 20,
                  color: theme.colorScheme.onBackground,
                ),
              ),
              title: FxText("Reviews", fontWeight: 600),
            ),
            floatingActionButton: token == null
                ? const SizedBox()
                : FloatingActionButton.extended(
                    hoverColor: Colors.indigoAccent,
                    splashColor: Colors.indigoAccent,
                    onPressed: () async {
                      var data = await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext buildContext) {
                            return PostReviewSheet(
                              reviewplace: widget.Id,
                            );
                          });
                      log("Modal sheet closed with value: " + data);
                      // if (data == 'Success') {
                      //   log('Sucessss1');
                      //   controller.getReviews(widget.Id, setState);
                      // }
                      controller.getReviews(widget.Id, setState);
                      // setState(() {
                      //   controller.reviewsget = [];
                      //   controller.reviewsget = [data];
                      // });
                    },
                    label: const Text('Write a Review'),
                    icon: const Icon(Icons.edit),
                    backgroundColor: const Color(0xff1529e8),
                  ),
            body: controller.reviewsget!.first.attractionReviews.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        // Lottie.asset('assets/lottie/confirmation.json',
                        //     height: 300, width: 300),
                        Text('No Reviews!!',
                            style: TextStyle(
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 16))
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: FxSpacing.fromLTRB(24, 8, 24, 0),
                    // itemBuilder: (context, index) {
                    //   return SizedBox(
                    //     child: Column(
                    //       children: [
                    //         _buildRatingWidget(),
                    //         FxSpacing.height(24),
                    //         _singleReview(
                    //             image: "./assets/images/profile/avatar_4.jpg",
                    //             name: widget.reviews![index].user.toString(),
                    //             rating:
                    //                 widget.reviews![index].rating!.toDouble(),
                    //             review: Generator.getDummyText(32),
                    //             time: widget.reviews![index].createdAt
                    //                 .toString()),
                    //       ],
                    //     ),
                    //   );
                    // },
                    child: Column(
                      children: <Widget>[
                        _buildRatingWidget(widget.rating),
                        FxSpacing.height(24),
                        SizedBox(
                          // height: 200,
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.reviewsget!.length,
                            // itemCount: widget.reviews!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  // _singleReview(
                                  //   image:
                                  //       "./assets/images/profile/avatar_4.jpg",
                                  //   // name: widget.reviews![index].user
                                  //   //     .toString(),
                                  //   // rating: widget.reviews![index].rating!
                                  //   //     .toDouble(),
                                  //   name: controller.reviewsget![index]
                                  //       .attractionReviews[index].user.name,
                                  //   rating: controller.reviewsget![index]
                                  //       .attractionReviews[index].rating,
                                  //   review: controller.reviewsget![index]
                                  //       .attractionReviews[index].description,
                                  //   time: controller.reviewsget![index]
                                  //       .attractionReviews[index].createdAt
                                  //       .toString(),
                                  // )
                                  _buildCartList(),
                                ],
                              );
                            },
                          ),
                        ),
                        // _singleReview(
                        //     image: "./assets/images/profile/avatar_4.jpg",
                        //     name: "Tegan Payne",
                        //     rating: 5,
                        //     review: Generator.getDummyText(32),
                        //     time: "1 day ago"),

                        // Space.height(8),
                        // Center(
                        //   child: TextButton(
                        //     onPressed: () {},
                        //     child: FxText.bodyMedium("Write a Review",
                        //         letterSpacing: 0,
                        //         color: const Color(0xff1529e8),
                        //         // color: customTheme.groceryPrimary,
                        //         fontWeight: 600),
                        //   ),
                        // )
                      ],
                    ),
                  )),
      );
    }
  }

  Widget _singleReview(
      {required String image,
      required String name,
      required double rating,
      required String time,
      required String review}) {
    String dateString = time;
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    log('Format:$formattedDate');
    return Container(
      margin: FxSpacing.bottom(16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              // Container(
              //   width: 36,
              //   height: 36,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     image: DecorationImage(
              //         image: AssetImage(image), fit: BoxFit.fill),
              //   ),
              // ),
              SizedBox(
                height: 36,
                width: 36,
                child: CircleAvatar(
                  backgroundColor: theme.colorScheme.primary.withAlpha(28),
                  child: FxText.bodyLarge(name[0],
                      color: theme.colorScheme.primary,
                      fontSize: 30,
                      fontWeight: 600),
                ),
              ),
              Expanded(
                child: Container(
                  margin: FxSpacing.left(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FxText.bodyMedium(name, fontWeight: 600),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FxStarRating(
                              rating: rating,
                              activeColor: const Color(0xff1529e8),
                              // activeColor: customTheme.groceryPrimary,
                              showInactive: false,
                              spacing: 0),
                          FxSpacing.width(4),
                          FxText.bodyMedium(rating.toString(), fontWeight: 600)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              FxText.bodySmall(
                // time,
                formattedDate,
                muted: true,
                fontWeight: 600,
              )
            ],
          ),
          FxSpacing.height(8),
          FxText.bodySmall(
            "- $review",
          )
        ],
      ),
    );
  }

  Widget _buildRatingWidget(Totalrate) {
    List<int> ratingList = [0, 1, 2, 3, 4, 5];
    List<Widget> list = [];
    int maxRating = 5;
    for (int i = 5; i > 0; i--) {
      log('Total:$Totalrate');
      int progress = ((ratingList[i] / maxRating) * 100).ceil();
      list.add(Row(
        children: [
          Container(
            child: FxText.bodySmall(
                // i.toString(),
                i.toString(),
                color: theme.colorScheme.onBackground,
                fontWeight: 600),
          ),
          FxSpacing.width(4),
          Icon(
            MdiIcons.starOutline,
            color: theme.colorScheme.onBackground,
            size: 10,
          ),
          Expanded(
            child: Container(
              margin: FxSpacing.left(8),
              height: 4,
              decoration: BoxDecoration(
                  color: theme.colorScheme.onBackground.withAlpha(60),
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: progress,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                          color: FxColorUtils.getColorByRating()[i],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4))),
                    ),
                  ),
                  Expanded(
                    flex: 100 - progress,
                    child: Container(),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: FxSpacing.left(8),
            child: FxText.bodySmall(ratingList[i].toString(),
                color: theme.colorScheme.onBackground, muted: true),
          )
        ],
      ));
    }

    return FxContainer(
      padding: FxSpacing.all(16),
      bordered: true,
      border: Border.all(color: customTheme.border),
      color: Colors.white,
      // color: customTheme.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  margin: FxSpacing.fromLTRB(8, 0, 16, 0),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: FxSpacing.fromLTRB(0, 4, 2, 0),
                              child: FxText.titleSmall(
                                  widget.rating.toStringAsFixed(1),
                                  fontWeight: 600,
                                  letterSpacing: 0.25),
                            ),
                            Icon(
                              MdiIcons.starOutline,
                              color: theme.colorScheme.onBackground,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: FxSpacing.top(4),
                        child: FxText.bodySmall(
                            "${controller.reviewsget!.first.totalAttractionReviews} Ratings",
                            muted: true),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: list,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartList() {
    List<Widget> list = [];
    log('message');
    log('lendth:${controller.reviewsget!.first.attractionReviews.length}');
    for (var i = 0;
        i < controller.reviewsget!.first.attractionReviews.length;
        i++) {
      String dateString = controller
          .reviewsget!.first.attractionReviews[i].createdAt
          .toString();
      DateTime dateTime = DateTime.parse(dateString);
      String formattedDate =
          "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
      log('Format:$formattedDate');
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: Container(
          margin: FxSpacing.bottom(16),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  // Container(
                  //   width: 36,
                  //   height: 36,
                  //   decoration: const BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     image: DecorationImage(
                  //         image: AssetImage(
                  //             './assets/images/profile/avatar_2.jpg'),
                  //         fit: BoxFit.fill),
                  //   ),
                  // ),
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: CircleAvatar(
                      backgroundColor: theme.colorScheme.primary.withAlpha(28),
                      child: Center(
                        child: FxText.bodyLarge(
                            controller.reviewsget!.first.attractionReviews[i]
                                .user.name[0]
                                .toUpperCase(),
                            color: theme.colorScheme.primary,
                            fontSize: 15,
                            fontWeight: 600),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: FxSpacing.left(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FxText.bodyMedium(
                              controller.reviewsget!.first.attractionReviews[i]
                                  .user.name
                                  .toString(),
                              fontWeight: 600),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              FxStarRating(
                                  rating: controller.reviewsget!.first
                                      .attractionReviews[i].rating,
                                  activeColor: const Color(0xff1529e8),
                                  // activeColor: customTheme.groceryPrimary,
                                  showInactive: false,
                                  spacing: 0),
                              FxSpacing.width(4),
                              FxText.bodyMedium(
                                  controller.reviewsget!.first
                                      .attractionReviews[i].rating
                                      .toString(),
                                  fontWeight: 600)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  FxText.bodySmall(
                    formattedDate,
                    muted: true,
                    fontWeight: 600,
                  )
                ],
              ),
              FxSpacing.height(8),
              Align(
                alignment: Alignment.centerLeft,
                child: FxText.bodyMedium(
                  controller.reviewsget!.first.attractionReviews[i].description,
                  // fontSize: 12,
                ),
              )
            ],
          ),
        ),
      ));
    }
    return Column(
      children: list,
    );
  }
}
