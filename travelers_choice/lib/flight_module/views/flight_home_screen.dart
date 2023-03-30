import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:line_icons/line_icons.dart';

import '../../loading_effect.dart';
import '../../theme/app_theme.dart';
import '../controller/flight_home_controller.dart';

class FlightHomeScreen extends StatefulWidget {
  const FlightHomeScreen({super.key});

  @override
  State<FlightHomeScreen> createState() => _FlightHomeScreenState();
}

class _FlightHomeScreenState extends State<FlightHomeScreen>
    with TickerProviderStateMixin {
  late FlightHomeController controller;
  late ThemeData theme, theme1;
  @override
  void initState() {
    super.initState();

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(FlightHomeController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  Widget _buildColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // First blue container
          _buildTopContainer(),
          // Button with offset
          _buildMidContainerWithButton(),
          // Bottom white container
          _buildBottomContainer(),
        ],
      );

  Widget _buildTopContainer() => Container(
        height: 100,
        width: double.infinity,
        // color: Colors.blue[900],

        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black54),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                // IconButton(
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //     icon: const Icon(Icons.arrow_back_ios)),
                FxSpacing.width(10),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new)),
                FxSpacing.width(10),
                FxText.bodyLarge(
                  'Flight ',
                  fontWeight: 500,
                  fontSize: 20,
                ),

                FxText.bodyLarge(
                  'Search',
                  fontWeight: 900,
                  fontSize: 20,
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildMidContainerWithButton() {
    const buttonHeight = 50.0;
    return Stack(
      children: [
        // Use same background color like the second container
        Container(height: buttonHeight, color: Colors.white),
        // Translate the button
        Transform.translate(
          offset: const Offset(0.0, -buttonHeight / 2.0),
          child: Center(
            child: GestureDetector(
              onTap: () {/* do stuff */},
              child: Container(
                height: buttonHeight,
                decoration: BoxDecoration(
                  // color: Colors.orange[400],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  // borderRadius: BorderRadius.circular(buttonHeight / 2.0),
                  // boxShadow: [
                  //   BoxShadow(
                  //     blurRadius: 5.0,
                  //     offset: const Offset(0.0, 6.0),
                  //     color: Colors.black.withOpacity(0.16),
                  //   ),
                  // ],
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black54, // shadow color
                        blurRadius: 10, // shadow radius
                        offset: Offset(5, 5), // shadow offset
                        spreadRadius:
                            0.1, // The amount the box should be inflated prior to applying the blur
                        blurStyle: BlurStyle.normal // set blur style
                        ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      // padding: const EdgeInsets.only(left: 8.0),
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.tabbed = '1';
                              setState(() {});
                            },
                            child: FxContainer(
                              height: 30,
                              borderRadiusAll: 7,
                              padding: FxSpacing.xy(6, 6),
                              color: controller.tabbed == '1'
                                  ? const Color(0xff1529e8)
                                  : Colors.transparent,
                              child: Center(
                                child: Text(
                                  'ONEWAY',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600,
                                    color: controller.tabbed == '1'
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FxSpacing.width(10),
                          GestureDetector(
                            onTap: () {
                              controller.tabbed = '2';
                              setState(() {});
                            },
                            child: FxContainer(
                              height: 30,
                              borderRadiusAll: 7,
                              padding: FxSpacing.xy(6, 6),
                              color: controller.tabbed == '2'
                                  ? const Color(0xff1529e8)
                                  : Colors.transparent,
                              child: Center(
                                child: Text(
                                  'ROUNDTRIP',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600,
                                    color: controller.tabbed == '2'
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FxSpacing.width(10),
                          GestureDetector(
                            onTap: () {
                              controller.tabbed = '3';
                              setState(() {});
                            },
                            child: FxContainer(
                              height: 30,
                              borderRadiusAll: 7,
                              padding: FxSpacing.xy(6, 6),
                              color: controller.tabbed == '3'
                                  ? const Color(0xff1529e8)
                                  : Colors.transparent,
                              child: Center(
                                child: Text(
                                  'MULTICITY',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600,
                                    color: controller.tabbed == '3'
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // child: Row(
                //   children: [
                //     FxContainer(
                //       borderRadiusAll: 7,
                //       padding: FxSpacing.xy(6, 2),
                //       color: Colors.indigo,
                //       child: FxText.bodySmall(
                //         'ONE WAY',
                //       ),
                //     )
                //   ],
                // ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomContainer() => Flexible(
        flex: 5,
        child: Container(
          color: Colors.white,
          child: controller.tabbed == '1'
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Container(
                        // margin: const EdgeInsets.symmetric(horizontal: 20),
                        // color: Colors.grey.shade200,
                        // borderColor: Colors.amber,
                        // border: Border.all(
                        //     // color: Colors.grey.shade800,
                        //     color: Colors.black,
                        //     width: 1),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 70,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
                          border: Border.all(color: Colors.black12, width: 1),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              LineIcons.planeDeparture,
                              size: 29,
                            ),
                            FxSpacing.width(10),
                            Column(
                              children: [
                                FxText.labelMedium('FROM'),
                                Row(
                                  children: [
                                    FxText.labelLarge('New Delhi'),
                                    FxSpacing.width(10),
                                    FxText.labelMedium('DEL')
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ])
              : controller.tabbed == '2'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                          Text(
                            '2',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ])
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                          Text(
                            'Bottom container',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ]),
        ),
      );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<FlightHomeController>(
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
        body: SafeArea(
          child: _buildColumn(),
        ),
      );
    }
  }
}
