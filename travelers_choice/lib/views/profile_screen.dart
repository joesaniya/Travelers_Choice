import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/views/all_bookings.dart';
import 'package:hotel_travel/views/bottomSheet/add_money.dart';
import 'package:hotel_travel/views/bottomSheet/withdraw_money.dart';
import 'package:hotel_travel/views/update_Password.dart';
import 'package:line_icons/line_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/profile_controller.dart';
import '../loading_effect.dart';
import '../services/app_constants.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ThemeData theme;
  late CustomTheme customTheme;

  late ProfileController profileController;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        profileController.name =
            sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN_Name);
        log(profileController.name.toString());
        profileController.email =
            sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN_Email);
        log(profileController.email.toString());
        log('username');
      });
    });
    profileController =
        FxControllerStore.putOrFind<ProfileController>(ProfileController());
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<ProfileController>(
        controller: profileController,
        builder: (profileController) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    if (profileController.uiLoading) {
      return Scaffold(
        body: Container(
            margin: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
            child: LoadingEffect.getProductLoadingScreen(
              context,
            )),
      );
    } else {
      return Theme(
        data: theme.copyWith(
            colorScheme: theme.colorScheme
                .copyWith(secondary: customTheme.cookifyPrimary.withAlpha(40))),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xfff5f5f5),
            body: ListView(
              padding: FxSpacing.fromLTRB(24, 36, 24, 24),
              children: [
                FxContainer(
                  color: Colors.white,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          image: AssetImage(profileController.user.url),
                          height: 100,
                          width: 100,
                        ),
                      ),
                      FxSpacing.width(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FxText.bodyLarge(
                                // profileController.user.name,
                                profileController.name.toString(),
                                fontWeight: 700),
                            FxSpacing.width(8),
                            FxText.bodyMedium(
                              // profileController.email.toString()
                              profileController.user.email,
                            ),
                            FxSpacing.height(8),
                            FxButton.outlined(
                                onPressed: () {},
                                splashColor:
                                    const Color(0xff1529e8).withAlpha(40),
                                borderColor: const Color(0xff1529e8),
                                padding: FxSpacing.xy(16, 4),
                                borderRadiusAll: 32,
                                child: FxText.bodySmall(
                                  "Edit profile",
                                  // color: customTheme.cookifyPrimary
                                  color: const Color(0xff1529e8),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                FxSpacing.height(24),
                FxContainer.bordered(
                  // margin: FxSpacing.fromLTRB(24, 24, 24, 0),
                  padding: FxSpacing.all(24),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          FxText.bodySmall("My balance".toUpperCase(),
                              fontSize: 12, fontWeight: 600, xMuted: true),
                          FxText.bodyLarge(
                              // "\$ 24",
                              '24 AED',
                              fontWeight: 800),
                        ],
                      ),
                      Column(
                        children: [
                          FxContainer(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                isScrollControlled: true,
                                builder: (context) {
                                  return const addMoney();
                                },
                              );
                              // showModalBottomSheet(
                              //     context: context,
                              //     builder: (BuildContext buildContext) {
                              //       return const addMoney();
                              //     });
                            },
                            padding: FxSpacing.fromLTRB(16, 8, 16, 8),
                            color: theme.colorScheme.primary.withAlpha(28),
                            borderRadiusAll: 4,
                            child: Row(
                              children: [
                                Icon(
                                  MdiIcons.plus,
                                  color: theme.colorScheme.primary,
                                  size: 20,
                                ),
                                Container(
                                    margin: FxSpacing.left(8),
                                    child: FxText.bodyMedium("Add Money",
                                        color: theme.colorScheme.primary,
                                        fontWeight: 600))
                              ],
                            ),
                          ),
                          FxSpacing.height(20),
                          FxContainer(
                            onTap: () {
                              // showModalBottomSheet(
                              //     context: context,
                              //     builder: (BuildContext buildContext) {
                              //       return const withdrawMoney();
                              //     });
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                isScrollControlled: true,
                                builder: (context) {
                                  return const withdrawMoney();
                                },
                              );
                            },
                            padding: FxSpacing.fromLTRB(21, 8, 21, 8),
                            color: theme.colorScheme.primary.withAlpha(28),
                            borderRadiusAll: 4,
                            child: Row(
                              children: [
                                Icon(
                                  LineIcons.download,
                                  color: theme.colorScheme.primary,
                                  size: 20,
                                ),
                                Container(
                                    margin: FxSpacing.left(8),
                                    child: FxText.bodyMedium("Withdraw",
                                        color: theme.colorScheme.primary,
                                        fontWeight: 600))
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                FxSpacing.height(24),
                FxContainer(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.titleMedium(
                          "Option",
                          fontWeight: 700,
                        ),
                        FxSpacing.height(8),
                        SwitchListTile(
                          dense: true,
                          contentPadding: FxSpacing.zero,
                          inactiveTrackColor:
                              const Color(0xff1529e8).withAlpha(100),
                          activeTrackColor:
                              const Color(0xff1529e8).withAlpha(150),
                          activeColor: const Color(0xff1529e8),
                          title: FxText.bodyMedium(
                            "Notifications",
                            letterSpacing: 0,
                          ),
                          onChanged: (value) {
                            setState(() {
                              profileController.notification = value;
                            });
                          },
                          value: profileController.notification,
                        ),
                        ListTile(
                          dense: true,
                          contentPadding: FxSpacing.zero,
                          visualDensity: VisualDensity.compact,
                          title: FxText.bodyMedium(
                            "Language",
                            letterSpacing: 0,
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        // SwitchListTile(
                        //   dense: true,
                        //   contentPadding: FxSpacing.zero,
                        //   inactiveTrackColor:
                        //       const Color(0xff1529e8).withAlpha(100),
                        //   activeTrackColor:
                        //       const Color(0xff1529e8).withAlpha(150),
                        //   activeColor: const Color(0xff1529e8),
                        //   title: FxText.bodyMedium(
                        //     "Offline Reading",
                        //     letterSpacing: 0,
                        //   ),
                        //   onChanged: (value) {
                        //     setState(() {
                        //       // offlineReading = value;
                        //       profileController.notification = value;
                        //     });
                        //   },
                        //   // value: offlineReading,
                        //   value: profileController.notification,
                        // ),
                        const Divider(
                          thickness: 0.8,
                        ),
                        FxSpacing.height(8),
                        FxText.titleMedium(
                          "Account",
                          fontWeight: 700,
                        ),
                        FxSpacing.height(8),
                        ListTile(
                          dense: true,
                          contentPadding: FxSpacing.zero,
                          visualDensity: VisualDensity.compact,
                          title: FxText.bodyMedium(
                            "Personal Information",
                            letterSpacing: 0,
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            log('update password clicked');
                            // Navigator.of(context, rootNavigator: true).push(
                            //   PageRouteBuilder(
                            //       transitionDuration:
                            //           const Duration(seconds: 1),
                            //       pageBuilder: (_, __, ___) =>
                            //           const UpdatePasswordScreen()),
                            // );
                            Navigator.of(context, rootNavigator: true).push(
                                PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                    transitionsBuilder: (
                                      BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation,
                                      Widget child,
                                    ) =>
                                        FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        ),
                                    pageBuilder: (_, __, ___) =>
                                        const UpdatePasswordScreen()));
                            // Navigator.of(context, rootNavigator: true)
                            //     .pushReplacement(
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         const UpdatePasswordScreen(),
                            //   ),
                            // );
                          },
                          dense: true,
                          contentPadding: FxSpacing.zero,
                          visualDensity: VisualDensity.compact,
                          title: FxText.bodyMedium(
                            "Update Password",
                            letterSpacing: 0,
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            log('all bookings clicked');

                            Navigator.of(context, rootNavigator: true).push(
                                PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                    transitionsBuilder: (
                                      BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation,
                                      Widget child,
                                    ) =>
                                        FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        ),
                                    pageBuilder: (_, __, ___) =>
                                        const AllBookings()));
                          },
                          dense: true,
                          contentPadding: FxSpacing.zero,
                          visualDensity: VisualDensity.compact,
                          title: FxText.bodyMedium(
                            "All Bookings",
                            letterSpacing: 0,
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        ListTile(
                          dense: true,
                          contentPadding: FxSpacing.zero,
                          visualDensity: VisualDensity.compact,
                          title: FxText.bodyMedium(
                            "Bookings Confirmed",
                            letterSpacing: 0,
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        ListTile(
                          dense: true,
                          contentPadding: FxSpacing.zero,
                          visualDensity: VisualDensity.compact,
                          title: FxText.bodyMedium(
                            "Bookings Cancelled",
                            letterSpacing: 0,
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        ListTile(
                          dense: true,
                          contentPadding: FxSpacing.zero,
                          visualDensity: VisualDensity.compact,
                          title: FxText.bodyMedium(
                            "Transaction History",
                            letterSpacing: 0,
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        FxSpacing.height(16),
                        Center(
                            child: FxButton.rounded(
                          onPressed: () {
                            // logout(context);
                            log('logout clicked');
                            profileController.logout(context);
                            // Navigator.of(context, rootNavigator: true).push(
                            //   MaterialPageRoute(
                            //       builder: (context) => CookifySplashScreen()),
                            // );
                          },
                          elevation: 2,
                          backgroundColor: const Color(0xff1529e8),
                          child: FxText.labelLarge(
                            "LOGOUT",
                            color: customTheme.cookifyOnPrimary,
                          ),
                        ))
                      ],
                    )),
                FxSpacing.height(24),
                // FxContainer(
                //     color: customTheme.cookifyPrimary.withAlpha(40),
                //     padding: FxSpacing.xy(16, 20),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         FxTwoToneIcon(
                //           FxTwoToneMdiIcons.headset_mic,
                //           size: 32,
                //           color: customTheme.cookifyPrimary,
                //         ),
                //         FxSpacing.width(12),
                //         FxText.bodySmall(
                //           "Feel Free to Ask, We Ready to Help",
                //           color: customTheme.cookifyPrimary,
                //           letterSpacing: 0,
                //         )
                //       ],
                //     ))
              ],
            ),
          ),
        ),
      );
    }
  }
}
