import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/extensions/extensions.dart';

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
        appBar: AppBar(
          elevation: 0,
          title: FxText.titleMedium(
            'Flight\'s List',
            color: Colors.white,
            fontWeight: 700,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              controller.goBack(canRefresh: true);
            },
            child: const Icon(
              FeatherIcons.chevronLeft,
              size: 20,
            ).autoDirection(),
          ),
        ),
        body: SafeArea(
          child: _buildSearch(),
        ),
      );
    }
  }

  Widget _buildSearch() {
    return Padding(
      // padding: const EdgeInsets.only(left: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: <Widget>[
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
      ),
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
