import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../../controllers/checkout_controller.dart';
import '../../controllers/payment_Selection_Controller.dart';
import '../../localizations/language.dart';
import '../../theme/app_theme.dart';

class paymentSelection extends StatefulWidget {
  const paymentSelection({Key? key}) : super(key: key);

  @override
  State<paymentSelection> createState() => _paymentSelectionState();
}

class _paymentSelectionState extends State<paymentSelection>
    with TickerProviderStateMixin {
  late payemtSelectionController controller;
  late CheckOutController controller1;
  late ThemeData theme, theme1;
  // late OutlineInputBorder outlineInputBorder;
  late OutlineInputBorder outlineInputBorderenable;
  late OutlineInputBorder outlineInputBorderfocus;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;

    controller = FxControllerStore.put(payemtSelectionController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });
    controller1 = FxControllerStore.put(CheckOutController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<payemtSelectionController>(
        controller: controller,
        builder: (controller) {
          return Container(
            padding: FxSpacing.xy(24, 16),
            height: MediaQuery.of(context).size.height * 35 / 100,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                // color: theme.colorScheme.primary.withAlpha(28),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            child: ListView(
              children: [
                FxSpacing.height(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: FxText.bodyLarge(
                        'Cancel',
                        color: const Color(0xff1529e8),
                        fontWeight: 500,
                      ),
                    ),
                    FxSpacing.width(20),
                    FxText.bodyLarge(
                      'Select Payment Method',
                      fontWeight: 800,
                    ),
                  ],
                ),
                FxSpacing.height(12),
                FxDashedDivider(
                  dashSpace: 4,
                  dashWidth: 8,
                  color: theme.colorScheme.onBackground.withAlpha(180),
                  height: 1.2,
                ),
                FxSpacing.height(20),
                payment("assets/images/apps/shopping2/icons/razor_logo.png",
                    "RazorPay"),
                FxSpacing.height(20),
                FxContainer.none(
                  borderRadiusAll: 9,
                  onTap: () async {
                    // Navigator.pop(context);
                    await controller1.pageController.animateToPage(
                      controller1.currentPage + 1,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.ease,
                    );
                  },
                  padding: FxSpacing.xy(10, 12),
                  // color: theme.colorScheme.primary,
                  color: const Color(0xff1529e8),
                  child: Center(
                    child: FxText(
                      "Pay",
                      color: theme.colorScheme.onPrimary,
                      fontWeight: 600,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget payment(String image, String title) {
    return FxContainer.bordered(
        paddingAll: 12,
        // color: Colors.white,
        color: controller.selected
            ? theme.colorScheme.primary.withAlpha(40)
            : Colors.white,
        child: controller.selected
            ? Row(
                children: [
                  Image(
                    height: 24,
                    image: AssetImage(image),
                  ),
                  FxSpacing.height(8),
                  FxText.bodySmall(title),
                  Expanded(
                    child: Align(
                      alignment: Language.autoDirection<AlignmentGeometry>(
                          Alignment.centerRight, Alignment.centerLeft)!,
                      child: FxContainer.roundBordered(
                        paddingAll: 4,
                        border: Border.all(color: theme.colorScheme.primary),
                        color: theme.colorScheme.primary.withAlpha(40),
                        child: Icon(
                          Icons.check,
                          color: theme.colorScheme.primary,
                          size: 10,
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Row(
                children: [
                  Image(
                    height: 24,
                    image: AssetImage(image),
                  ),
                  FxSpacing.height(8),
                  FxText.bodySmall(title),
                ],
              ));
  }
}
