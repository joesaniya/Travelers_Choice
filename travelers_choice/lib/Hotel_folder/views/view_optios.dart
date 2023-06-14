import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/extensions/extensions.dart';
import 'package:line_icons/line_icons.dart';

import '../../loading_effect.dart';
import '../../models/tickets.dart';
import '../../theme/app_theme.dart';
import '../controller/view_options_controller.dart';

class ViewOptions extends StatefulWidget {
  const ViewOptions({super.key});

  @override
  State<ViewOptions> createState() => _ViewOptionsState();
}

class _ViewOptionsState extends State<ViewOptions>
    with TickerProviderStateMixin {
  late ViewOptionsController controller;
  late ThemeData theme, theme1;
  double? customwidth;
  @override
  void initState() {
    super.initState();

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(ViewOptionsController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<ViewOptionsController>(
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
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              controller.goBack();
            },
            child: const Icon(
              FeatherIcons.chevronLeft,
              size: 20,
              // color: theme.colorScheme.onBackground,
              color: Colors.white,
            ).autoDirection(),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: FxText.titleMedium(
            'view Options',
            fontWeight: 700,
            color: Colors.white,
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            _buildCartList(),
            // FxSpacing.height(20),
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
                                  onTap: () async {},
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
                                            // controller.selectedtour.length
                                            //     .toString(),
                                            '4',
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
                              child: FadeTransition(
                                opacity: controller.fadeAnimation,
                                child: FxButton.block(
                                    onPressed: () {
                                      log('checkout calling');
                                      // Navigator.of(context, rootNavigator: true)
                                      //     .push(PageRouteBuilder(
                                      //         transitionDuration:
                                      //             const Duration(
                                      //                 milliseconds: 500),
                                      //         transitionsBuilder: (
                                      //           BuildContext context,
                                      //           Animation<double> animation,
                                      //           Animation<double>
                                      //               secondaryAnimation,
                                      //           Widget child,
                                      //         ) =>
                                      //             FadeTransition(
                                      //               opacity: animation,
                                      //               child: child,
                                      //             ),
                                      //         pageBuilder: (_, __, ___) =>
                                      //             HotelCheckOutScreen()));
                                    },
                                    backgroundColor: const Color(0xff1529e8),
                                    // backgroundColor: theme.colorScheme.primary,
                                    elevation: 0,
                                    borderRadiusAll: 4,
                                    child: Row(
                                      children: [
                                        SlideTransition(
                                          position: controller.animation,
                                          child: Image(
                                            height: 22,
                                            width: 22,
                                            color: theme.colorScheme.onPrimary,
                                            image: const AssetImage(
                                                'assets/images/apps/shopping2/icons/clear_cart_outline.png'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: FxText.bodyMedium(
                                              'Checkout',
                                              fontWeight: 600,
                                              color:
                                                  theme.colorScheme.onPrimary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  Widget _buildCartList() {
    log('calling Options');
    List<Widget> list = [];
    for (Tickets ticket1 in controller.tickets!) {
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: GestureDetector(
          onTap: () {},
          child: Card(
            shadowColor: Colors.black,
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            // color: const Color(0xff5c69e0),
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.only(top: 8, left: 10, right: 10),
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.grey.shade300, width: 1)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FxText.bodyMedium(
                          'Deluxe King Room',
                          color: Colors.indigo,
                          fontWeight: 900,
                        ),
                        Checkbox(
                            //only check box
                            value: controller.check1, //unchecked
                            onChanged: (bool? value) {
                              //value returned when checkbox is clicked
                              setState(() {
                                controller.check1 = value;
                              });
                            }),
                      ],
                    ),
                    FxSpacing.height(10),
                    Row(
                      children: [
                        FxText.bodySmall(
                          'Price for:',
                        ),
                        const Icon(
                          LineIcons.user,
                          size: 15,
                        ),
                        const Icon(
                          LineIcons.user,
                          size: 15,
                        )
                      ],
                    ),
                    FxSpacing.height(10),
                    Row(
                      children: [
                        const Icon(
                          LineIcons.bed,
                          size: 15,
                        ),
                        FxText.bodySmall(
                          '1 double bed',
                          fontSize: 14,
                        ),
                      ],
                    ),
                    FxSpacing.height(10),
                    Row(
                      children: [
                        FxText.bodySmall(
                          'Size:',
                        ),
                        FxText.bodySmall(
                          '1506 ft2',
                        ),
                      ],
                    ),
                    FxSpacing.height(10),
                    Row(
                      children: [
                        const Icon(
                          LineIcons.creditCard,
                          size: 15,
                          color: Colors.green,
                        ),
                        FxText.bodySmall(
                          'No credit card needed',
                          fontSize: 14,
                          fontWeight: 700,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    FxSpacing.height(10),
                    Row(
                      children: [
                        const Icon(
                          Icons.done,
                          size: 15,
                          color: Colors.green,
                        ),
                        FxText.bodySmall(
                          'Free Cancellation anytime',
                          fontSize: 14,
                          fontWeight: 700,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    FxSpacing.height(10),
                    Row(
                      children: [
                        const Icon(
                          LineIcons.clock,
                          size: 15,
                        ),
                        FxText.bodySmall(
                          'Pay at the Property',
                        ),
                      ],
                    ),
                    FxSpacing.height(10),
                    Container(
                      child: Wrap(
                          // spacing: 10,
                          runSpacing: 10,
                          children: List.generate(
                            controller.featuresList.length,
                            (index) {
                              return Container(
                                color: Colors.transparent,
                                width: 114,
                                child: Row(
                                  children: [
                                    Icon(
                                      controller.featuresList[index]['icon'],
                                      size: 10,
                                    ),
                                    FxSpacing.width(4),
                                    FxText.bodySmall(
                                      controller.featuresList[index]['title'],
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
                    ),
                    FxSpacing.height(10),
                    const Divider(
                      color: Colors.grey,
                    ),
                    FxSpacing.height(10),
                    Row(
                      children: [
                        FxContainer(
                          // borderRadiusAll: 10,
                          borderRadiusAll: 5,
                          // padding: FxSpacing.xy(8, 4),
                          padding: FxSpacing.xy(6, 2),
                          // color: Color(0xff1529e8),
                          color: Colors.green,
                          child: Center(
                            child: FxText.bodySmall(
                              '10% off',
                              fontWeight: 300,
                              color: Colors.white,
                              // color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        FxSpacing.width(10),
                        FxContainer(
                          borderRadiusAll: 5,
                          // padding: FxSpacing.xy(8, 4),
                          padding: FxSpacing.xy(6, 2),
                          // color: Color(0xff1529e8),
                          color: Colors.green,
                          child: Center(
                            child: FxText.bodySmall(
                              'Mobile Price Only',
                              fontWeight: 300,
                              color: Colors.white,
                              // color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    FxSpacing.height(10),
                    FxText.bodySmall(
                      'Price for 1 night',
                    ),
                    FxSpacing.height(10),
                    FxText.bodySmall(
                      'Rs. 1,166',
                      color: Colors.black,
                      fontWeight: 900,
                      fontSize: 17,
                    ),
                    FxSpacing.height(10),
                    Container(
                      decoration: BoxDecoration(
                          color: theme.cardTheme.color,
                          // color: const Color(0xff1529e8),
                          borderRadius: BorderRadius.circular(4)),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Expanded(
                                child: FxText.labelLarge(
                                  "Select Room Count",
                                  fontWeight: 600,
                                  color: Colors.black,
                                  // color: theme.colorScheme.onPrimary,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                          items: controller.roomCodes.map((String value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Center(
                                  child: Text(
                                    value,
                                    style: FxTextStyle.bodyMedium(),
                                  ),
                                ));
                          }).toList(),

                          value: controller.selectedroom,
                          onChanged: (value) {
                            setState(() {
                              controller.selectedroom = value.toString();
                            });
                          },

                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 20,
                          iconEnabledColor: Colors.black,
                          iconDisabledColor: Colors.black,
                          buttonHeight: 30,
                          buttonWidth: 200,
                          buttonPadding: const EdgeInsets.only(
                              left: 14, right: 14, top: 4, bottom: 4),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: theme.cardTheme.color,
                          ),

                          itemHeight: 40,
                          // itemWidth: 200,
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          dropdownMaxHeight: 200,
                          dropdownPadding: null,

                          scrollbarRadius: const Radius.circular(40),
                          scrollbarThickness: 2,
                          scrollbarAlwaysShow: true,
                          offset: const Offset(0, 0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ));
    }
    return ListView(
      children: list,
    );
  }
}
