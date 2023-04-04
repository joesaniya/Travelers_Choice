import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:line_icons/line_icons.dart';

import '../../loading_effect.dart';
import '../../theme/app_theme.dart';
import '../controller/destination_controller.dart';

class DestinationAirport extends StatefulWidget {
  const DestinationAirport({super.key});

  @override
  State<DestinationAirport> createState() => _DestinationAirportState();
}

class _DestinationAirportState extends State<DestinationAirport>
    with TickerProviderStateMixin {
  late DestinationController controller;
  late ThemeData theme, theme1;

  @override
  void initState() {
    super.initState();

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(DestinationController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<DestinationController>(
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
        body: ListView(
          padding: FxSpacing.fromLTRB(
              20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
          children: [
            Container(
              // padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.cardTheme.color,
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          // FeatherIcons.chevronLeft,
                          Icons.arrow_back,
                          size: 30,
                        ),
                        FxSpacing.width(10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FxText.bodyMedium(
                                'FROM',
                                fontSize: 15,
                                fontWeight: 700,
                              ),
                              FxSpacing.height(7),
                              TextFormField(
                                style: FxTextStyle.bodyMedium(),
                                controller: controller.FromTE,
                                cursorColor: theme.colorScheme.primary,

                                //2
                                onChanged: (value) async {},

                                decoration: InputDecoration(
                                  hintText: "Enter any City/Airport Name",
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 4),
                                  hintStyle: FxTextStyle.bodySmall(
                                      color: theme.colorScheme.onBackground,
                                      fontSize: 15),
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
                                  // prefixIcon: Icon(
                                  //   FeatherIcons.search,
                                  //   size: 16,
                                  //   color: theme.colorScheme.onBackground
                                  //       .withAlpha(150),
                                  // ),
                                  isDense: true,
                                ),
                                textCapitalization:
                                    TextCapitalization.sentences,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FxSpacing.height(20),
            Container(
              // padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.cardTheme.color,
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          // FeatherIcons.chevronLeft,
                          LineIcons.planeArrival,
                          size: 30,
                        ),
                        FxSpacing.width(10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FxText.bodyMedium(
                                'TO',
                                fontSize: 15,
                                fontWeight: 700,
                              ),
                              FxSpacing.height(7),
                              TextFormField(
                                style: FxTextStyle.bodyMedium(),
                                controller: controller.toTE,
                                cursorColor: theme.colorScheme.primary,

                                //2
                                onChanged: (value) async {},

                                decoration: InputDecoration(
                                  hintText: "Enter any City/Airport Name",
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 4),
                                  hintStyle: FxTextStyle.bodySmall(
                                      color: theme.colorScheme.onBackground,
                                      fontSize: 15),
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
                                  // prefixIcon: Icon(
                                  //   FeatherIcons.search,
                                  //   size: 16,
                                  //   color: theme.colorScheme.onBackground
                                  //       .withAlpha(150),
                                  // ),
                                  isDense: true,
                                ),
                                textCapitalization:
                                    TextCapitalization.sentences,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FxSpacing.height(20),

            //airportname
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: FxText.bodyMedium(
                    'RECENT SEARCHES',
                    fontWeight: 700,
                  ),
                )
              ],
            )
          ],
        ),
      );
    }
  }
}
