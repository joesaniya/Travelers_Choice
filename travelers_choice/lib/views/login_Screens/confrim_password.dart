import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import '../../controllers/confirm_password_controller.dart';
import '/theme/app_theme.dart';

import '../../controllers/forgot_password_conntroller.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  String? email;
   ConfirmPasswordScreen( this.email, {Key? key}) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    controller = FxControllerStore.put(ConfirmPasswordController(this));
    outlineInputBorder = OutlineInputBorder(
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
          return _buildBody();
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
                  SizedBox(height: 20,),
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
                  SizedBox(height: 20,),
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
                controller.goToLoginScreen();
              },
              splashColor: theme.colorScheme.onPrimary.withAlpha(30),
              // backgroundColor: theme.colorScheme.primary,
              backgroundColor: Color(0xff1529e8),
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
                  "I haven\'t an account",
                  decoration: TextDecoration.underline,
                  // color: theme.colorScheme.primary
                  color: Color(0xff1529e8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
