import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutx/flutx.dart';

import '../../theme/app_theme.dart';
import '../controller/search_controller.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with TickerProviderStateMixin {
  late ThemeData theme;

  late HotelSearchController controller;

  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();

    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(HotelSearchController(this));

    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 700),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 44,
                  width: MediaQuery.of(context).size.width - 109,
                  // padding:
                  //     const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.indigo),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    style: FxTextStyle.bodyMedium(),
                    decoration: InputDecoration(
                      hintText: 'Search Hotel',
                      icon: SvgPicture.asset('assets/icons/search.svg'),
                      border: InputBorder.none,
                      // contentPadding: FxSpacing.all(16),
                      hintStyle: FxTextStyle.bodyMedium(),
                    ),
                  ),

                  // child: SlideTransition(
                  //   position: controller.SearchAnimation,
                  //   child: TextFormField(
                  //     style: FxTextStyle.bodyMedium(),
                  //     decoration: InputDecoration(
                  //         floatingLabelBehavior: FloatingLabelBehavior.never,
                  //         filled: true,
                  //         isDense: true,
                  //         fillColor: theme.cardTheme.color,
                  //         prefixIcon: Icon(
                  //           FeatherIcons.mail,
                  //           color: theme.colorScheme.onBackground,
                  //         ),
                  //         hintText: "Email Address",
                  //         enabledBorder: outlineInputBorder,
                  //         focusedBorder: outlineInputBorder,
                  //         border: outlineInputBorder,
                  //         contentPadding: FxSpacing.all(16),
                  //         hintStyle: FxTextStyle.bodyMedium(),
                  //         isCollapsed: true),
                  //     maxLines: 1,
                  //     controller: controller.SearchTE,
                  //     validator: controller.validateEmail,
                  //     cursorColor: theme.colorScheme.onBackground,
                  //   ),
                  // ),
                ),
                const SizedBox(width: 17),
                Container(
                  height: 44,
                  width: 44,
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: SvgPicture.asset('assets/hotel/icons/option.svg'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
