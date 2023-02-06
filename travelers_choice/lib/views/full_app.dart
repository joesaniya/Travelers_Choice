import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/views/Home_Screen.dart';
import 'package:hotel_travel/views/Saved_Screen.dart';
import 'package:hotel_travel/views/profile_screen.dart';

import '../controllers/full_app_conrtoller.dart';
import '../theme/app_theme.dart';

class FullApp extends StatefulWidget {
  const FullApp({Key? key}) : super(key: key);

  @override
  _FullAppState createState() => _FullAppState();
}

class _FullAppState extends State<FullApp> with SingleTickerProviderStateMixin {
  late ThemeData theme;

  late FullAppController controller;

  @override
  void initState() {
    super.initState();

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
          return Scaffold(
            backgroundColor: const Color(0xfff5f5f5),
            // body: Column(
            //   children: [
            //     Expanded(
            //       child: TabBarView(
            //         controller: controller.tabController,
            //         children: <Widget>[
            //           HomeScreen(),
            //           // HomeScreen(size: size),
            //           Text('home'),
            //           Text('home'),
            //           Text('home'),
            //         ],
            //       ),
            //     ),
            //     FxContainer(
            //       bordered: true,
            //       enableBorderRadius: false,
            //       border: Border(
            //           top: BorderSide(
            //               color: theme.dividerColor,
            //               width: 1,
            //               style: BorderStyle.solid)),
            //       padding: FxSpacing.xy(12, 16),
            //       color: theme.scaffoldBackgroundColor,
            //       child: TabBar(
            //         controller: controller.tabController,
            //         indicator: FxTabIndicator(
            //             indicatorColor: theme.colorScheme.primary,
            //             indicatorHeight: 3,
            //             radius: 3,
            //             indicatorStyle: FxTabIndicatorStyle.rectangle,
            //             yOffset: -18),
            //         indicatorSize: TabBarIndicatorSize.tab,
            //         indicatorColor: theme.colorScheme.primary,
            //         tabs: buildTab(),
            //       ),
            //     )
            //   ],
            // ),
            body: Stack(
              children: [
                TabBarView(
                  controller: controller.tabController,
                  children: <Widget>[
                    HomeScreen(),
                    // HomeScreen(size: size),

                    const Center(child: Text('Saved')),
                    const SavedScreen(),
                    const ProfileScreen()
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: FxSpacing.xy(12, 8),
                    child: PhysicalModel(
                      color: theme.cardTheme.color!.withAlpha(200),
                      elevation: 12,
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                      shadowColor: theme.colorScheme.onBackground.withAlpha(12),
                      shape: BoxShape.rectangle,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.cardTheme.color!.withAlpha(200),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(32)),
                        ),
                        padding: FxSpacing.xy(16, 12),
                        child: Row(
                          children: <Widget>[
                            singleItem(
                                index: 0,
                                iconData: FeatherIcons.search,
                                activeIconData: FeatherIcons.search,
                                title: "search"),
                            singleItem(
                                index: 1,
                                iconData: FeatherIcons.heart,
                                activeIconData: FeatherIcons.heart,
                                title: "Saved"),
                            singleItem(
                                index: 2,
                                // activeIconData: Icons.luggage,
                                // iconData: Icons.luggage,
                                activeIconData: FeatherIcons.shoppingCart,
                                iconData: FeatherIcons.shoppingCart,
                                title: "Cart"),
                            singleItem(
                                index: 3,
                                iconData: FeatherIcons.user,
                                activeIconData: FeatherIcons.user,
                                title: "Profile"),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget singleItem(
      {required int index,
      required IconData iconData,
      required IconData activeIconData,
      required String title}) {
    double width = MediaQuery.of(context).size.width - 64;
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
