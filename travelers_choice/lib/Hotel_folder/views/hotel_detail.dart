import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../../loading_effect.dart';
import '../../models/product_image.dart';
import '../../theme/app_theme.dart';
import '../controller/hotel_detail_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/description.dart';
import '../widgets/detail_info.dart';
import '../widgets/facilities.dart';
import '../widgets/image_container.dart';

class HotelDetail extends StatefulWidget {
  const HotelDetail({super.key});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail>
    with TickerProviderStateMixin {
  late HotelDetailController controller;
  late ThemeData theme, theme1;
  double? customwidth;
  @override
  void initState() {
    super.initState();

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(HotelDetailController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<HotelDetailController>(
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
          child: _buildFlightDetail(),
        ),
      );
    }
  }

  Widget _buildFlightDetail() {
    return ListView(
      children: const [
        //   FxContainer(
        //   color: Colors.transparent,
        //   paddingAll: 0,
        //   borderRadiusAll: 0,
        //   clipBehavior: Clip.hardEdge,
        //   marginAll: 0,
        //   height:
        //       HotelDetailController.containerType == ImageResType.landscape
        //           ? 200
        //           : 350,
        //   width: MediaQuery.of(context).size.width,
        //   child: PageView(
        //     allowImplicitScrolling: true,
        //     pageSnapping: true,
        //     physics: ClampingScrollPhysics(),
        //     controller: HotelDetailController.pageController,
        //     onPageChanged: (int page) {
        //       HotelDetailController.onPageChanged(page);
        //     },
        //     children: HotelDetailController.images.map((ProductImage image) {
        //       return FxContainer(
        //         borderRadiusAll: 8,
        //         clipBehavior: Clip.antiAliasWithSaveLayer,
        //         color: Colors.transparent,
        //         paddingAll: 0,
        //         margin: FxSpacing.x(HotelDetailController.containerType ==
        //                 ImageResType.landscape
        //             ? 0
        //             : 8),
        //         child: Image(
        //           image: AssetImage(image.url),
        //           fit: HotelDetailController.containerType ==
        //                   ImageResType.landscape
        //               ? BoxFit.fill
        //               : BoxFit.cover,
        //         ),
        //       );
        //     }).toList(),
        //   ),
        // ),

        ImageContainer(imageUrl: 'assets/hotel/grand.jpg'),
        DetailInfo(
          title: 'Luxuary Palace',
          rawRating: '5.0 (54)',
          price: '145 AED',
        ),
        Facilities(),
        Description(),
        CustomButton()
      ],
    );
  }
}
