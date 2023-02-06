import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import '../controllers/update_password_controller.dart';
import '../theme/app_theme.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late UpdatePasswordController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(UpdatePasswordController(this));
    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<UpdatePasswordController>(
        controller: controller,
        builder: (controller) {
          return Theme(
            data: theme.copyWith(
                colorScheme: theme.colorScheme.copyWith(
                    secondary: theme.colorScheme.primary.withAlpha(40))),
            child: _buildBody(),
          );
        });
  }

  Widget _buildBody() {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      // appBar: AppBar(
      //   elevation: 0,
      //   centerTitle: true,
      //   // title: FxText.titleLarge(
      //   //   singleProductController.product == null
      //   //       ? 'Please Wait for sometime'
      //   //       : singleProductController.product!.name,
      //   //   fontWeight: 600,
      //   // ),
      //   backgroundColor: Colors.transparent,
      //   leading: InkWell(
      //       onTap: () {
      //         Navigator.pop(context);
      //       },
      //       child: const Icon(
      //         FeatherIcons.chevronLeft,
      //         size: 20,
      //         color: Color(0xff1529e8),
      //       )),
      // ),
      body: ListView(
        // padding:
        //     FxSpacing.fromLTRB(20, FxSpacing.safeAreaTop(context) + 48, 20, 20),
        padding:
            FxSpacing.fromLTRB(20, FxSpacing.safeAreaTop(context) + 18, 20, 20),
        children: [
          Container(
            padding: FxSpacing.fromLTRB(16, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxContainer.bordered(
                  paddingAll: 10,
                  borderRadiusAll: 6,
                  color: const Color(0xff1529e8).withAlpha(28),
                  border:
                      Border.all(color: const Color(0xff1529e8).withAlpha(120)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    FeatherIcons.chevronLeft,
                    size: 16,
                    color: Color(0xff1529e8),
                  ),
                ),
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     FxContainer.bordered(
                //       paddingAll: 10,
                //       borderRadiusAll: 6,
                //       color: Colors.indigo.withAlpha(28),
                //       border: Border.all(color: Colors.indigo.withAlpha(120)),
                //       child: const Icon(FeatherIcons.map,
                //           size: 16, color: Colors.indigo),
                //     ),
                //     FxSpacing.width(16),
                //     FxContainer.bordered(
                //       paddingAll: 10,
                //       borderRadiusAll: 6,
                //       color: Colors.indigo.withAlpha(28),
                //       border: Border.all(color: Colors.indigo.withAlpha(120)),
                //       child: const Icon(
                //         FeatherIcons.phoneOutgoing,
                //         size: 16,
                //         color: Colors.indigo,
                //       ),
                //     ),
                //     FxSpacing.width(16),
                //     FxContainer.bordered(
                //       paddingAll: 10,
                //       borderRadiusAll: 6,
                //       color: Colors.indigo.withAlpha(28),
                //       border: Border.all(color: Colors.indigo.withAlpha(120)),
                //       child: const Icon(FeatherIcons.moreHorizontal,
                //           size: 16, color: Colors.indigo),
                //     ),
                //   ],
                // )
                Expanded(child: Container())
              ],
            ),
          ),
          FxSpacing.height(20),
          FxText.displaySmall(
            'Update Password',
            fontWeight: 700,
            textAlign: TextAlign.center,
          ),
          FxSpacing.height(20),
          FxText.bodyMedium(
            'Don\'t worry! \nNow you can reset your password easily',
            muted: true,
            textAlign: TextAlign.center,
          ),
          FxSpacing.height(32),
          FxContainer.bordered(
            // margin: FxSpacing.fromLTRB(24, 24, 24, 0),
            padding: FxSpacing.all(24),
            color: Colors.white,
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FxText.bodyLarge(
                        'Old Password',
                        // textAlign: TextAlign.left,
                        letterSpacing: 0,
                        fontWeight: 600,
                      ),
                    ),
                  ),
                  FxSpacing.height(10),
                  SlideTransition(
                    position: controller.oldpasswordAnimation,
                    child: TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: theme.cardTheme.color,
                          prefixIcon: Icon(
                            FeatherIcons.lock,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "Old Password",
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.oldpasswordTE,
                      validator: controller.validateoldPassword,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                  ),
                  FxSpacing.height(20),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FxText.bodyLarge(
                        'New Password',
                        // textAlign: TextAlign.left,
                        letterSpacing: 0,
                        fontWeight: 600,
                      ),
                    ),
                  ),
                  FxSpacing.height(10),
                  SlideTransition(
                    position: controller.passwordAnimation,
                    child: TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: theme.cardTheme.color,
                          prefixIcon: Icon(
                            FeatherIcons.lock,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "New Password",
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.passwordTE,
                      validator: controller.validatePassword,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                  ),
                  FxSpacing.height(20),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FxText.bodyLarge(
                        'Re-enter New Password',
                        // textAlign: TextAlign.left,
                        letterSpacing: 0,
                        fontWeight: 600,
                      ),
                    ),
                  ),
                  FxSpacing.height(10),
                  SlideTransition(
                    position: controller.resetPasswordAnimation,
                    child: TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: theme.cardTheme.color,
                          prefixIcon: Icon(
                            FeatherIcons.lock,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "Re-enter New Password",
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.confirmPasswordTE,
                      validator: controller.validateConfirmPassword,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
          ),
          FxSpacing.height(20),
          FxButton.block(
            elevation: 0,
            borderRadiusAll: 4,
            onPressed: () {
              controller.resetPassword();
            },
            splashColor: const Color(0xff1529e8).withAlpha(30),
            backgroundColor: const Color(0xff1529e8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FxText.labelLarge(
                  "Update Password",
                  fontWeight: 600,
                  color: theme.colorScheme.onPrimary,
                  letterSpacing: 0.4,
                ),
                FxSpacing.width(8),
                SlideTransition(
                    position: controller.arrowAnimation,
                    child: Icon(
                      FeatherIcons.arrowRight,
                      color: theme.colorScheme.onPrimary,
                      size: 20,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
