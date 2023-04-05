import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/extensions/extensions.dart';

import '../../loading_effect.dart';
import '../../theme/app_theme.dart';
import '../controller/seat_page_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<SeatPageController>(
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
          body: ListView(
            padding: FxSpacing.fromLTRB(
                20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
            children: [
              title(),
              sitstatus(),
            ],
          ));
    }
  }

  Widget title() {
    return Container(
      // margin: const EdgeInsets.only(top: 50),
      child: FxText(
        'Select Your Favorite\nSeat',
        // style: blackTextStyle.copyWith(fontSize: 24, fontWeight: semibold),
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
