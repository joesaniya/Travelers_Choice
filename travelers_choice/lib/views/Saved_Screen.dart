import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import 'package:hotel_travel/extensions/extensions.dart';
import 'package:hotel_travel/models/all_attraction_modal.dart';

import '../controllers/saved_controller.dart';
import '../loading_effect.dart';
import '../models/cart.dart';
import '../theme/app_theme.dart';

class SavedScreen extends StatefulWidget {
  final List<AllattractionModal> favouriteMeals;
  const SavedScreen(this.favouriteMeals);

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late SavedController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(SavedController(this));
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<SavedController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
      return Scaffold(
        body: Container(
            padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
            child: LoadingEffect.getCartLoadingScreen(
              context,
            )),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            title: FxText.titleMedium(
              'Saved',
              fontWeight: 700,
            ),
            centerTitle: true,
          ),
          body: widget.favouriteMeals.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                          image: NetworkImage(
                              'https://c.tenor.com/hJDuRStH_cYAAAAC/cat-sleeping.gif'),
                        )),
                      ),
                      const Text(
                          'You have no favourite yet - start adding some item!',
                          style: TextStyle(
                              fontFamily: 'inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 16))
                    ],
                  ),
                )
              : Container(
                  child: SingleChildScrollView(
                      child: Column(
                    children: const [Text('data')],
                  )),
                ));
    }
  }
}
