import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/extensions/extensions.dart';

import '../../loading_effect.dart';
import '../../theme/app_theme.dart';
import '../controller/seat_page_controller.dart';
import '../widgets/flight_logo.dart';

class SeatPage extends StatefulWidget {
  const SeatPage({super.key});

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> with TickerProviderStateMixin {
  late SeatPageController controller;
  late ThemeData theme, theme1;
  double? customwidth;
  @override
  void initState() {
    super.initState();

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(SeatPageController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  Widget seatWidget(int seatNum) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(1, 3), // changes position of shadow
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              print("Seat Click: $seatNum");
            },
            child: Center(
              child: Text(
                (seatNum < 9 ? '0' : '') + seatNum.toString(),
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<SeatPageController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  String ticket = 'Aaaak';

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
            elevation: 0,
            title: FxText.titleMedium(
              'Select Your Favorite Seat',
              color: Colors.white,
              fontWeight: 700,
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
                // controller.goBack(canRefresh: true);
              },
              child: const Icon(
                FeatherIcons.chevronLeft,
                size: 20,
              ).autoDirection(),
            ),
          ),
          // body: SafeArea(
          //   child: Container(),
          //   // child: _buildColumn(),
          // ),
          body: Padding(
            padding: FxSpacing.fromLTRB(
                20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
            child: Column(
              // padding: FxSpacing.fromLTRB(
              //     20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
              children: [
                title(),
                sitstatus(),
                seat(),
              ],
            ),
          ));
    }
  }

  Widget seat() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              const Image(
                image: AssetImage('assets/seat/plane_layout.png'),
              ),
              Positioned(
                  left: 0.0,
                  top: 140.0,
                  bottom: 0.0,
                  right: 10.0,
                  child: Column(
                    children: [
                      const EmiratesLogo(),
                      FxSpacing.height(15),
                      FxText.bodyMedium(
                        '5h 46m',
                        fontWeight: 900,
                        color: Colors.black,
                      ),
                      FxSpacing.height(25),
                      FxText.bodyMedium(
                        'Economy',
                        fontWeight: 900,
                        color: Colors.black,
                      ),
                    ],
                  )),
              Positioned(
                left: 32.0,
                // top: 225.0,
                top: 280,
                bottom: 0.0,
                right: 10.0,
                child: Column(
                  children: <Widget>[
                    // TotalSeats(),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                seatWidget(1),
                                seatWidget(2),
                                const Spacer(
                                  flex: 1,
                                ),
                                seatWidget(3),
                                seatWidget(4),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                seatWidget(5),
                                seatWidget(6),
                                const Spacer(
                                  flex: 1,
                                ),
                                seatWidget(7),
                                seatWidget(8),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                seatWidget(9),
                                seatWidget(10),
                                const Spacer(
                                  flex: 1,
                                ),
                                seatWidget(11),
                                seatWidget(12),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                seatWidget(13),
                                seatWidget(14),
                                const Spacer(
                                  flex: 1,
                                ),
                                seatWidget(15),
                                seatWidget(16),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                seatWidget(17),
                                seatWidget(18),
                                const Spacer(
                                  flex: 1,
                                ),
                                seatWidget(19),
                                seatWidget(20),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                seatWidget(21),
                                seatWidget(22),
                                const Spacer(
                                  flex: 1,
                                ),
                                seatWidget(23),
                                seatWidget(24),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                seatWidget(25),
                                seatWidget(26),
                                const Spacer(
                                  flex: 1,
                                ),
                                seatWidget(27),
                                seatWidget(28),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                seatWidget(29),
                                seatWidget(30),
                                const Spacer(
                                  flex: 1,
                                ),
                                seatWidget(31),
                                seatWidget(32),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                seatWidget(33),
                                seatWidget(34),
                                const Spacer(
                                  flex: 1,
                                ),
                                seatWidget(35),
                                seatWidget(36),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                seatWidget(37),
                                seatWidget(38),
                                const Spacer(
                                  flex: 1,
                                ),
                                seatWidget(39),
                                seatWidget(40),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                seatWidget(41),
                                seatWidget(42),
                                seatWidget(42),
                                seatWidget(43),
                                seatWidget(44),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            // flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const SizedBox(height: 65.0),
                FxText.bodyMedium(
                  'KAR',
                  fontSize: 20,
                ),
                FxText.bodyMedium(
                  'Karachi',
                  fontSize: 18,
                  fontWeight: 900,
                ),
                const SizedBox(height: 20.0),
                // const EmiratesLogo(),
                FxText.bodyMedium(
                  '9h 28m',
                  fontSize: 18,
                  fontWeight: 900,
                ),
                const SizedBox(height: 30.0),
                FxText.bodyMedium(
                  'ADA',
                  fontSize: 20,
                ),
                FxText.bodyMedium(
                  'Adana',
                  fontSize: 18,
                  fontWeight: 900,
                ),
                const SizedBox(height: 30.0),
                FxText.bodyMedium(
                  'FLIGHT NO',
                  fontSize: 18,
                  fontWeight: 900,
                ),
                const SizedBox(height: 5.0),
                FxText.bodyMedium(
                  'SQ60',
                  fontSize: 18,
                  fontWeight: 600,
                  color: Colors.indigo,
                ),
                const SizedBox(height: 30.0),
                FxText.bodyMedium(
                  'Seat',
                  fontSize: 18,
                  fontWeight: 900,
                ),
                FxText.bodyMedium(
                  'T5',
                  fontSize: 18,
                  fontWeight: 900,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget title() {
    return Container(
      // margin: const EdgeInsets.only(top: 50),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FxText(
          'Select Your Favorite\nSeat',
          // style: blackTextStyle.copyWith(fontSize: 24, fontWeight: semibold),
        ),
      ),
    );
  }

  Widget sitstatus() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 6),
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/seat/avaliable.png'))),
          ),
          FxText(
            'Available',
            // style: blackTextStyle.copyWith(),
          ),
          Container(
            margin: const EdgeInsets.only(right: 6, left: 10),
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/seat/selected.png'))),
          ),
          FxText(
            'Selected',
            // style: blackTextStyle.copyWith(),
          ),
          Container(
            margin: const EdgeInsets.only(right: 6, left: 10),
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/seat/unavailable.png'))),
          ),
          FxText(
            'Unvailable',
            // style: blackTextStyle.copyWith(),
          )
        ],
      ),
    );
  }
}
