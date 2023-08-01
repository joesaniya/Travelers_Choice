import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import '../../controllers/post_review_controller.dart';
import '../../theme/app_theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PostReviewSheet extends StatefulWidget {
  String? reviewplace;
  PostReviewSheet({super.key, this.reviewplace});

  @override
  State<PostReviewSheet> createState() => _PostReviewSheetState();
}

class _PostReviewSheetState extends State<PostReviewSheet>
    with TickerProviderStateMixin {
  late ThemeData theme, theme1;

  late PostReviewController controller;
  late OutlineInputBorder outlineInputBorderenable;
  late OutlineInputBorder outlineInputBorderfocus;

  @override
  void initState() {
    super.initState();
    log('reviewplace:${widget.reviewplace}');
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(PostReviewController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });
    outlineInputBorderenable = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.black),
    );
    outlineInputBorderfocus = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Color(0xff1529e8)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<PostReviewController>(
        controller: controller,
        builder: (controller) {
          return Container(
            color: Colors.transparent,
            // height: 900,
            child: Container(
              padding: FxSpacing.xy(24, 16),
              decoration: const BoxDecoration(
                  // color: customTheme.card,
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText.bodyLarge(
                        'Tell us your experience !',
                        fontWeight: 800,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          FeatherIcons.x,
                        ),
                      )
                    ],
                  ),
                  FxSpacing.height(10),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          // color: customTheme.card,
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(13),
                              topRight: Radius.circular(13))),
                      padding: FxSpacing.xy(6, 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: ListView(
                              padding: FxSpacing.all(20),
                              children: [
                                FadeTransition(
                                  opacity: controller.fadeAnimation,
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: FxText.bodyLarge(
                                        'Title',
                                        // textAlign: TextAlign.left,
                                        letterSpacing: 0,
                                        fontWeight: 600,
                                      ),
                                    ),
                                  ),
                                ),
                                FxSpacing.height(10),
                                SlideTransition(
                                  position: controller.titleANimation,
                                  child: TextFormField(
                                    style: FxTextStyle.bodyMedium(),
                                    decoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        filled: true,
                                        isDense: true,
                                        fillColor: Colors.white,
                                        hintText: "Title",
                                        enabledBorder: outlineInputBorderenable,
                                        focusedBorder: outlineInputBorderfocus,
                                        border: outlineInputBorderenable,
                                        contentPadding: FxSpacing.all(16),
                                        hintStyle: FxTextStyle.bodyMedium(),
                                        isCollapsed: true),
                                    controller: controller.titleTE,
                                    keyboardType: TextInputType.text,
                                    cursorColor: theme.colorScheme.onBackground,
                                  ),
                                ),
                                FxSpacing.height(20),

                                //notes
                                FadeTransition(
                                  opacity: controller.fadeAnimation,
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: FxText.bodyLarge(
                                        'Notes',
                                        // textAlign: TextAlign.left,
                                        letterSpacing: 0,
                                        fontWeight: 600,
                                      ),
                                    ),
                                  ),
                                ),
                                FxSpacing.height(10),
                                SlideTransition(
                                  position: controller.reqAnimation,
                                  child: TextFormField(
                                    style: FxTextStyle.bodyMedium(),
                                    decoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        filled: true,
                                        isDense: true,
                                        fillColor: Colors.white,
                                        // prefixIcon: Icon(
                                        //   FeatherIcons.user,
                                        //   color: theme.colorScheme.onBackground,
                                        // ),
                                        hintText: "Type Your Thoughts",
                                        enabledBorder: outlineInputBorderenable,
                                        focusedBorder: outlineInputBorderfocus,
                                        border: outlineInputBorderenable,
                                        // enabledBorder: outlineInputBorder,
                                        // focusedBorder: outlineInputBorder,
                                        // border: outlineInputBorder,
                                        contentPadding: FxSpacing.all(16),
                                        hintStyle: FxTextStyle.bodyMedium(),
                                        isCollapsed: true),
                                    maxLines: 4,
                                    controller: controller.reqTE,
                                    // validator: controller.validateName,
                                    keyboardType: TextInputType.multiline,

                                    cursorColor: theme.colorScheme.onBackground,
                                  ),
                                ),
                                FxSpacing.height(20),
                                FadeTransition(
                                  opacity: controller.fadeAnimation,
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: FxText.bodyLarge(
                                        'Give Your Rating',
                                        // textAlign: TextAlign.left,
                                        letterSpacing: 0,
                                        fontWeight: 600,
                                      ),
                                    ),
                                  ),
                                ),
                                FxSpacing.height(10),
                                // implement the rating bar
                                Center(
                                  child: RatingBar(
                                      initialRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      ratingWidget: RatingWidget(
                                          full: const Icon(Icons.star,
                                              color: Colors.orange),
                                          half: const Icon(
                                            Icons.star_half,
                                            color: Colors.orange,
                                          ),
                                          empty: Icon(
                                            Icons.star_outline,
                                            color:
                                                theme.colorScheme.onBackground,
                                          )),
                                      onRatingUpdate: (value) {
                                        setState(() {
                                          controller.ratingValue = value;
                                        });
                                      }),
                                ),
                                // FxSpacing.height(20),
                                // Text(
                                //   controller.ratingValue != null
                                //       ? controller.ratingValue.toString()
                                //       : 'Rate it!',
                                //   style: const TextStyle(
                                //       color: Color(0xff1529e8), fontSize: 30),
                                // ),
                                // Display the rate in number
                                // Container(
                                //   width: 200,
                                //   height: 200,
                                //   decoration: const BoxDecoration(
                                //       color: Colors.red,
                                //       shape: BoxShape.circle),
                                //   alignment: Alignment.center,
                                //   child: Text(
                                //     controller.ratingValue != null
                                //         ? controller.ratingValue.toString()
                                //         : 'Rate it!',
                                //     style: const TextStyle(
                                //         color: Colors.white, fontSize: 30),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                    child: FxContainer(
                                  onTap: () {
                                    // controller.closeEndDrawer();

                                    Navigator.pop(context);
                                  },
                                  color: Colors.transparent,
                                  padding: FxSpacing.y(12),
                                  child: Center(
                                    child: FxText(
                                      "Clear",
                                      color: const Color(0xff1529e8),
                                      // color: theme.colorScheme.primary,
                                      fontWeight: 600,
                                    ),
                                  ),
                                )),
                                Expanded(
                                    child: FxContainer.none(
                                  onTap: () async {
                                    //   await ReviewAPIController()
                                    //     .postReview('hh', 'hhh', '1', context)
                                    //     .then((value) {
                                    //   if (value) {
                                    //     log('if');
                                    //   }
                                    // });
                                    // controller.Upload(widget.reviewplace);
                                    if (controller.titleTE.text.isEmpty ||
                                        controller.reqTE.text.isEmpty ||
                                        controller.ratingValue == null) {
                                      log('empty');
                                    } else {
                                      log('filled');

                                      String? temp =
                                          // await controller.ReviewAdd
                                          await controller.FilterattractionList(
                                        widget.reviewplace.toString(),
                                        controller.titleTE.text,
                                        controller.reqTE.text,
                                        controller.ratingValue.toString(),
                                        controller.token.toString(),
                                      );
                                      if (temp != null) {
                                        if (temp == 'Success') {}
                                      }

                                      setState(() {
                                        controller.reviewsget = [];

                                        // controller.reviewsget!.add(temp!);
                                      });

                                      Navigator.pop(context, temp);
                                    }

                                    // //d
                                    // log('filter apply clicked');
                                    // if (controller.reqTE.text != null ||
                                    //     controller.titleTE.text != null ||
                                    //     controller.ratingValue != null) {
                                    //   //todo
                                    //   log('not equal');
                                    //   GetReview? temp =
                                    //       await controller.ReviewAdd(
                                    //     widget.reviewplace.toString(),
                                    //     controller.titleTE.text,
                                    //     controller.reqTE.text,
                                    //     controller.ratingValue.toString(),
                                    //     controller.token.toString(),
                                    //   );

                                    //   setState(() {
                                    //     controller.reviewsget = [];

                                    //     controller.reviewsget!.add(temp!);
                                    //   });

                                    //   Navigator.pop(context, temp);
                                    // } else {
                                    //   log("Data search Null");
                                    //   ScaffoldMessenger.of(context)
                                    //       .showSnackBar(const SnackBar(
                                    //           content: Text(
                                    //               'Please Fill All Fields')));
                                    // }
                                  },
                                  padding: FxSpacing.y(12),
                                  // color: theme.colorScheme.primary,
                                  color: const Color(0xff1529e8),
                                  child: Center(
                                    child: FxText(
                                      "Apply",
                                      color: theme.colorScheme.onPrimary,
                                      fontWeight: 600,
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
