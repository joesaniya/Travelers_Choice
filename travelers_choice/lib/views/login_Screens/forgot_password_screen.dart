import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import '/theme/app_theme.dart';

import '../../controllers/forgot_password_conntroller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late ForgotPasswordController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    controller = FxControllerStore.put(ForgotPasswordController(this));
    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<ForgotPasswordController>(
        controller: controller,
        builder: (controller) {
          return _buildBody1();
        });
  }

  Widget _buildBody() {
    return Scaffold(
      body: Padding(
        padding: FxSpacing.fromLTRB(
            20,
            0,
            // FxSpacing.safeAreaTop(context) + 48,
            20,
            20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FxText.displaySmall(
              'Forgot Password?',
              fontWeight: 700,
              textAlign: TextAlign.center,
            ),
            FxSpacing.height(20),
            FxText.bodyMedium(
              'Welcome to change password!!',
              muted: true,
              textAlign: TextAlign.center,
            ),
            FxSpacing.height(32),
            Form(
              key: controller.formKey,
              child: SlideTransition(
                position: controller.emailAnimation,
                child: TextFormField(
                  style: FxTextStyle.bodyMedium(),
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      isDense: true,
                      fillColor: theme.cardTheme.color,
                      prefixIcon: Icon(
                        FeatherIcons.mail,
                        color: theme.colorScheme.onBackground,
                      ),
                      hintText: "Email Address",
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: FxSpacing.all(16),
                      hintStyle: FxTextStyle.bodyMedium(),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: controller.emailTE,
                  validator: controller.validateEmail,
                  cursorColor: theme.colorScheme.onBackground,
                ),
              ),
            ),
            FxSpacing.height(20),
            FxButton.block(
              elevation: 0,
              borderRadiusAll: 4,
              onPressed: () {
                // controller.goToResetPasswordScreen();
              },
              splashColor: theme.colorScheme.onPrimary.withAlpha(30),
              // backgroundColor: theme.colorScheme.primary,
              backgroundColor: const Color(0xff1529e8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FxText.labelLarge(
                    "Submit",
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
            FxSpacing.height(16),
            Center(
              child: FxButton.text(
                onPressed: () {
                  controller.goToRegisterScreen();
                },
                splashColor: theme.colorScheme.primary.withAlpha(40),
                child: FxText.labelLarge(
                  "I haven't an account",
                  decoration: TextDecoration.underline,
                  // color: theme.colorScheme.primary
                  color: const Color(0xff1529e8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody1() {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
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
                    // Navigator.of(context, rootNavigator: true).pushReplacement(
                    //   MaterialPageRoute(
                    //     builder: (context) => const LogInScreen(),
                    //   ),
                    // );
                  },
                  child: const Icon(
                    FeatherIcons.chevronLeft,
                    size: 16,
                    color: Color(0xff1529e8),
                  ),
                ),
                Expanded(child: Container())
              ],
            ),
          ),
          FxSpacing.height(20),
          FxText.displaySmall(
            'Forgot Password?',
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
                          fillColor: theme.cardTheme.color,
                          prefixIcon: Icon(
                            FeatherIcons.mail,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "Email Address",
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.emailTE,
                      validator: controller.validateEmail,
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
              log('Email Id:${controller.emailTE.text}');
              controller.goToResetPasswordScreen(controller.emailTE.text);
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
          FxSpacing.height(16),
          Center(
            child: FxButton.text(
              onPressed: () {
                controller.goToRegisterScreen();
              },
              splashColor: theme.colorScheme.primary.withAlpha(40),
              child: FxText.labelLarge(
                "I haven't an account",
                decoration: TextDecoration.underline,
                // color: theme.colorScheme.primary
                color: const Color(0xff1529e8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
