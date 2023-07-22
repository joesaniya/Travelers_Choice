import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/models/all_attraction_modal.dart';
import 'package:hotel_travel/views/Home_Screen.dart';
import 'package:hotel_travel/views/Cart_Screen.dart';
import 'package:hotel_travel/views/history_page.dart';
import 'package:hotel_travel/views/profile_screen.dart';

import '../controllers/full_app_conrtoller.dart';
import '../models/Slot_Time.dart';
import '../models/atteraction_model.dart';
import '../theme/app_theme.dart';
import 'Saved_Screen.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

List<Datum> favouriteList = <Datum>[];

List<Activity> favouriteListCart = <Activity>[];

class FullApp extends StatefulWidget {
  List<AllattractionModal> favouriteMeal;
  List<Activity> cartMeal;
  SlotTime? event;
  FullApp(this.favouriteMeal, this.cartMeal, this.event, {super.key});

  @override
  _FullAppState createState() => _FullAppState();
}

class _FullAppState extends State<FullApp> with SingleTickerProviderStateMixin {
  late ThemeData theme;

  late FullAppController controller;

  //todo
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

  @override
  void initState() {
    super.initState();
    // getConnectivity();
    theme = AppTheme.shoppingTheme;
    controller = FxControllerStore.putOrFind(FullAppController(this));
  }

  List<Widget> buildTab() {
    List<Widget> tabs = [];

    for (int i = 0; i < controller.navItems.length; i++) {
      tabs.add(Container(
        child: Icon(
          controller.navItems[i].iconData,
          size: 20,
          color: (controller.currentIndex == i)
              ? theme.colorScheme.primary
              : theme.colorScheme.onBackground,
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<FullAppController>(
        controller: controller,
        builder: (controller) {
          return _buildItem();

          // return Scaffold(
          //   backgroundColor: const Color(0xfff5f5f5),
          //   // body: Column(
          //   //   children: [
          //   //     Expanded(
          //   //       child: TabBarView(
          //   //         controller: controller.tabController,
          //   //         children: <Widget>[
          //   //           HomeScreen(),
          //   //           // HomeScreen(size: size),
          //   //           Text('home'),
          //   //           Text('home'),
          //   //           Text('home'),
          //   //         ],
          //   //       ),
          //   //     ),
          //   //     FxContainer(
          //   //       bordered: true,
          //   //       enableBorderRadius: false,
          //   //       border: Border(
          //   //           top: BorderSide(
          //   //               color: theme.dividerColor,
          //   //               width: 1,
          //   //               style: BorderStyle.solid)),
          //   //       padding: FxSpacing.xy(12, 16),
          //   //       color: theme.scaffoldBackgroundColor,
          //   //       child: TabBar(
          //   //         controller: controller.tabController,
          //   //         indicator: FxTabIndicator(
          //   //             indicatorColor: theme.colorScheme.primary,
          //   //             indicatorHeight: 3,
          //   //             radius: 3,
          //   //             indicatorStyle: FxTabIndicatorStyle.rectangle,
          //   //             yOffset: -18),
          //   //         indicatorSize: TabBarIndicatorSize.tab,
          //   //         indicatorColor: theme.colorScheme.primary,
          //   //         tabs: buildTab(),
          //   //       ),
          //   //     )
          //   //   ],
          //   // ),

          //   //crt
          //   body: Stack(
          //     children: [
          //       TabBarView(
          //         controller: controller.tabController,
          //         children: <Widget>[
          //           HomeScreen(widget.cartMeal),
          //           // HomeScreen(size: size),

          //           // const Center(child: Text('Saved')),
          //           SavedScreen(widget.favouriteMeal),
          //           NewCart(widget.cartMeal,
          //           // widget.event
          //           ),
          //           const HistoryScreen(),
          //           // CartScreen(),
          //           const ProfileScreen()
          //         ],
          //       ),
          //       Positioned(
          //         bottom: 0,
          //         left: 0,
          //         right: 0,
          //         child: Container(
          //           padding: FxSpacing.xy(12, 8),
          //           child: PhysicalModel(
          //             color: theme.cardTheme.color!.withAlpha(200),
          //             elevation: 12,
          //             borderRadius: const BorderRadius.all(Radius.circular(32)),
          //             shadowColor: theme.colorScheme.onBackground.withAlpha(12),
          //             shape: BoxShape.rectangle,
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 color: theme.cardTheme.color!.withAlpha(200),
          //                 borderRadius:
          //                     const BorderRadius.all(Radius.circular(32)),
          //               ),
          //               padding: FxSpacing.xy(16, 12),
          //               child: Row(
          //                 children: <Widget>[
          //                   singleItem(
          //                       index: 0,
          //                       iconData: FeatherIcons.search,
          //                       activeIconData: FeatherIcons.search,
          //                       title: "search"),
          //                   singleItem(
          //                       index: 1,
          //                       iconData: FeatherIcons.heart,
          //                       activeIconData: FeatherIcons.heart,
          //                       title: "Saved"),
          //                   singleItem(
          //                       index: 2,
          //                       activeIconData: FeatherIcons.shoppingBag,
          //                       iconData: FeatherIcons.shoppingBag,
          //                       title: "Cart"),
          //                   singleItem(
          //                       index: 3,
          //                       // activeIconData: Icons.luggage,
          //                       // iconData: Icons.luggage,
          //                       activeIconData: FeatherIcons.clock,
          //                       iconData: FeatherIcons.clock,
          //                       title: "History"),
          //                   singleItem(
          //                       index: 4,
          //                       iconData: FeatherIcons.user,
          //                       activeIconData: FeatherIcons.user,
          //                       title: "Profile"),
          //                   Expanded(child: Container())
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // );
        });
  }

  int _selectedIndex = 0;

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildItem() {
    double width = MediaQuery.of(context).size.width - 122;
    double selectedWidth = width * (1.5 / 4.5);
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xfff5f5f5),
      body: Stack(
        children: [
          [
            HomeScreen(widget.cartMeal),
            SavedScreen(widget.favouriteMeal),
            NewCart(widget.cartMeal
                // ,widget.event
                ),
            const HistoryScreen(),
            const ProfileScreen()
          ][_selectedIndex],
        ],
      ),
      bottomNavigationBar: Container(
        padding: FxSpacing.xy(12, 8),
        child: PhysicalModel(
          color: theme.cardTheme.color!.withAlpha(200),
          elevation: 12,
          borderRadius: const BorderRadius.all(Radius.circular(32)),
          shadowColor: theme.colorScheme.onBackground.withAlpha(12),
          shape: BoxShape.rectangle,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(32)),
            child: BottomNavigationBar(
              backgroundColor: theme.cardTheme.color!.withAlpha(200),
              //use both properties
              // backgroundColor: Colors.red,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              //-----------
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              showSelectedLabels: false,

              elevation: 0,
              selectedLabelStyle: TextStyle(

                  // color: theme.colorScheme.onPrimary,
                  //  color: Color(0xff1529e8),
                  color: theme.colorScheme.onPrimary,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w600),
              items: [
                (_selectedIndex == 0)
                    ? BottomNavigationBarItem(
                        icon: Container(
                          width: selectedWidth,
                          padding: FxSpacing.xy(0, 8),
                          decoration: const BoxDecoration(
                              // color: theme.colorScheme.primary,
                              color: Color(0xff1529e8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FeatherIcons.search,
                                size: 20,
                                // color: Color(0xff1529e8),
                                color: theme.colorScheme.onPrimary,
                              ),
                              FxSpacing.width(3),
                              FxText.bodyMedium('Search',
                                  color: theme.colorScheme.onPrimary,
                                  letterSpacing: 0.3,
                                  // color: const Color(0xff1529e8),
                                  fontWeight: 600),
                            ],
                          ),
                        ),
                        label: '',
                      )
                    : BottomNavigationBarItem(
                        icon: Icon(
                          FeatherIcons.search,
                          size: 20,
                          color: theme.colorScheme.onBackground,
                        ),
                        label: ''),
                (_selectedIndex == 1)
                    ? BottomNavigationBarItem(
                        icon: Container(
                          width: selectedWidth,
                          padding: FxSpacing.xy(0, 8),
                          decoration: const BoxDecoration(
                              // color: theme.colorScheme.primary,
                              color: Color(0xff1529e8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FeatherIcons.heart,
                                size: 20,
                                // color: Color(0xff1529e8),
                                color: theme.colorScheme.onPrimary,
                              ),
                              FxSpacing.width(3),
                              FxText.bodyMedium('Saved',
                                  color: theme.colorScheme.onPrimary,
                                  letterSpacing: 0.3,
                                  // color: const Color(0xff1529e8),
                                  fontWeight: 600),
                            ],
                          ),
                        ),
                        label: '')
                    : BottomNavigationBarItem(
                        icon: Icon(
                          FeatherIcons.heart,
                          size: 20,
                          color: theme.colorScheme.onBackground,
                        ),
                        label: ''),
                (_selectedIndex == 2)
                    ? BottomNavigationBarItem(
                        icon: Container(
                          width: selectedWidth,
                          padding: FxSpacing.xy(5, 8),
                          decoration: const BoxDecoration(
                              // color: theme.colorScheme.primary,
                              color: Color(0xff1529e8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FeatherIcons.shoppingBag,
                                size: 20,
                                // color: Color(0xff1529e8),
                                color: theme.colorScheme.onPrimary,
                              ),
                              FxSpacing.width(3),
                              FxText.bodyMedium('Cart',
                                  color: theme.colorScheme.onPrimary,
                                  letterSpacing: 0.3,
                                  // color: const Color(0xff1529e8),
                                  fontWeight: 600),
                            ],
                          ),
                        ),
                        label: '')
                    : BottomNavigationBarItem(
                        icon: Icon(
                          FeatherIcons.shoppingBag,
                          size: 20,
                          color: theme.colorScheme.onBackground,
                        ),
                        label: ''),
                (_selectedIndex == 3)
                    ? BottomNavigationBarItem(
                        icon: Container(
                          width: selectedWidth,
                          padding: FxSpacing.xy(0, 8),
                          decoration: const BoxDecoration(
                              // color: theme.colorScheme.primary,
                              color: Color(0xff1529e8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FeatherIcons.clock,
                                size: 20,
                                // color: Color(0xff1529e8),
                                color: theme.colorScheme.onPrimary,
                              ),
                              FxSpacing.width(3),
                              FxText.bodyMedium('History',
                                  color: theme.colorScheme.onPrimary,
                                  letterSpacing: 0.3,
                                  // color: const Color(0xff1529e8),
                                  fontWeight: 600),
                            ],
                          ),
                        ),
                        label: '')
                    : BottomNavigationBarItem(
                        icon: Icon(
                          FeatherIcons.clock,
                          size: 20,
                          color: theme.colorScheme.onBackground,
                        ),
                        label: ''),
                (_selectedIndex == 4)
                    ? BottomNavigationBarItem(
                        icon: Container(
                          width: selectedWidth,
                          padding: FxSpacing.xy(0, 8),
                          decoration: const BoxDecoration(
                              // color: theme.colorScheme.primary,
                              color: Color(0xff1529e8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FeatherIcons.user,
                                size: 20,
                                // color: Color(0xff1529e8),
                                color: theme.colorScheme.onPrimary,
                              ),
                              FxSpacing.width(3),
                              FxText.bodyMedium('Profile',
                                  color: theme.colorScheme.onPrimary,
                                  letterSpacing: 0.3,
                                  // color: const Color(0xff1529e8),
                                  fontWeight: 600),
                            ],
                          ),
                        ),
                        label: '')
                    : BottomNavigationBarItem(
                        icon: Icon(
                          FeatherIcons.user,
                          size: 20,
                          color: theme.colorScheme.onBackground,
                        ),
                        label: ''),
              ],
            ),
          ),
        ),
      ),

      // bottomNavigationBar: CustomBottomNavigationBar(
      //     onItemTapped: _onItemTapped, selectedIndex: _selectedIndex),
    );
  }

  Widget singleItem(
      {required int index,
      required IconData iconData,
      required IconData activeIconData,
      required String title}) {
    // double width = MediaQuery.of(context).size.width / 5;
    // double width = MediaQuery.of(context).size.width - 64;
    // double width = MediaQuery.of(context).size.width;
    // double width = MediaQuery.of(context).size.width - 120;
    double width = MediaQuery.of(context).size.width - 122;
    double selectedWidth = width * (1.5 / 4.5);
    double unSelectedWidth = width * (1 / 4.5);

    bool selected = index == controller.currentIndex;

    if (selected) {
      return Container(
        width: selectedWidth,
        padding: FxSpacing.y(8),
        decoration: const BoxDecoration(
            // color: theme.colorScheme.primary,
            color: Color(0xff1529e8),
            borderRadius: BorderRadius.all(Radius.circular(24))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              activeIconData,
              size: 20,
              color: theme.colorScheme.onPrimary,
            ),
            FxSpacing.width(8),
            FxText.bodyMedium(title,
                color: theme.colorScheme.onPrimary,
                letterSpacing: 0.3,
                fontWeight: 600),
          ],
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          controller.onTapped(index);
        },
        child: SizedBox(
          width: unSelectedWidth,
          child: Center(
              child: Icon(
            iconData,
            size: 20,
            color: theme.colorScheme.onBackground,
          )),
        ),
      );
    }
  }
}
