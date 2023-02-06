import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import '../../controllers/add_money_controller.dart';
import '../../theme/app_theme.dart';

class addMoney extends StatefulWidget {
  const addMoney({Key? key}) : super(key: key);

  @override
  State<addMoney> createState() => _addMoneyState();
}

class _addMoneyState extends State<addMoney> with TickerProviderStateMixin {
  late addMoneyController controller;
  late ThemeData theme, theme1;
  // late OutlineInputBorder outlineInputBorder;
  late OutlineInputBorder outlineInputBorderenable;
  late OutlineInputBorder outlineInputBorderfocus;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    // outlineInputBorder = const OutlineInputBorder(
    //   borderRadius: BorderRadius.all(Radius.circular(4)),
    //   borderSide: BorderSide(
    //     color: Colors.transparent,
    //   ),
    // );
    outlineInputBorderenable = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.black26),
    );
    outlineInputBorderfocus = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Color(0xff1529e8)),
    );
    controller = FxControllerStore.put(addMoneyController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<addMoneyController>(
        controller: controller,
        builder: (controller) {
          return Container(
            padding: FxSpacing.xy(24, 16),
            height: MediaQuery.of(context).size.height * 35 / 100,
            decoration: const BoxDecoration(
                // color: customTheme.card,
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            child: ListView(
              children: [
                FxSpacing.height(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.bodyLarge(
                      'Add to Wallet',
                      fontWeight: 800,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        FeatherIcons.x,
                      ),
                    )
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
                // FadeTransition(
                //   opacity: controller.fadeAnimation,
                //   child: Container(
                //     child: Align(
                //       alignment: Alignment.centerLeft,
                //       child: FxText.bodyLarge(
                //         'Amount',
                //         color: Colors.red,
                //         // textAlign: TextAlign.left,
                //         letterSpacing: 0,
                //         fontWeight: 600,
                //       ),
                //     ),
                //   ),
                // ),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FxText.bodyLarge(
                      'Amount',

                      // textAlign: TextAlign.left,
                      letterSpacing: 0,
                      fontWeight: 600,
                    ),
                  ),
                ),
                FxSpacing.height(10),
                SlideTransition(
                  position: controller.amountAnimation,
                  child: TextFormField(
                    style: FxTextStyle.bodyMedium(),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        isDense: true,
                        // fillColor: theme.cardTheme.color,
                        fillColor: Colors.white,
                        // prefixIcon: Icon(
                        //   FeatherIcons.user,
                        //   color: theme.colorScheme.onBackground,
                        // ),
                        hintText: "Amount",
                        // enabledBorder: outlineInputBorder,
                        // focusedBorder: outlineInputBorder,
                        // border: outlineInputBorder,
                        enabledBorder: outlineInputBorderenable,
                        focusedBorder: outlineInputBorderfocus,
                        border: outlineInputBorderenable,
                        contentPadding: FxSpacing.all(16),
                        hintStyle: FxTextStyle.bodyMedium(),
                        isCollapsed: true),
                    maxLines: 1,
                    controller: controller.amountTE,
                    // validator: controller.validateName,
                    cursorColor: theme.colorScheme.onBackground,
                  ),
                ),

                FxSpacing.height(20),
                // Container(
                //   child: Row(
                //     children: [
                //       Expanded(
                //           child: FxContainer(
                //         onTap: () {
                //           // controller.closeEndDrawer();
                //           Navigator.pop(context);
                //         },
                //         color: Colors.transparent,
                //         padding: FxSpacing.y(12),
                //         child: Center(
                //           child: FxText(
                //             "Clear",
                //             color: const Color(0xff1529e8),
                //             // color: theme.colorScheme.primary,
                //             fontWeight: 600,
                //           ),
                //         ),
                //       )),
                //       Expanded(
                //           child: FxContainer.none(
                //         onTap: () {
                //           // controller.closeEndDrawer();
                //           Navigator.pop(context);
                //         },
                //         padding: FxSpacing.y(12),
                //         // color: theme.colorScheme.primary,
                //         color: const Color(0xff1529e8),
                //         child: Center(
                //           child: FxText(
                //             "Withdraw",
                //             color: theme.colorScheme.onPrimary,
                //             fontWeight: 600,
                //           ),
                //         ),
                //       )),
                //     ],
                //   ),
                // )
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(child: Container()),
                    FxContainer.none(
                      borderRadiusAll: 9,
                      onTap: () {
                        // controller.closeEndDrawer();
                        Navigator.pop(context);
                      },
                      padding: FxSpacing.xy(10, 12),
                      // color: theme.colorScheme.primary,
                      color: const Color(0xff1529e8),
                      child: Center(
                        child: FxText(
                          "Add",
                          color: theme.colorScheme.onPrimary,
                          fontWeight: 600,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
