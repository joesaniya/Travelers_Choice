import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import '../../controllers/search_Home_controller.dart';
import '../../theme/app_theme.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({Key? key}) : super(key: key);

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet>
    with TickerProviderStateMixin {
  late HomeSearchController controller;
  late ThemeData theme, theme1;
  int _radioValue = 0;
  int _ratingValue = 0;
  final List<bool?> _star = [false, true, true, true, true];
  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(HomeSearchController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<HomeSearchController>(
        controller: controller,
        builder: (controller) {
          return Container(
            height: MediaQuery.of(context).size.height * 85 / 100,
            padding: FxSpacing.xy(24, 16),
            decoration: const BoxDecoration(
                // color: customTheme.card,
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            child: ListView(
              // mainAxisSize: MainAxisSize.min,
              children: [
                FxSpacing.height(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.bodyLarge(
                      'Categories',
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
                FxSpacing.height(20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: FxText.bodyLarge(
                      'When are you Travelling?',
                      letterSpacing: 0,
                      fontWeight: 600,
                    ),
                  ),
                ),
                FxSpacing.height(10),
                SlideTransition(
                  position: controller.dateAnimation,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      controller: controller.dateTE,
                      readOnly:
                          true, //set it true, so that user will not able to edit text

                      onTap: controller.dateselect,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: theme.cardTheme.color,
                          suffixIcon: Icon(
                            FeatherIcons.calendar,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "yyyy-mm-dd",
                          // border: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          // focusedBorder: InputBorder.none,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff1529e8),
                                  // color: Colors.lightBlueAccent,
                                  width: 1)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff1529e8), width: 1)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff1529e8), width: 1)),
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      autofocus: false,
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ),

                //duration
                FxSpacing.height(20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: FxText.bodyLarge(
                      'Duration',
                      letterSpacing: 0,
                      fontWeight: 600,
                    ),
                  ),
                ),
                FxSpacing.height(10),
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          _radioValue = 0;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Radio(
                            onChanged: (dynamic value) {
                              setState(() {
                                _radioValue = 0;
                              });
                            },
                            groupValue: _radioValue,
                            value: 0,
                            visualDensity: VisualDensity.compact,
                            activeColor: const Color(0xff1529e8),
                            // activeColor: theme.colorScheme.primary,
                          ),
                          FxText.titleSmall("Upto 1 Hour", fontWeight: 60),
                          // FxText.titleSmall("High to Low"),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _radioValue = 1;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Radio(
                            onChanged: (dynamic value) {
                              setState(() {
                                _radioValue = 1;
                              });
                            },
                            groupValue: _radioValue,
                            value: 1,
                            visualDensity: VisualDensity.compact,
                            activeColor: const Color(0xff1529e8),
                            // activeColor: theme.colorScheme.primary,
                          ),
                          FxText.titleSmall("1 to 4 Hour", fontWeight: 600),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _radioValue = 2;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Radio(
                            onChanged: (dynamic value) {
                              setState(() {
                                _radioValue = 2;
                              });
                            },
                            groupValue: _radioValue,
                            value: 2,
                            visualDensity: VisualDensity.compact,
                            activeColor: const Color(0xff1529e8),
                            // activeColor: theme.colorScheme.primary,
                          ),
                          FxText.titleSmall("4 Hour to 1 Day", fontWeight: 600),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _radioValue = 3;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Radio(
                            onChanged: (dynamic value) {
                              setState(() {
                                _radioValue = 3;
                              });
                            },
                            groupValue: _radioValue,
                            value: 3,
                            visualDensity: VisualDensity.compact,
                            activeColor: const Color(0xff1529e8),
                            // activeColor: theme.colorScheme.primary,
                          ),
                          FxText.titleSmall("1 to 3 Day", fontWeight: 600),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _radioValue = 4;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Radio(
                            onChanged: (dynamic value) {
                              setState(() {
                                _radioValue = 4;
                              });
                            },
                            groupValue: _radioValue,
                            value: 4,
                            visualDensity: VisualDensity.compact,
                            activeColor: const Color(0xff1529e8),
                            // activeColor: theme.colorScheme.primary,
                          ),
                          FxText.titleSmall("3 Day's or more", fontWeight: 600),
                        ],
                      ),
                    ),
                  ],
                ),

                //rating
                FxSpacing.height(20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: FxText.bodyLarge(
                      'Rating',
                      letterSpacing: 0,
                      fontWeight: 600,
                    ),
                  ),
                ),
                FxSpacing.height(10),
                Container(
                    height: 200,
                    color: Colors.transparent,
                    // padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                    // child: const RatingSearchDrawer()
                    child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _ratingValue = 0;
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                      onChanged: (dynamic value) {
                                        setState(() {
                                          _ratingValue = 0;
                                        });
                                      },
                                      groupValue: _ratingValue,
                                      value: 0,
                                      visualDensity: VisualDensity.compact,
                                      activeColor: const Color(0xff1529e8),
                                      // activeColor: theme.colorScheme.primary,
                                    ),
                                    FxStarRating(
                                      rating: (index + 1).toDouble(),
                                    )
                                    // FxText.titleSmall("High to Low"),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _ratingValue = 1;
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                      onChanged: (dynamic value) {
                                        setState(() {
                                          _ratingValue = 1;
                                        });
                                      },
                                      groupValue: _ratingValue,
                                      value: 1,
                                      visualDensity: VisualDensity.compact,
                                      activeColor: const Color(0xff1529e8),
                                      // activeColor: theme.colorScheme.primary,
                                    ),
                                    FxStarRating(
                                      rating: (index + 2).toDouble(),
                                    )
                                    // FxText.titleSmall("High to Low"),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _ratingValue = 2;
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                      onChanged: (dynamic value) {
                                        setState(() {
                                          _ratingValue = 2;
                                        });
                                      },
                                      groupValue: _ratingValue,
                                      value: 2,
                                      visualDensity: VisualDensity.compact,
                                      activeColor: const Color(0xff1529e8),
                                      // activeColor: theme.colorScheme.primary,
                                    ),
                                    FxStarRating(
                                      rating: (index + 3).toDouble(),
                                    )
                                    // FxText.titleSmall("High to Low"),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _ratingValue = 3;
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                      onChanged: (dynamic value) {
                                        setState(() {
                                          _ratingValue = 3;
                                        });
                                      },
                                      groupValue: _ratingValue,
                                      value: 3,
                                      visualDensity: VisualDensity.compact,
                                      activeColor: const Color(0xff1529e8),
                                      // activeColor: theme.colorScheme.primary,
                                    ),
                                    FxStarRating(
                                      rating: (index + 4).toDouble(),
                                    )
                                    // FxText.titleSmall("High to Low"),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _ratingValue = 4;
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                      onChanged: (dynamic value) {
                                        setState(() {
                                          _ratingValue = 4;
                                        });
                                      },
                                      groupValue: _ratingValue,
                                      value: 4,
                                      visualDensity: VisualDensity.compact,
                                      activeColor: const Color(0xff1529e8),
                                      // activeColor: theme.colorScheme.primary,
                                    ),
                                    FxStarRating(
                                      rating: (index + 5).toDouble(),
                                    )
                                    // FxText.titleSmall("High to Low"),
                                  ],
                                ),
                              ),
                            ],
                          );
                        })
                    // child: ListView.builder(
                    //     shrinkWrap: true,
                    //     padding: EdgeInsets.zero,
                    //     itemCount: _star.length,
                    //     reverse: true,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return InkWell(
                    //         onTap: () {
                    //           setState(() {
                    //             _star[index] = _star[index];
                    //           });
                    //         },
                    //         child: Row(
                    //           children: <Widget>[
                    //             Checkbox(
                    //               visualDensity: VisualDensity.compact,
                    //               materialTapTargetSize:
                    //                   MaterialTapTargetSize.shrinkWrap,
                    //               value: _star[index],
                    //               activeColor: theme.colorScheme.primary,
                    //               onChanged: (bool? value) {
                    //                 setState(() {
                    //                   _star[index] = value;
                    //                 });
                    //               },
                    //             ),
                    //             // Radio(
                    //             //   onChanged: (dynamic value) {
                    //             //     setState(() {
                    //             //       _star[index] = value;
                    //             //     });
                    //             //   },
                    //             //   groupValue: _ratingValue,
                    //             //   value: 0,
                    //             //   visualDensity: VisualDensity.compact,
                    //             //   activeColor: theme.colorScheme.primary,
                    //             // ),
                    //             Container(
                    //                 // margin: const EdgeInsets.only(left: 4),
                    //                 child: FxStarRating(
                    //                     rating: (index + 1).toDouble(),
                    //                     inactiveColor:
                    //                         theme.colorScheme.onBackground))
                    //           ],
                    //         ),
                    //       );
                    //     }),
                    ),

                //btn
                Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: FxContainer(
                        onTap: () {
                          // controller.closeEndDrawer();
                          Navigator.pop(context);
                        },
                        color: Colors.transparent,
                        padding: FxSpacing.y(12),
                        child: Center(
                          child: FxText(
                            "Clear",
                            color: const Color(0xff1529e8),
                            // color: theme.colorScheme.primary,
                            fontWeight: 600,
                          ),
                        ),
                      )),
                      Expanded(
                          child: FxContainer.none(
                        onTap: () {
                          // controller.closeEndDrawer();
                          Navigator.pop(context);
                        },
                        padding: FxSpacing.y(12),
                        // color: theme.colorScheme.primary,
                        color: const Color(0xff1529e8),
                        child: Center(
                          child: FxText(
                            "Apply",
                            color: theme.colorScheme.onPrimary,
                            fontWeight: 600,
                          ),
                        ),
                      )),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
