import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import '../../controllers/confirm_password_controller.dart';
import '/theme/app_theme.dart';

import 'login_screen.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  String? email;
  ConfirmPasswordScreen(this.email, {Key? key}) : super(key: key);

  @override
  _ConfirmPasswordScreenState createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late ConfirmPasswordController controller;
  late OutlineInputBorder outlineInputBorder;

  bool _obscureText = true;
  bool _obscureText1 = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  String? mailId;

  @override
  void initState() {
    super.initState();
    log('Mail Id:$mailId');
    mailId = widget.email;
    theme = AppTheme.shoppingTheme;
    controller = FxControllerStore.put(ConfirmPasswordController(this));
    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<ConfirmPasswordController>(
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
              'Create New Password',
              fontWeight: 700,
              textAlign: TextAlign.center,
            ),
            FxSpacing.height(20),
            FxText.bodyMedium(
              'OTP sent to ${widget.email} ',
              muted: true,
              textAlign: TextAlign.center,
            ),
            FxSpacing.height(32),
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  SlideTransition(
                    position: controller.newPasswordAnimation,
                    child: TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      obscureText: _obscureText1,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: theme.cardTheme.color,
                          prefixIcon: Icon(
                            FeatherIcons.lock,
                            color: theme.colorScheme.onBackground,
                          ),
                          suffixIconColor: Colors.grey,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            color: Colors.grey,
                            onPressed: _toggle1,
                          ),
                          hintText: "New Password",
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.newPasswordTE,
                      validator: controller.validatePassword,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SlideTransition(
                    position: controller.confirmPasswordAnimation,
                    child: TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: theme.cardTheme.color,
                          prefixIcon: Icon(
                            FeatherIcons.lock,
                            color: theme.colorScheme.onBackground,
                          ),
                          suffixIconColor: Colors.grey,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            color: Colors.grey,
                            onPressed: _toggle,
                          ),
                          hintText: "Re-enter Password",
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.confirmPasswordTE,
                      validator: controller.validatePassword2,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SlideTransition(
                    position: controller.otpAnimation,
                    child: TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: theme.cardTheme.color,
                          prefixIcon: Icon(
                            Icons.lock_open,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "Enter OTP",
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.otpTE,
                      validator: controller.validateOtp,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
            FxSpacing.height(20),
            FxButton.block(
              elevation: 0,
              borderRadiusAll: 4,
              onPressed: () {
                // controller.goToLoginScreen();
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
                    // Navigator.pop(context);
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LogInScreen(),
                      ),
                    );
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
            'Create New Password',
            fontWeight: 700,
            textAlign: TextAlign.center,
          ),
          FxSpacing.height(20),
          FxText.bodyMedium(
            'OTP sent to ${widget.email} ',
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
                  SlideTransition(
                    position: controller.newPasswordAnimation,
                    child: TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      obscureText: _obscureText1,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: theme.cardTheme.color,
                          prefixIcon: Icon(
                            FeatherIcons.lock,
                            color: theme.colorScheme.onBackground,
                          ),
                          suffixIconColor: Colors.grey,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            color: Colors.grey,
                            onPressed: _toggle1,
                          ),
                          hintText: "New Password",
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.newPasswordTE,
                      validator: controller.validatePassword,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SlideTransition(
                    position: controller.confirmPasswordAnimation,
                    child: TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: theme.cardTheme.color,
                          prefixIcon: Icon(
                            FeatherIcons.lock,
                            color: theme.colorScheme.onBackground,
                          ),
                          suffixIconColor: Colors.grey,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            color: Colors.grey,
                            onPressed: _toggle,
                          ),
                          hintText: "Re-enter Password",
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.confirmPasswordTE,
                      validator: controller.validatePassword2,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SlideTransition(
                    position: controller.otpAnimation,
                    child: TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: theme.cardTheme.color,
                          prefixIcon: Icon(
                            Icons.lock_open,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "Enter OTP",
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.otpTE,
                      validator: controller.validateOtp,
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
              log('Mail:${widget.email}');
              controller.goToLoginScreen(
                  widget.email.toString(),
                  controller.newPasswordTE.text,
                  controller.confirmPasswordTE.text,
                  controller.otpTE.text);
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
    );
  }
}
