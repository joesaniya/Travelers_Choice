import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/controllers/withdraw_money_controller.dart';

import '../../theme/app_theme.dart';

class withdrawMoney extends StatefulWidget {
  const withdrawMoney({Key? key}) : super(key: key);

  @override
  State<withdrawMoney> createState() => _withdrawMoneyState();
}

class _withdrawMoneyState extends State<withdrawMoney>
    with TickerProviderStateMixin {
  late WithdrawMoneyController controller;
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
    controller = FxControllerStore.put(WithdrawMoneyController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<WithdrawMoneyController>(
        controller: controller,
        builder: (controller) {
          return Container(
            height: MediaQuery.of(context).size.height * 65 / 100,
            padding: FxSpacing.xy(24, 16),
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
                      'Withdraw',
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

                        // enabledBorder: const OutlineInputBorder(
                        //   borderSide:
                        //       BorderSide(width: 1, color: Colors.red),
                        // ),
                        // focusedBorder: const OutlineInputBorder(
                        //   borderSide:
                        //       BorderSide(width: 1, color: Colors.indigo),
                        // ),
                        // border: const OutlineInputBorder(
                        //   borderSide:
                        //       BorderSide(width: 1, color: Colors.black),
                        // ),
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
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FxText.bodyLarge(
                      'Bank Name',
                      // textAlign: TextAlign.left,
                      letterSpacing: 0,
                      fontWeight: 600,
                    ),
                  ),
                ),
                FxSpacing.height(10),
                SlideTransition(
                  position: controller.bankNameAnimation,
                  child: TextFormField(
                    style: FxTextStyle.bodyMedium(),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white,
                        // prefixIcon: Icon(
                        //   FeatherIcons.user,
                        //   color: theme.colorScheme.onBackground,
                        // ),
                        hintText: "Bank Name",
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
                    controller: controller.bankNameTE,
                    // validator: controller.validateName,
                    cursorColor: theme.colorScheme.onBackground,
                  ),
                ),
                FxSpacing.height(20),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FxText.bodyLarge(
                      'IFSC Code',
                      // textAlign: TextAlign.left,
                      letterSpacing: 0,
                      fontWeight: 600,
                    ),
                  ),
                ),
                FxSpacing.height(10),
                SlideTransition(
                  position: controller.emailAnimation,
                  child: TextFormField(
                    style: FxTextStyle.bodyMedium(),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white,
                        // prefixIcon: Icon(
                        //   FeatherIcons.user,
                        //   color: theme.colorScheme.onBackground,
                        // ),
                        hintText: "IFSC Code",
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
                    controller: controller.emailTE,
                    // validator: controller.validateName,
                    cursorColor: theme.colorScheme.onBackground,
                  ),
                ),
                //4
                FxSpacing.height(20),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FxText.bodyLarge(
                      'Account Number',
                      // textAlign: TextAlign.left,
                      letterSpacing: 0,
                      fontWeight: 600,
                    ),
                  ),
                ),
                FxSpacing.height(10),
                SlideTransition(
                  position: controller.emailAnimation,
                  child: TextFormField(
                    style: FxTextStyle.bodyMedium(),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white,
                        // prefixIcon: Icon(
                        //   FeatherIcons.user,
                        //   color: theme.colorScheme.onBackground,
                        // ),
                        hintText: "Account Number",
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
                    controller: controller.emailTE,
                    // validator: controller.validateName,
                    cursorColor: theme.colorScheme.onBackground,
                  ),
                ),
                FxSpacing.height(20),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FxText.bodyLarge(
                      'Beneficiary Name',
                      // textAlign: TextAlign.left,
                      letterSpacing: 0,
                      fontWeight: 600,
                    ),
                  ),
                ),
                FxSpacing.height(10),
                SlideTransition(
                  position: controller.benefiaryNameAnimation,
                  child: TextFormField(
                    style: FxTextStyle.bodyMedium(),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white,
                        // prefixIcon: Icon(
                        //   FeatherIcons.user,
                        //   color: theme.colorScheme.onBackground,
                        // ),
                        hintText: "Beneficiary Name",
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
                    controller: controller.benefiaryNameTE,
                    // validator: controller.validateName,
                    cursorColor: theme.colorScheme.onBackground,
                  ),
                ),
                FxSpacing.height(20),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FxText.bodyLarge(
                      'Phone',
                      // textAlign: TextAlign.left,
                      letterSpacing: 0,
                      fontWeight: 600,
                    ),
                  ),
                ),
                FxSpacing.height(10),
                SlideTransition(
                  position: controller.phoneAnimation,
                  child: TextFormField(
                    style: FxTextStyle.bodyMedium(),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white,
                        // prefixIcon: Icon(
                        //   FeatherIcons.user,
                        //   color: theme.colorScheme.onBackground,
                        // ),
                        hintText: "Phone",
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
                    controller: controller.phoneTE,
                    // validator: controller.validateName,
                    cursorColor: theme.colorScheme.onBackground,
                  ),
                ),
                FxSpacing.height(20),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FxText.bodyLarge(
                      'IBAN Number',
                      // textAlign: TextAlign.left,
                      letterSpacing: 0,
                      fontWeight: 600,
                    ),
                  ),
                ),
                FxSpacing.height(10),
                SlideTransition(
                  position: controller.ibanNumberAnimation,
                  child: TextFormField(
                    style: FxTextStyle.bodyMedium(),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white,
                        // prefixIcon: Icon(
                        //   FeatherIcons.user,
                        //   color: theme.colorScheme.onBackground,
                        // ),
                        hintText: "Email",
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
                    controller: controller.ibanNumberTE,
                    // validator: controller.validateName,
                    cursorColor: theme.colorScheme.onBackground,
                  ),
                ),
                FxSpacing.height(20),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FxText.bodyLarge(
                      'Email',
                      // textAlign: TextAlign.left,
                      letterSpacing: 0,
                      fontWeight: 600,
                    ),
                  ),
                ),
                FxSpacing.height(10),
                SlideTransition(
                  position: controller.emailAnimation,
                  child: TextFormField(
                    style: FxTextStyle.bodyMedium(),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white,
                        // prefixIcon: Icon(
                        //   FeatherIcons.user,
                        //   color: theme.colorScheme.onBackground,
                        // ),
                        hintText: "Email",
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
                    controller: controller.emailTE,
                    // validator: controller.validateName,
                    cursorColor: theme.colorScheme.onBackground,
                  ),
                ),
                FxSpacing.height(20),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FxText.bodyLarge(
                      'Country',
                      // textAlign: TextAlign.left,
                      letterSpacing: 0,
                      fontWeight: 600,
                    ),
                  ),
                ),
                FxSpacing.height(10),
                SlideTransition(
                  position: controller.countryAnimation,
                  child: TextFormField(
                    style: FxTextStyle.bodyMedium(),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white,
                        // prefixIcon: Icon(
                        //   FeatherIcons.user,
                        //   color: theme.colorScheme.onBackground,
                        // ),
                        hintText: "Country",
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
                    controller: controller.countryTE,
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
                          "Withdraw",
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
