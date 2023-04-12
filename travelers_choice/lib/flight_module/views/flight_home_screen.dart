import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/flight_module/widgets/multicity_widget.dart';

import '../../loading_effect.dart';
import '../../theme/app_theme.dart';
import '../controller/flight_home_controller.dart';
import '../widgets/Round_trip_widgets.dart';
import '../widgets/one_way_widgets.dart';

class FlightHomeScreen extends StatefulWidget {
  const FlightHomeScreen({super.key});

  @override
  State<FlightHomeScreen> createState() => _FlightHomeScreenState();
}

class _FlightHomeScreenState extends State<FlightHomeScreen>
    with TickerProviderStateMixin {
  late FlightHomeController controller;
  late ThemeData theme, theme1;
  double? customwidth;
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

  Widget _buildBottomContainer() {
    customwidth = MediaQuery.of(context).size.width / 2;
    final size = MediaQuery.of(context).size;
    return Flexible(
      flex: 5,
      child: Container(
          color: Colors.white,
          child: controller.tabbed == '1'
              ? const OneWayWidgets()
              : controller.tabbed == '2'
                  ? const RoundTripWidgets()
                  : const MultiCityWidgets()),
    );
  }

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
