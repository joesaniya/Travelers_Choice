import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../../models/product.dart';
import '../../models/product_image.dart';

enum ImageResType { portrait, landscape, mixed }

class HotelDetailController extends FxController {
  TickerProvider ticker;
  HotelDetailController(this.ticker);
  bool uiLoading = true, showLoading = true;
  ImageResType containerType = ImageResType.landscape;
  late int numPages;

  PageController pageController = PageController(initialPage: 1);
  int currentPage = 1;

  late List<ProductImage> images;
  Product? product;

  void fetchloader() async {
    await Future.delayed(const Duration(seconds: 4));

    uiLoading = false;
    log('fetchloader');
    log(uiLoading.toString());
    update();
  }

  @override
  void initState() {
    super.initState();
    fetchloader();
    initData();
  }

  void initData() async {
    images = await ProductImage.getDummyList();
    product = await Product.getOne();
    numPages = images.length;
    for (ProductImage image in images) {
      ImageResType type = getResType(image);
      if (type == ImageResType.portrait) {
        containerType = ImageResType.portrait;
        break;
      }
    }

    if (containerType == ImageResType.portrait) {
      pageController = PageController(
        initialPage: 1,
        viewportFraction: 0.7,
      );
    }
    await Future.delayed(const Duration(seconds: 1));
    showLoading = false;
    uiLoading = false;
    update();
  }

  onPageChanged(int page, {bool fromUser = false}) async {
    if (!fromUser) currentPage = page;
    update();
    if (fromUser) {
      await pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  getResType(ProductImage image) {
    if (image.height < image.width) {
      return ImageResType.landscape;
    } else {
      return ImageResType.portrait;
    }
  }

  @override
  String getTag() {
    return "Hotel_detail-Controller";
  }
}
