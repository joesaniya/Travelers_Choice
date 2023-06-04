import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/views/bottomSheet/Filter_Sheet.dart';
import 'package:hotel_travel/views/bottomSheet/categories_Sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/attraction_Controller.dart';
import '../controllers/search_Home_controller.dart';
import '../loading_effect.dart';
import '../models/all_attraction_modal.dart';
import '../services/app_constants.dart';
import '../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  // final Destination place;
  // List<Datum> searchdata;
  // final BuildContext rootContext;
  String? place;
  String? currencySymbol;
  double? conversionRate;
  SearchScreen(
      {super.key, required this.place, this.currencySymbol, this.conversionRate
      // required this.searchdata
      });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late ThemeData theme, theme1;

  late HomeSearchController controller;
  bool isLoading = true;
  int len = 0;

  List<AllattractionModal> _filteredBooks = [];
  List<AllattractionModal>? foundCustomer = [];
  List<AllattractionModal> temp = [];
  List<AllattractionModal> temp2 = [];
  void _runFilter(String enteredKeyword) {
    print('runFilters');
    List results = [];
    if (enteredKeyword.isEmpty) {
      print('runFilters if');
      results = controller.SearchTE as List;
    } else {
      print('runFilters else');
      results = controller.allattractionList!
          .where((Attract) => Attract.attractions.data.first.title
              .toString()
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      print(results);
      log('results$results');
    }

    setState(() {
      print('set state');
      // foundCustomer = results.cast<Customer>();
      foundCustomer = results.cast<AllattractionModal>();
      // foundrecipe = searchResult;
    });
  }

  getAttraction(
      // Destination place
      String? place) {
    log('getAttraction function called');
    Future.delayed(Duration.zero, () async {
      // log('get${place.name}');
      await AttractionController().getSearchattractionList(place).then((value) {
        if (value != null) {
          isLoading = false;
          controller.allattractionList = [];
          controller.allattractionList!.add(value);
          _filteredBooks = controller.allattractionList!;
        }

        for (AllattractionModal val in controller.allattractionList!) {
          for (Datum des in val.attractions.data) {
            if (des.destination.name.toLowerCase().trim() ==
                place!.toLowerCase().trim()) {
              temp.add(val);
              // log('dest:${temp.length}');
              // log('destination:${des.destination.name}');
              // log('Search:${place.name}');
            }
          }
        }
        // print("Temp List => ${temp.length}");
        setState(() => controller.allattractionList = temp);
      });
    });
  }

  void _searchBooks(String query) {
    setState(() {
      _filteredBooks = controller.allattractionList!.where((place) {
        log('query ${query.toLowerCase()}} actualValue => ${place.attractions.data.first.title.toLowerCase()}');
        return place.attractions.data.first.title
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();

      setState(() {
        // controller.allattractionList = [];
        controller.allattractionList = _filteredBooks;
      });

      print('Search:$_filteredBooks');
      log('Search:$_filteredBooks');
    });
  }

  onSearchTextChanged(String text) async {
    _filteredBooks.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    // for (var userDetail in controller.allattractionList!) {
    //   if (userDetail.attractions.data.first.title.contains(text)) {
    //     // controller.allattractionList!.add(userDetail);
    //     _filteredBooks.add(userDetail);
    //   }
    // }

    // controller.allattractionList!.addAll(_filteredBooks);
    for (var userDetail in controller.allattractionList!) {
      if (userDetail.attractions.data.first.title.contains(text)) {
        _filteredBooks.add(userDetail);
      }
    }

    // log('filter:$_filteredBooks');

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    log('Currency SymbolSearch:${widget.currencySymbol}');
    log('RateSearch:${widget.conversionRate}');
    controller = FxControllerStore.put(HomeSearchController(this));
    // log('${widget.place.name}Place Search1');
    temp = [];
    getAttraction(widget.place);
    // log('${widget.place}Place Search2');

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    initializingData();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   // addCategories();
    // });
  }

  String? currencySymbol;
  double? conversionRate;
  void initializingData() {
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        conversionRate = sharedPrefValue.getDouble(AppConstants.rate);
        log('conversionRate:$conversionRate');
        currencySymbol = sharedPrefValue.getString(AppConstants.symbol);
        log('currencySymbol:$currencySymbol');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<HomeSearchController>(
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
    // if (controller.uiLoading)

    if (controller.allattractionList == null) {
      return Scaffold(
          body: Padding(
        padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
        child: LoadingEffect.getHomeLoadingScreen(
          context,
          // theme, theme.colorScheme
        ),
      ));
    } else {
      // if (controller.allattractionList!.isEmpty)
      if (controller.allattractionList!.isEmpty ||
          controller.allattractionList!.first.attractions.data.isEmpty) {
        return Scaffold(
            //     body: Column(
            //   children: [
            //     Lottie.asset('assets/lottie/search_lottie.json',
            //         height: 300, width: 300),
            //     FxText.bodyLarge(
            //       "No Data found",
            //       fontWeight: 900,
            //     ),
            //   ],
            // )
            backgroundColor: const Color(0xfff5f5f5),
            body: ListView(
              padding: FxSpacing.fromLTRB(
                  20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
              children: [
                Container(
                  // padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        // color: Colors.grey.shade400,
                        color: const Color(0xff1529e8).withOpacity(0.4),
                        blurRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    style: FxTextStyle.bodyMedium(),
                    controller: controller.SearchTE,
                    cursorColor: theme.colorScheme.primary,

                    //2
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        await AttractionController()
                            .getSearchattractionList(widget.place)
                            .then((value) {
                          if (value != null) {
                            isLoading = false;
                            controller.allattractionList = [];
                            controller.allattractionList!.add(value);
                            _filteredBooks = controller.allattractionList!;
                          }
                        });

                        setState(() {
                          // len = value.length;
                          // _filteredBooks = [
                          //   allattractionModalFromJson(json.encode(value))
                          // ];
                          controller.allattractionList!.first.attractions.data;
                          // _filteredBooks =
                          //     AllattractionModal as List<AllattractionModal>;
                        });
                        // log('Value:$_filteredBooks');

                        return;
                      }

                      len = 1;
                      // print(' => ${_filteredBooks.first.attractions.toJson()}');

                      List<Datum> data = _filteredBooks.first.attractions.data
                          .where((Datum i) {
                        // log('title:${i.title}');
                        // log('value:$value');
                        return i.title
                            .toLowerCase()
                            .contains(value.toString().toLowerCase());
                      }).toList();

                      temp[0].attractions.data = data;

                      setState(() {
                        controller.allattractionList = temp;
                        len;
                      });
                    },

                    decoration: InputDecoration(
                      hintText: "Search your place ...",
                      hintStyle: FxTextStyle.bodySmall(
                          color: theme.colorScheme.onBackground),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      filled: true,
                      // fillColor: const Color(0xffcfd2ff),
                      fillColor: theme.cardTheme.color,
                      prefixIcon: Icon(
                        FeatherIcons.search,
                        size: 16,
                        color: theme.colorScheme.onBackground.withAlpha(150),
                      ),
                      isDense: true,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),

                FxSpacing.height(20),
                //btn
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        var data = await showModalBottomSheet(
                            context: context,
                            builder: (BuildContext buildContext) {
                              return CategoriesBottomSheet(
                                categoryplace: widget.place,
                              );
                            });
                        if (data != null) {
                          setState(() {
                            controller.allattractionList = [];

                            controller.allattractionList = [data];
                          });
                        }
                        // showModalBottomSheet(
                        //   context: context,
                        //   backgroundColor: Colors.white,
                        //   shape: const RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.only(
                        //           topLeft: Radiaus.circular(20),
                        //           topRight: Radius.circular(20))),
                        //   isScrollControlled: true,
                        //   builder: (context) {
                        //     return const CategoriesBottomSheet();
                        //   },
                        // );
                      },
                      child: FxContainer(
                        borderRadiusAll: 10,
                        // padding: FxSpacing.xy(8, 4),
                        padding: FxSpacing.xy(6, 9),
                        color: const Color(0xff1529e8),
                        child: FxText.bodySmall(
                          'Categories2',
                          fontWeight: 300,
                          color: Colors.white,
                          // color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    GestureDetector(
                      // onTap: () {
                      //   // showModalBottomSheet(
                      //   //     context: context,
                      //   //     builder: (BuildContext buildContext) {
                      //   //       return const FilterSheet();
                      //   //     });
                      //   showModalBottomSheet(
                      //     context: context,
                      //     backgroundColor: Colors.white,
                      //     shape: const RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(20),
                      //             topRight: Radius.circular(20))),
                      //     isScrollControlled: true,
                      //     builder: (context) {
                      //       return const FilterSheet();
                      //     },
                      //   );
                      // },
                      onTap: () async {
                        var data = await showModalBottomSheet(
                            context: context,
                            builder: (BuildContext buildContext) {
                              return FilterSheet(
                                categoryplace: widget.place,
                              );
                            });
                        setState(() {
                          controller.allattractionList = [];
                          controller.allattractionList = [data];
                        });
                        // showModalBottomSheet(
                        //   context: context,
                        //   backgroundColor: Colors.white,
                        //   shape: const RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.only(
                        //           topLeft: Radius.circular(20),
                        //           topRight: Radius.circular(20))),
                        //   isScrollControlled: true,
                        //   builder: (context) {
                        //     return const CategoriesBottomSheet();
                        //   },
                        // );
                      },
                      child: Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                            color: const Color(0xff1529e8),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: FxText.bodySmall(
                            'Filter',
                            fontWeight: 300,
                            color: Colors.white,
                            // color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Lottie.asset('assets/lottie/search_lottie.json',
                //     height: 300, width: 300),
                // Container(
                //     margin: FxSpacing.all(20),
                //     child: const Image(
                //       image: AssetImage(
                //           'assets/images/apps/shopping2/images/nodata_search.jpg'),
                //     )),
                Container(
                    margin: FxSpacing.all(20),
                    child: const Image(
                      image: AssetImage(
                          'assets/images/apps/shopping2/images/empty.png'),
                    )),
                Align(
                  alignment: Alignment.center,
                  child: FxText.bodyLarge(
                    "No Data found",
                    fontWeight: 900,
                  ),
                ),
              ],
            ));
      } else {
        return Scaffold(
          backgroundColor: const Color(0xfff5f5f5),
          key: controller.scaffoldKey,
          body: controller.allattractionList!.first.attractions == null
              ? const Text('No Data')
              : ListView(
                  padding: FxSpacing.fromLTRB(
                      20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
                  children: [
                    Container(
                      // padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(width: 1, color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.grey.shade400,
                            color: const Color(0xff1529e8).withOpacity(0.4),
                            blurRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        style: FxTextStyle.bodyMedium(),
                        controller: controller.SearchTE,
                        cursorColor: theme.colorScheme.primary,
                        // onChanged: (value) => _searchBooks(value),

                        // onChanged: _runFilter,
                        // onChanged: (value) {
                        //   // log('Total Data:${_filteredBooks.first.attractions.data.map((e) => e.title)}');
                        //   // log('Entered keyword:$value');
                        //   if (len == 0) {
                        //     temp2 = [..._filteredBooks];
                        //   }
                        //   // log('filter value:$_filteredBooks');

                        //   if (value.isEmpty) {
                        //     log('Temp:${_filteredBooks.first.attractions.data.map((e) => e.title)}');
                        //     controller.allattractionList!.first.attractions.data =
                        //         _filteredBooks.first.attractions.data;

                        //     setState(() {
                        //       // len = value.length;
                        //       // _filteredBooks = [
                        //       //   allattractionModalFromJson(json.encode(value))
                        //       // ];
                        //       controller.allattractionList!.first.attractions.data;
                        //       // _filteredBooks =
                        //       //     AllattractionModal as List<AllattractionModal>;
                        //     });
                        //     // log('Value:$_filteredBooks');
                        //     log('Empty :${controller.allattractionList!.first.attractions.data.map((e) => e.title)}');
                        //     return;
                        //   }

                        //   len = 1;
                        //   // print(' => ${_filteredBooks.first.attractions.toJson()}');

                        //   List<Datum> data =
                        //       temp2.first.attractions.data.where((Datum i) {
                        //     // log('title:${i.title}');
                        //     // log('value:$value');
                        //     return i.title
                        //         .toLowerCase()
                        //         .contains(value.toString().toLowerCase());
                        //   }).toList();

                        //   temp[0].attractions.data = data;

                        //   setState(() {
                        //     controller.allattractionList = temp;
                        //     len;
                        //   });

                        //   // log('Controller:${controller.allattractionList!.first.attractions.data.map((e) => e.title)}');
                        //   // print('temp:${temp2[0].attractions.data}');
                        // },
                        // onChanged: (value) {
                        //   // log('Total Data:${_filteredBooks.first.attractions.data.map((e) => e.title)}');
                        //   // log('Entered keyword:$value');
                        //   if (len == 0) {
                        //     temp2 = [..._filteredBooks];
                        //   }
                        //   // log('filter value:$_filteredBooks');

                        //   if (value.isEmpty) {
                        //     log('Temp:${_filteredBooks.first.attractions.data.map((e) => e.title)}');
                        //     controller.allattractionList!.first.attractions.data =
                        //         _filteredBooks.first.attractions.data;

                        //     setState(() {
                        //       // len = value.length;
                        //       // _filteredBooks = [
                        //       //   allattractionModalFromJson(json.encode(value))
                        //       // ];
                        //       controller.allattractionList!.first.attractions.data;
                        //       // _filteredBooks =
                        //       //     AllattractionModal as List<AllattractionModal>;
                        //     });
                        //     // log('Value:$_filteredBooks');
                        //     log('Empty :${controller.allattractionList!.first.attractions.data.map((e) => e.title)}');
                        //     return;
                        //   }

                        //   len = 1;
                        //   // print(' => ${_filteredBooks.first.attractions.toJson()}');

                        //   List<Datum> data =
                        //       temp2.first.attractions.data.where((Datum i) {
                        //     // log('title:${i.title}');
                        //     // log('value:$value');
                        //     return i.title
                        //         .toLowerCase()
                        //         .contains(value.toString().toLowerCase());
                        //   }).toList();

                        //   temp[0].attractions.data = data;

                        //   setState(() {
                        //     controller.allattractionList = temp;
                        //     len;
                        //   });

                        //   // log('Controller:${controller.allattractionList!.first.attractions.data.map((e) => e.title)}');
                        //   // print('temp:${temp2[0].attractions.data}');
                        // },
                        //2
                        onChanged: (value) async {
                          if (value.isEmpty) {
                            await AttractionController()
                                .getSearchattractionList(widget.place)
                                .then((value) {
                              if (value != null) {
                                isLoading = false;
                                controller.allattractionList = [];
                                controller.allattractionList!.add(value);
                                _filteredBooks = controller.allattractionList!;
                              }
                            });

                            setState(() {
                              // len = value.length;
                              // _filteredBooks = [
                              //   allattractionModalFromJson(json.encode(value))
                              // ];
                              controller
                                  .allattractionList!.first.attractions.data;
                              // _filteredBooks =
                              //     AllattractionModal as List<AllattractionModal>;
                            });
                            // log('Value:$_filteredBooks');

                            return;
                          }

                          len = 1;
                          // print(' => ${_filteredBooks.first.attractions.toJson()}');

                          List<Datum> data = _filteredBooks
                              .first.attractions.data
                              .where((Datum i) {
                            // log('title:${i.title}');
                            // log('value:$value');
                            return i.title
                                .toLowerCase()
                                .contains(value.toString().toLowerCase());
                          }).toList();

                          temp[0].attractions.data = data;

                          setState(() {
                            controller.allattractionList = temp;
                            len;
                          });

                          // log('Controller:${controller.allattractionList!.first.attractions.data.map((e) => e.title)}');
                          // print('temp:${temp2[0].attractions.data}');
                        },
                        // onChanged: (e) {
                        //   if (e != Null || e.isNotEmpty) {
                        //     // controller.allattractionList!.first.attractions.data = [];

                        //     for (var i in temp.first.attractions.data) {
                        //       log('i:$i');
                        //       if (i.title.toLowerCase().contains(e)) {
                        //         controller.allattractionList!.first.attractions.data
                        //             .add(i);
                        //       }
                        //     }

                        //     // if (value.title.toLowerCase().contains(e)) {
                        //     //   controller.allattractionList!.first.attractions.data
                        //     //       .add(value);
                        //     // }

                        //     log('Message:${controller.allattractionList!.first.attractions.data}');
                        //   } else {
                        //     controller.allattractionList!.first.attractions.data =
                        //         _filteredBooks.first.attractions.data;
                        //   }
                        // },

                        // onChanged: controller.runFilter1,
                        // onChanged: (value) => onSearchTextChanged(value),
                        // onChanged: (value) => controller.attractFilter(value),
                        decoration: InputDecoration(
                          hintText: "Search your place ...",
                          hintStyle: FxTextStyle.bodySmall(
                              color: theme.colorScheme.onBackground),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          // fillColor: const Color(0xffcfd2ff),
                          fillColor: theme.cardTheme.color,
                          prefixIcon: Icon(
                            FeatherIcons.search,
                            size: 16,
                            color:
                                theme.colorScheme.onBackground.withAlpha(150),
                          ),
                          isDense: true,
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    // Text(
                    //   widget.place.toString(),
                    //   style: const TextStyle(color: Colors.red),
                    // ),
                    FxSpacing.height(20),
                    //btn
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var data = await showModalBottomSheet(
                                context: context,
                                builder: (BuildContext buildContext) {
                                  return CategoriesBottomSheet(
                                    categoryplace: widget.place,
                                  );
                                });
                            if (data != null) {
                              setState(() {
                                controller.allattractionList = [];

                                controller.allattractionList = [data];
                              });
                            }
                            // showModalBottomSheet(
                            //   context: context,
                            //   backgroundColor: Colors.white,
                            //   shape: const RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.only(
                            //           topLeft: Radiaus.circular(20),
                            //           topRight: Radius.circular(20))),
                            //   isScrollControlled: true,
                            //   builder: (context) {
                            //     return const CategoriesBottomSheet();
                            //   },
                            // );
                          },
                          child: FxContainer(
                            borderRadiusAll: 10,
                            // padding: FxSpacing.xy(8, 4),
                            padding: FxSpacing.xy(6, 9),
                            color: const Color(0xff1529e8),
                            child: FxText.bodySmall(
                              'Categories',
                              fontWeight: 300,
                              color: Colors.white,
                              // color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        GestureDetector(
                          // onTap: () {
                          //   // showModalBottomSheet(
                          //   //     context: context,
                          //   //     builder: (BuildContext buildContext) {
                          //   //       return const FilterSheet();
                          //   //     });
                          //   showModalBottomSheet(
                          //     context: context,
                          //     backgroundColor: Colors.white,
                          //     shape: const RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.only(
                          //             topLeft: Radius.circular(20),
                          //             topRight: Radius.circular(20))),
                          //     isScrollControlled: true,
                          //     builder: (context) {
                          //       return const FilterSheet();
                          //     },
                          //   );
                          // },
                          onTap: () async {
                            var data = await showModalBottomSheet(
                                context: context,
                                builder: (BuildContext buildContext) {
                                  return FilterSheet(
                                    categoryplace: widget.place,
                                  );
                                });
                            if (data != null) {
                              setState(() {
                                controller.allattractionList = [];
                                controller.allattractionList = [data];
                              });
                            }
                            // showModalBottomSheet(
                            //   context: context,
                            //   backgroundColor: Colors.white,
                            //   shape: const RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.only(
                            //           topLeft: Radius.circular(20),
                            //           topRight: Radius.circular(20))),
                            //   isScrollControlled: true,
                            //   builder: (context) {
                            //     return const CategoriesBottomSheet();
                            //   },
                            // );
                          },
                          child: Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                                color: const Color(0xff1529e8),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: FxText.bodySmall(
                                'Filter',
                                fontWeight: 300,
                                color: Colors.white,
                                // color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    FxSpacing.height(20),
                    //content
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      // child: _buildProductList(),
                      child:

                          // controller.foundrecipe.isNotEmpty
                          //     ?
                          _filteredBooks.isNotEmpty
                              ? _buildProductListUi()
                              : const Text('No Data'),
                    ),
                  ],
                ),
        );
      }
    }
  }

  //topatt
  Widget _buildProductListUi() {
    List<Widget> list = [];

    // for (Product product in controller.products!)
    for (var product in controller.allattractionList!.first.attractions.data) {
      String text = product.category.categoryName.name;
      // String text = "Theme Park,Theme Park";

      text = text.replaceAll("_", " ");

      List<String> words = text.split(" ");
      // var currencySymbol = selectedCountry!.isocode;
      // var conversionRate = selectedCountry!.conversionRate;
      for (int i = 0; i < words.length; i++) {
        words[i] =
            words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      }

      text = words.join(" ");
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: InkWell(
          onTap: () {
            controller.goToSingleProduct(
                product, widget.currencySymbol, widget.conversionRate);
          },
          child: Container(
            // onTap: () {
            //   controller.goToSingleProduct(product);
            // },
            // borderRadiusAll: 4,
            // // paddingAll: 16,
            // height: 120,
            height: 132,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey.shade300, width: 1)),
            margin: const EdgeInsets.only(
              bottom: 20,
            ),
            // //margin: EdgeInsets.all(8),
            // // color: Colors.green,
            // margin: FxSpacing.bottom(20),

            child: Container(
              margin: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Container(
                    // margin: EdgeInsets.all(8),
                    // paddingAll: 0,
                    // borderRadiusAll: 4,
                    // margin: EdgeInsets.all(8),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    // child: Image(image: NetworkImage(product.images.first)),
                    child: Hero(
                      tag: "product_image_${product.images.first}",
                      child: CachedNetworkImage(
                        height: 132,
                        width: 150,
                        fit: BoxFit.cover,
                        fadeOutDuration: const Duration(seconds: 1),
                        fadeInDuration: const Duration(seconds: 3),
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        ),
                        imageUrl:
                            'https://a.walletbot.online${product.images.first}',
                      ),
                    ),
                  ),
                  FxSpacing.width(20),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: FxContainer(
                                  borderRadiusAll: 10,
                                  // padding: FxSpacing.xy(8, 4),
                                  padding: FxSpacing.xy(6, 2),
                                  // color: Color(0xff1529e8),
                                  color: Colors.blueGrey,
                                  child: Center(
                                    child: FxText.bodySmall(
                                      // overflow: TextOverflow.ellipsis,
                                      // maxLines: 1,
                                      text,

                                      fontWeight: 300,
                                      color: Colors.white,
                                      // color: theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                              // FxContainer(
                              //   borderRadiusAll: 10,
                              //   // padding: FxSpacing.xy(8, 4),
                              //   padding: FxSpacing.xy(6, 2),
                              //   // color: Color(0xff1529e8),
                              //   color: Colors.blueGrey,
                              //   child: Center(
                              //     child: FxText.bodySmall(
                              //       // product.bookingType.name,
                              //       product.bookingType.name[0]
                              //               .toUpperCase() +
                              //           product.bookingType.name
                              //               .substring(1)
                              //               .toLowerCase(),
                              //       // 'Ticket',
                              //       fontWeight: 300,
                              //       color: Colors.white,
                              //       // color: theme.colorScheme.onPrimary,
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(
                              //   width: 5,
                              // ),

                              product.isOffer == false
                                  ? Container()
                                  : FxContainer(
                                      borderRadiusAll: 10,
                                      // padding: FxSpacing.xy(8, 4),
                                      padding: FxSpacing.xy(6, 2),
                                      // color: Color(0xff1529e8),
                                      color: Colors.blueGrey,
                                      child: FxText.bodySmall(
                                        'Offer',

                                        fontWeight: 300,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white,
                                        // color: theme.colorScheme.onPrimary,
                                      ),
                                    ),
// <<<<<<< HEAD
//                                     ),
//                                   ),
//                                 ),
//                                 // FxContainer(
//                                 //   borderRadiusAll: 10,
//                                 //   // padding: FxSpacing.xy(8, 4),
//                                 //   padding: FxSpacing.xy(6, 2),
//                                 //   // color: Color(0xff1529e8),
//                                 //   color: Colors.blueGrey,
//                                 //   child: Center(
//                                 //     child: FxText.bodySmall(
//                                 //       // product.bookingType.name,
//                                 //       product.bookingType.name[0]
//                                 //               .toUpperCase() +
//                                 //           product.bookingType.name
//                                 //               .substring(1)
//                                 //               .toLowerCase(),
//                                 //       // 'Ticket',
//                                 //       fontWeight: 300,
//                                 //       color: Colors.white,
//                                 //       // color: theme.colorScheme.onPrimary,
//                                 //     ),
//                                 //   ),
//                                 // ),
//                                 // const SizedBox(
//                                 //   width: 5,
//                                 // ),
//
//                                 product.isOffer == false
//                                     ? Container()
//                                     : FxContainer(
//                                   borderRadiusAll: 10,
//                                   // padding: FxSpacing.xy(8, 4),
//                                   padding: FxSpacing.xy(6, 2),
//                                   // color: Color(0xff1529e8),
//                                   color: Colors.blueGrey,
//                                   child: FxText.bodySmall(
//                                     'Offer',
//
//                                     fontWeight: 300,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     color: Colors.white,
//                                     // color: theme.colorScheme.onPrimary,
//                                   ),
//                                 )
//                                 ]
//                             ),
// =======
//                                     )
//                             ]),
// >>>>>>> fbbb748cc95e63646309c21ad393ab877c48ed96,
                            ],
                          ),
                          FxSpacing.height(8),
                          Hero(
                            tag: "product_title_${product.title}",
                            // child: FxText.bodyLarge(
                            //   product.name,
                            //   // fontWeight: 500,
                            // ),
                            child: FxText.bodyLarge(
                              product.title[0].toUpperCase() +
                                  product.title.substring(1).toLowerCase(),
                              fontWeight: 800,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          FxSpacing.height(4),
                          Hero(
// <<<<<<< HEAD
                            tag: "${product.duration}",
                            child: FxText.labelLarge(
                              // "65",
                              // '${controller.currency() ?? '\$'} ${product.activity.adultPrice.toString()}',
                              // " ${(selectedCountry != null ? "${((product.activity.lowPrice * selectedCountry!.conversionRate) as double).toStringAsFixed(2)} ${selectedCountry!.isocode} " : "")}",
                              '${((product.activity.lowPrice * conversionRate) as double).toStringAsFixed(2)} $currencySymbol',
                              // '${product.activity.lowPrice} AED',

                              fontWeight: 700,
                            ),
                          ),
                          FxSpacing.height(6),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Hero(
                                  tag: "${product.averageRating}",
                                  child: Row(children: [
                                    const Icon(
                                      // FeatherIcons.star,
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 12,
                                    ),
                                    FxSpacing.width(4),
                                    FxText.bodySmall(
                                      product.averageRating.toStringAsFixed(1),
                                      fontWeight: 600,
                                      color: Colors.black,
                                    ),
                                    FxSpacing.width(4),
                                    FxText.bodySmall(
                                      "(${product.totalReviews.toStringAsFixed(0)})",
                                      fontWeight: 600,
                                      color: Colors.black,
                                    ),
                                  ]),
                                )
                              ]),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
    }

    return Column(
      children: list,
    );
  }

  // Widget _buildProductList() {
  //   String f = FxTextUtils.randomString(10); //new page nav
  //   List<Widget> list = [];

  //   for (Product product in controller.products!) {
  //     log(product.name);
  //     log(controller.products!.length.toString());
  //     list.add(FadeTransition(
  //       opacity: controller.fadeAnimation,
  //       child: InkWell(
  //         onTap: () {
  //           controller.goToSingleProduct(product);
  //           // Navigator.push(
  //           //     context,
  //           //     PageRouteBuilder(
  //           //         transitionDuration: Duration(milliseconds: 500),
  //           //         pageBuilder: (_, __, ___) =>
  //           //             GrocerySingleProductScreen(product, heroKey)));
  //         },
  //         child: Container(
  //           // borderRadiusAll: 4,
  //           // // paddingAll: 16,
  //           // height: 120,
  //           height: 132,
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: const BorderRadius.all(Radius.circular(10)),
  //               border: Border.all(color: Colors.grey.shade300, width: 1)),
  //           margin: const EdgeInsets.only(
  //             bottom: 20,
  //           ),
  //           // //margin: EdgeInsets.all(8),
  //           // // color: Colors.green,
  //           // margin: FxSpacing.bottom(20),

  //           child: Container(
  //             margin: const EdgeInsets.all(8),
  //             child: Row(
  //               children: [
  //                 Container(
  //                   // margin: EdgeInsets.all(8),
  //                   // paddingAll: 0,
  //                   // borderRadiusAll: 4,
  //                   // margin: EdgeInsets.all(8),

  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                   clipBehavior: Clip.antiAliasWithSaveLayer,
  //                   child: Hero(
  //                     tag: "product_image_${product.name}",
  //                     child: Image(
  //                       image: AssetImage(product.image),
  //                       // height: 100,
  //                       height: 132,
  //                       width: 150,
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 ),
  //                 FxSpacing.width(20),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           FxContainer(
  //                             borderRadiusAll: 10,
  //                             // padding: FxSpacing.xy(8, 4),
  //                             padding: FxSpacing.xy(6, 2),
  //                             // color: Color(0xff1529e8),
  //                             color: Colors.blueGrey,
  //                             child: FxText.bodySmall(
  //                               overflow: TextOverflow.ellipsis,
  //                               maxLines: 1,
  //                               // 'Theme Park',
  //                               'Park',
  //                               fontWeight: 300,
  //                               color: Colors.white,
  //                               // color: theme.colorScheme.onPrimary,
  //                             ),
  //                           ),
  //                           const SizedBox(
  //                             width: 5,
  //                           ),
  //                           FxContainer(
  //                             borderRadiusAll: 10,
  //                             // padding: FxSpacing.xy(8, 4),
  //                             padding: FxSpacing.xy(6, 2),
  //                             // color: Color(0xff1529e8),
  //                             color: Colors.blueGrey,
  //                             child: FxText.bodySmall(
  //                               'Ticket',
  //                               fontWeight: 300,
  //                               color: Colors.white,
  //                               // color: theme.colorScheme.onPrimary,
  //                             ),
  //                           ),
  //                           const SizedBox(
  //                             width: 5,
  //                           ),
  //                           FxContainer(
  //                             borderRadiusAll: 10,
  //                             // padding: FxSpacing.xy(8, 4),
  //                             padding: FxSpacing.xy(6, 2),
  //                             // color: Color(0xff1529e8),
  //                             color: Colors.blueGrey,
  //                             child: FxText.bodySmall(
  //                               'Offer',
  //                               fontWeight: 300,
  //                               color: Colors.white,
  //                               // color: theme.colorScheme.onPrimary,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       FxSpacing.height(8),
  //                       Hero(
  //                         tag: "product_${product.name}",
  //                         // child: FxText.bodyLarge(
  //                         //   product.name,
  //                         //   // fontWeight: 500,
  //                         // ),
  //                         child: FxText.bodyLarge(
  //                           product.name,
  //                           fontWeight: 800,
  //                           overflow: TextOverflow.ellipsis,
  //                           maxLines: 2,
  //                         ),
  //                       ),
  //                       FxSpacing.height(4),
  //                       Hero(
  //                         tag: "${product.name}_${product.price}",
  //                         child: FxText.labelLarge(
  //                           // '\$' + product.price.toString(),
  //                           "${product.price} AED",
  //                           // "\$" + product.price.toString() + "/hour",
  //                           fontWeight: 700,
  //                         ),
  //                       ),
  //                       FxSpacing.height(6),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Hero(
  //                             tag: "${product.name}_${product.rating}",
  //                             child: Row(
  //                               children: [
  //                                 const Icon(
  //                                   // FeatherIcons.star,
  //                                   Icons.star,
  //                                   color: Colors.yellow,
  //                                   size: 12,
  //                                 ),
  //                                 FxSpacing.width(4),
  //                                 FxText.bodySmall(
  //                                   '4.5',
  //                                   fontWeight: 600,
  //                                   color: Colors.black,
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           // FxContainer.bordered(
  //                           //   paddingAll: 4,
  //                           //   borderRadiusAll: 4,
  //                           //   child: Icon(
  //                           //     FeatherIcons.plus,
  //                           //     size: 14,
  //                           //     color: theme.colorScheme.onBackground,
  //                           //   ),
  //                           // ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ));
  //   }

  //   return Column(
  //     children: list,
  //   );
  // }

  Widget endDrawer() {
    return Container(
      margin:
          FxSpacing.fromLTRB(20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: theme.scaffoldBackgroundColor,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Drawer(
        child: Container(
          color: theme.scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: FxSpacing.xy(16, 12),
                // color: theme.colorScheme.primary,
                color: const Color(0xff1529e8),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: FxText(
                          "Filter",
                          fontWeight: 700,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    FxContainer.rounded(
                        onTap: () {
                          controller.closeEndDrawer();
                        },
                        paddingAll: 6,
                        color: theme.colorScheme.onPrimary.withAlpha(80),
                        child: Icon(
                          FeatherIcons.x,
                          size: 12,
                          color: theme.colorScheme.onPrimary,
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                padding: FxSpacing.all(20),
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FxText.bodyMedium(
                          "Type",
                          color: theme.colorScheme.onBackground,
                          fontWeight: 600,
                        ),
                        // FxText.bodySmall(
                        //   "${controller.selectedChoices.length} selected",
                        //   color: theme.colorScheme.onBackground,
                        //   fontWeight: 600,
                        //   xMuted: true,
                        // ),
                      ],
                    ),
                  ),
                  FxSpacing.height(16),
                  // Container(
                  //   child: Wrap(
                  //     spacing: 10,
                  //     runSpacing: 10,
                  //     children: _buildType(),
                  //   ),
                  // ),
                  FxSpacing.height(24),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FxText.bodyMedium(
                          "Price Range",
                          color: theme.colorScheme.onBackground,
                          fontWeight: 600,
                        ),
                        FxText.bodySmall(
                          "\$${controller.selectedRange.start.toInt()} - \$${controller.selectedRange.end.toInt()}",
                          // color: theme.colorScheme.primary,
                          color: const Color(0xff1529e8),
                          fontWeight: 600,
                          letterSpacing: 0.35,
                        )
                      ],
                    ),
                  ),
                  FxSpacing.height(16),
                  Container(
                    child: RangeSlider(
                        activeColor: const Color(0xff1529e8),
                        inactiveColor: const Color(0xff5563e8),
                        // activeColor: theme.colorScheme.primary,
                        // inactiveColor: theme.colorScheme.primary.withAlpha(100),
                        max: 10000,
                        min: 0,
                        values: controller.selectedRange,
                        onChanged: (RangeValues newRange) {
                          controller.onChangePriceRange(newRange);
                        }),
                  ),
                ],
              )),
              Container(
                child: Row(
                  children: [
                    Expanded(
                        child: FxContainer(
                      onTap: () {
                        controller.closeEndDrawer();
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
                        controller.closeEndDrawer();
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
        ),
      ),
    );
  }

  // List<Widget> _buildType() {
  //   List<Widget> choices = [];
  //   for (var item in controller.categoryList) {
  //     bool selected = controller.selectedChoices.contains(item);
  //     if (selected) {
  //       choices.add(FxContainer.none(
  //           color: theme.colorScheme.primary.withAlpha(28),
  //           bordered: true,
  //           borderRadiusAll: 20,
  //           paddingAll: 8,
  //           border: Border.all(color: theme.colorScheme.primary),
  //           onTap: () {
  //             controller.removeChoice(item);
  //           },
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Icon(
  //                 Icons.check,
  //                 size: 14,
  //                 color: theme.colorScheme.primary,
  //               ),
  //               FxSpacing.width(6),
  //               FxText.bodySmall(
  //                 item,
  //                 fontSize: 11,
  //                 color: theme.colorScheme.primary,
  //               )
  //             ],
  //           )));
  //     } else {
  //       choices.add(FxContainer.none(
  //         color: theme.cardTheme.color,
  //         borderRadiusAll: 20,
  //         padding: FxSpacing.xy(12, 8),
  //         onTap: () {
  //           controller.addChoice(item);
  //         },
  //         child: FxText.bodySmall(
  //           item,
  //           color: theme.colorScheme.onBackground,
  //           fontSize: 11,
  //         ),
  //       ));
  //     }
  //   }
  //   return choices;
  // }
}
