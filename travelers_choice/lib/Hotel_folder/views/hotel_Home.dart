import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/Hotel_folder/widgets/home_header.dart';
import 'package:hotel_travel/Hotel_folder/widgets/hotel_searchbar.dart';

import '../../loading_effect.dart';
import '../../theme/app_theme.dart';
import '../controller/hote_home_controller.dart';
import '../dummy.dart';
import '../widgets/chips.dart';
import '../widgets/nearby_grid.dart';
import '../widgets/popular_list.dart';

class HotelHome extends StatefulWidget {
  const HotelHome({super.key});

  @override
  State<HotelHome> createState() => _HotelHomeState();
}

class _HotelHomeState extends State<HotelHome> with TickerProviderStateMixin {
  late HotelHomeController controller;
  late ThemeData theme, theme1;
  double? customwidth;
  @override
  void initState() {
    super.initState();

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(HotelHomeController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<HotelHomeController>(
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
          // child: _buildHome(),
          child: _buildFlightHome(),
        ),
      );
    }
  }

  Widget _buildFlightHome() {
    return ListView(
      // padding: FxSpacing.fromLTRB(
      //     20,
      //     //  FxSpacing.safeAreaTop(context) + 20,
      //     0,
      //     20,
      //     0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.chevron_left),
              iconSize: 40,
            ),
            FxText.titleLarge(
              'Hotels',
              fontWeight: 700,
            ),
          ],
        ),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FxText.titleLarge(
                  'Find a perfect',
                  letterSpacing: 0,
                  fontWeight: 600,
                ),
                FxSpacing.height(5),
                FxText.bodyMedium(
                  'Hotel for you',
                  letterSpacing: 0,
                  fontWeight: 900,
                ),
                FxSpacing.height(9),
                // Row(
                //   children: [
                //     SvgPicture.asset('assets/icons/location.svg'),
                //     FxSpacing.width(5),
                //     FxText.bodyLarge(
                //       'United States',
                //       letterSpacing: 0,
                //       fontWeight: 600,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
        FxSpacing.height(15),
        const SearchBar(),
        const Chips(),
        PopularList(items: popular),
        NearbyGrid(data: nearby),
      ],
    );
  }

  Widget _buildHome() {
    return ListView(
      children: [
        const HomeHeader(),
        const SearchBar(),
        const Chips(),
        PopularList(items: popular),
        NearbyGrid(data: nearby),
      ],
    );
  }
}
