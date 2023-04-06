import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../loading_effect.dart';
import '../../models/tickets.dart';
import '../../theme/app_theme.dart';
import '../controller/flight_list_controller.dart';
import '../widgets/flight_detail_chip.dart';

class FlightList extends StatefulWidget {
  const FlightList({super.key});

  @override
  State<FlightList> createState() => _FlightListState();
}

class _FlightListState extends State<FlightList> with TickerProviderStateMixin {
  late FlightListController controller;
  late ThemeData theme, theme1;

  @override
  void initState() {
    super.initState();

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(FlightListController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  List<Widget> _buildType() {
    List<Widget> choices = [];
    for (var item in controller.flightnameList) {
      bool selected = controller.selectedChoices.contains(item);
      if (selected) {
        choices.add(GestureDetector(
          onTap: () {
            controller.removeChoice(item);
            setState(() {});
          },
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
              width: 70,
              decoration: BoxDecoration(
                  // color: Color(0xff1529e8),
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    width: 1,
                    color: const Color(0xff1529e8),
                  )),
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.center,
                child: FxText.bodySmall(
                  item,
                  fontSize: 11,
                  color: const Color(0xff1529e8),
                  // color: theme.colorScheme.primary,
                ),
              )),
        ));
      } else {
        choices.add(GestureDetector(
          onTap: () {
            controller.addChoice(item);
            setState(() {});
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            width: 70,
            decoration: const BoxDecoration(
                color: Color(0xff1529e8),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            padding: const EdgeInsets.all(8),
            child: Align(
              alignment: Alignment.center,
              child: FxText.bodySmall(
                item,
                color: Colors.white,
                // color: theme.colorScheme.onBackground,
                fontSize: 11,
              ),
            ),
          ),
        ));
      }
    }
    return choices;
  }

  Widget _buildProductList() {
    log('calling ticet');
    List<Widget> list = [];

    for (Tickets ticket1 in controller.tickets!) {
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: GestureDetector(
          onTap: () {},
          child: Container(
              margin: const EdgeInsets.only(bottom: 5),
              height: 144,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'DEL-JK',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.indigo),
                        ),
                        Spacer(),
                        Text(
                          'FASTEST',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.red),
                        ),
                      ],
                    ),
                    FxSpacing.height(15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '23:45:4:30',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            FxSpacing.height(10),
                            const Text(
                              '15h 15m' ' • Direct',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        const Spacer(),
                        FxText.bodySmall(
                          '256 AED',
                          fontWeight: 600,
                          // fontSize: 25,
                          color: const Color(0xff1529e8),
                        ),
                      ],
                    ),
                    FxSpacing.height(15),
                    Row(
                      children: [
                        Image.asset(
                          'assets/other/logo.png',
                          height: 24,
                        ),
                        FxSpacing.width(20),
                        const Text(
                          'United Airline UA802',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ));
    }

    return Column(
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<FlightListController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
      return Scaffold(
          body: Padding(
        padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
        child: LoadingEffect.getReviewLoadingScreen(
          context,
          // theme, theme.colorScheme
        ),
      ));
    } else {
      return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        // appBar: AppBar(
        //   elevation: 0,
        //   title: FxText.titleMedium(
        //     'Flight\'s List',
        //     color: Colors.white,
        //     fontWeight: 700,
        //   ),
        //   centerTitle: true,
        //   automaticallyImplyLeading: false,
        //   leading: InkWell(
        //     onTap: () {
        //       controller.goBack(canRefresh: true);
        //     },
        //     child: const Icon(
        //       FeatherIcons.chevronLeft,
        //       size: 20,
        //     ).autoDirection(),
        //   ),
        // ),
        body: SafeArea(
          child: _buildSearch(),
        ),
        // body: Stack(children: [
        //   _buildSearch(),
        //   Positioned(
        //       bottom: 0,
        //       left: 0,
        //       right: 0,
        //       child: Container(
        //         padding: FxSpacing.xy(12, 8),
        //         child: PhysicalModel(
        //           color: theme.cardTheme.color!.withAlpha(200),
        //           elevation: 12,
        //           borderRadius: const BorderRadius.all(Radius.circular(32)),
        //           shadowColor: theme.colorScheme.onBackground.withAlpha(12),
        //           shape: BoxShape.rectangle,
        //           child: Container(
        //             decoration: BoxDecoration(
        //               color: theme.cardTheme.color!.withAlpha(200),
        //               borderRadius: const BorderRadius.all(Radius.circular(32)),
        //             ),
        //             padding: FxSpacing.xy(16, 12),
        //             child: const Text('data'),
        //           ),
        //         ),
        //       ))
        // ]),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 70,
              // color: Colors.grey.shade500,
              color: const Color(0xff1529e8).withAlpha(40),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    child: ListView(
                      scrollDirection: Axis.horizontal,

                      // children: List.generate(
                      //   controller.flightnameList.length,
                      //   (index) {
                      //     return Container(
                      //       margin: const EdgeInsets.symmetric(
                      //           horizontal: 6, vertical: 10),
                      //       width: 70,
                      //       decoration: const BoxDecoration(
                      //           color: Color(0xff1529e8),
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(5))),
                      //       // padding: const EdgeInsets.all(8),
                      //       child: ChoiceChip(
                      //         labelPadding: const EdgeInsets.all(2.0),
                      //         label: FxText.bodySmall(
                      //             controller.flightnameList[index],
                      //             color:
                      //                 controller.defaultChoiceIndex == index
                      //                     ? Colors.white
                      //                     : Colors.red,
                      //             fontSize: 14),
                      //         selected:
                      //             controller.defaultChoiceIndex == index,
                      //         selectedColor: const Color(0xff1529e8),
                      //         onSelected: (value) {
                      //           setState(() {
                      //             controller.defaultChoiceIndex = value
                      //                 ? index
                      //                 : controller.defaultChoiceIndex;

                      //             log('index:${controller.defaultChoiceIndex.toString()}');
                      //           });
                      //         },
                      //         elevation: 1,
                      //       ),
                      //     );
                      //   },
                      // )
                      children: _buildType(),
                    ),
                  )),
                  Container(
                    color: Colors.blue,
                    padding: FxSpacing.xy(12, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          FeatherIcons.sliders,
                          color: Colors.white,
                        ),
                        FxText(
                          'Sort & Filter',
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildSearch() {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: FxSpacing.fromLTRB(
          16,
          //  FxSpacing.safeAreaTop(context) + 16,
          5,
          16,
          20),
      children: <Widget>[
        //     controller.adddate
        //         ? Navigator.of(context, rootNavigator: true).pushReplacement(
        //   PageRouteBuilder(
        //       transitionDuration: const Duration(seconds: 2),
        //       pageBuilder: (_, __, ___) => const FlightHomeScreen()),
        // )
        //         :
        Container(
          // padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: theme.cardTheme.color,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        // FeatherIcons.chevronLeft,
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                    FxSpacing.width(10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              FxText.bodyMedium(
                                'Kochi to NewDelhi',
                                fontSize: 20,
                                fontWeight: 700,
                                color: Colors.black,
                              ),
                              FxSpacing.width(20),
                              Container(
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FxContainer(
                                    onTap: () {
                                      controller.Edit();
                                      // log('g');
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const FlightHomeScreen()));
                                      // controller.adddate
                                      //     ? controller.cartController
                                      //         .reverse()
                                      //     : controller.cartController
                                      //         .forward();
                                    },
                                    padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                                    color:
                                        const Color(0xff1529e8).withAlpha(40),
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        FxText.bodyMedium("Edit",
                                            color: const Color(0xff1529e8),
                                            fontWeight: 500,
                                            letterSpacing: -0.2),
                                        FxSpacing.width(5),
                                        const Icon(
                                          MdiIcons.pen,
                                          size: 14,
                                          color: Color(0xff1529e8),
                                        )
                                      ],
                                    ),
                                  ),
                                  FxSpacing.width(10),
                                ],
                              ))
                            ],
                          ),
                          FxSpacing.height(7),
                          Row(
                            children: [
                              FxText.bodyMedium(
                                '05 Apr',
                                fontSize: 15,
                                fontWeight: 500,
                                color: Colors.black54,
                              ),
                              FxSpacing.width(5),
                              Container(
                                height: 20,
                                width: 3,
                                color: Colors.black54,
                              ),
                              FxSpacing.width(5),
                              FxText.bodyMedium(
                                '1 Adult',
                                fontSize: 15,
                                fontWeight: 500,
                                color: Colors.black54,
                              ),
                              // const VerticalDivider(
                              //   color: Colors.black, //color of divider
                              //   width: 10, //width space of divider
                              //   thickness: 3, //thickness of divier line
                              //   indent: 10, //Spacing at the top of divider.
                              //   endIndent:
                              //       10, //Spacing at the bottom of divider.
                              // ),
                              FxSpacing.width(5),
                              Container(
                                height: 20,
                                width: 3,
                                color: Colors.black54,
                              ),
                              FxSpacing.width(5),
                              FxText.bodyMedium(
                                'Economy/Premium Class',
                                fontSize: 15,
                                fontWeight: 500,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        FxSpacing.height(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7),
          child: FxText.bodyMedium(
            "Best Deals for Next 6 Months",
            fontWeight: 900,
          ),
        ),
        FxSpacing.height(10),
        _buildProductList()
        // _flightCard(),
        // _reservationsItem()
        // _buildDealsList()
        // StreamBuilder(
        //   stream: flightListBloc.dealsStream,
        //   builder: (context, snapshot) {
        //     return !snapshot.hasData
        //         ? Center(child: CircularProgressIndicator())
        //         : _buildDealsList(context, snapshot.data.documents);
        //   },
        // ),
      ],
    );
  }

  Widget _flightCard() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () async {},
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
                onTap: () {
                  // Get.toNamed(Routes.FLIGHTDETAILS);
                },
                child: Container(
                    height: 144,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'DEL-JK',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.indigo),
                              ),
                              Spacer(),
                              Text(
                                'FASTEST',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          FxSpacing.height(15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '23:45:4:30',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                  FxSpacing.height(10),
                                  const Text(
                                    '15h 15m' ' • Direct',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              FxText.bodySmall(
                                '256 AED',
                                fontWeight: 600,
                                // fontSize: 25,
                                color: const Color(0xff1529e8),
                              ),
                            ],
                          ),
                          FxSpacing.height(15),
                          Row(
                            children: [
                              Image.asset(
                                'assets/other/logo.png',
                                height: 24,
                              ),
                              FxSpacing.width(20),
                              const Text(
                                'United Airline UA802',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ));
      },
    );
  }

  Widget _reservationsItem() {
    return Container(
      width: 500,
      height: 200,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(14))),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(
                'assets/other/logo.png',
                height: 24,
              ),
              FxSpacing.width(15),
              const Text("Jet Airways",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              Expanded(child: Container()),
              const Text("\$999",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              // const SizedBox(width: 15),
              // const Icon(Icons.trending_flat, color: Colors.black, size: 27)
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _itemDepartment(),
              _locationPlane(),
              _itemDepartment2()
            ],
          )
        ],
      ),
    );
  }

  Widget _itemDepartment() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Departure", style: TextStyle(color: Colors.black54)),
          SizedBox(height: 10),
          Text("04:55",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          SizedBox(height: 1),
          Text("SFO", style: TextStyle(color: Colors.black54)),
          SizedBox(height: 20),
          Text("21:55",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          SizedBox(height: 1),
          Text("JFK", style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _itemDepartment2() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Arrive", style: TextStyle(color: Colors.black54)),
          SizedBox(height: 10),
          Text("09:55",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          SizedBox(height: 1),
          Text("JFK", style: TextStyle(color: Colors.black54)),
          SizedBox(height: 20),
          Text("02:45",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          SizedBox(height: 1),
          Text("SFO", style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _locationPlane() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.flight_takeoff, color: Colors.blue, size: 21),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.location_on, color: Colors.blue, size: 21),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const <Widget>[
              Icon(Icons.location_on, color: Colors.blue, size: 21),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.blue, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.fiber_manual_record, color: Colors.green, size: 8),
              Icon(Icons.flight_takeoff, color: Colors.blue, size: 21),
            ],
          )
        ],
      ),
    );
  }

//okay
  Widget _buildDealsList() {
    log('buildDealsList()');
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Colors.red,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: const <Widget>[
                            Text(
                              // '${formatCurrency.format(flightDetails.newPrice)}',
                              '50.00',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              // "(${formatCurrency.format(flightDetails.oldPrice)})",
                              '10.00',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: -8.0,
                          children: <Widget>[
                            FlightDetailChip(Icons.calendar_today, '24-05-2023'
                                // '${flightDetails.date}'
                                ),
                            FlightDetailChip(
                                Icons.flight_takeoff,
                                // '${flightDetails.airlines}'
                                'Indigo'),
                            FlightDetailChip(
                                Icons.star,
                                // '${flightDetails.rating}'
                                '4.5'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10.0,
                  right: 0.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: const BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      // '${flightDetails.discount}%',
                      '10%',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          );
          return null;
        });
  }
}
