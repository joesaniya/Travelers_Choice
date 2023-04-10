import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:gap/gap.dart';

import '../../models/tickets.dart';
import '../../theme/app_theme.dart';
import '../controller/upcoming_controller.dart';
import '../utils/app_layout.dart';
import '../utils/app_styles.dart';
import 'circula_container.dart';

class UpcomingFlights extends StatefulWidget {
  const UpcomingFlights({super.key});

  @override
  State<UpcomingFlights> createState() => _UpcomingFlightsState();
}

class _UpcomingFlightsState extends State<UpcomingFlights>
    with TickerProviderStateMixin {
  late CustomTheme customTheme;
  late ThemeData theme, theme1;
  late UpcomingFlightController controller;

  @override
  void initState() {
    super.initState();

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(UpcomingFlightController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FxBuilder<UpcomingFlightController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  bool? iscolorful;
  Widget _buildProductList() {
    final size = Applayout.getsize(context);
    List<Widget> list = [];

    for (Tickets ticket1 in controller.tickets!) {
      list.add(FadeTransition(
          opacity: controller.fadeAnimation,
          child: GestureDetector(
            onTap: () {
              controller.Bookseat();
            },
            child: SizedBox(
              // width: size.width * 0.85,
              width: MediaQuery.of(context).size.width,
              height: 169,
              child: Container(
                // margin: const EdgeInsets.only(left: 16),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(21),
                              topRight: Radius.circular(21)),
                          color: iscolorful == null
                              ? const Color(0xff1529e8).withAlpha(40)
                              // const Color(0xFF526799)
                              : Colors.white),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              FxText.bodyMedium(
                                // "${ticket_map["from"]["code"]}",
                                ticket1.fcode,
                                color: const Color(0xff1529e8),
                                fontWeight: 900,
                                // style: iscolorful == null
                                //     ? Styles.headlinestyle3
                                //         .copyWith(color: Colors.white)
                                //     : Styles.headlinestyle3,
                              ),
                              Expanded(child: Container()),
                              CircularContainer(
                                iscolorful: true,
                              ),
                              Expanded(
                                  child: Stack(
                                children: [
                                  SizedBox(
                                      height: 24,
                                      child: LayoutBuilder(
                                        builder: (BuildContext context,
                                            BoxConstraints constraints) {
                                          return Flex(
                                            direction: Axis.horizontal,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: List.generate(
                                                (constraints.constrainWidth() /
                                                        6)
                                                    .floor(),
                                                (index) => Text(
                                                      "-",
                                                      style: TextStyle(
                                                          color: iscolorful ==
                                                                  null
                                                              ? Colors.black
                                                              // Colors.white
                                                              : Colors.grey
                                                                  .shade300),
                                                    )),
                                          );
                                        },
                                      )),
                                  Center(
                                    child: Transform.rotate(
                                      angle: 1.5,
                                      child: Icon(
                                        Icons.local_airport_outlined,
                                        color: iscolorful == null
                                            ? Colors.black
                                            // Colors.white
                                            : const Color(0xFF8ACCF7),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                              CircularContainer(
                                iscolorful: true,
                              ),
                              const Spacer(),
                              FxText.bodyMedium(
                                // "${ticket_map["to"]["code"]}",
                                ticket1.fcode,
                                color: const Color(0xff1529e8),
                                fontWeight: 900,
                                // style: iscolorful == null
                                //     ? Styles.headlinestyle3
                                //         .copyWith(color: Colors.white)
                                //     : Styles.headlinestyle3,
                              )
                            ],
                          ),
                          const Gap(3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FxText.bodyMedium(
                                // "${ticket_map["from"]["name"]}",
                                ticket1.fname,
                                color: const Color(0xff1529e8),
                                fontWeight: 900,
                                // style: iscolorful == null
                                //     ? Styles.headlinestyle4
                                //         .copyWith(color: Colors.white)
                                //     : Styles.headlinestyle4,
                              ),
                              FxText.bodyMedium(
                                // "${ticket_map["flying_time"]}",
                                // ticket1.flyingtime,
                                '8h 40m',
                                color: const Color(0xff1529e8),
                                fontWeight: 900,
                                // style: iscolorful == null
                                //     ? Styles.headlinestyle4
                                //         .copyWith(color: Colors.white)
                                //     : Styles.headlinestyle4,
                              ),
                              FxText.bodyMedium(
                                // "${ticket_map["to"]["name"]}",
                                ticket1.fname,
                                color: const Color(0xff1529e8),
                                fontWeight: 900,
                                // style: iscolorful == null
                                //     ? Styles.headlinestyle4
                                //         .copyWith(color: Colors.white)
                                //     : Styles.headlinestyle4,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: iscolorful == null
                          ? const Color(0xff1529e8)
                          // Styles.orangecolor
                          : Colors.white,
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 20,
                            width: 10,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                return Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                      (constraints.constrainWidth() / 15)
                                          .floor(),
                                      (index) => SizedBox(
                                            height: 1,
                                            width: 5,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  color: iscolorful == null
                                                      ? Colors.white
                                                      : Colors.grey.shade300),
                                            ),
                                          )),
                                );
                              },
                            ),
                          )),
                          const SizedBox(
                            height: 20,
                            width: 10,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: iscolorful == null
                                  ? const Radius.circular(21)
                                  : const Radius.circular(0),
                              bottomRight: iscolorful == null
                                  ? const Radius.circular(21)
                                  : const Radius.circular(0)),
                          color: iscolorful == null
                              ? const Color(0xff1529e8)
                              // Styles.orangecolor
                              : Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                // "${ticket_map["date"]}",
                                ticket1.dateflight,
                                style: iscolorful == null
                                    ? Styles.headlinestyle3
                                        .copyWith(color: Colors.white)
                                    : Styles.headlinestyle3,
                              ),
                              Text("Date",
                                  style: iscolorful == null
                                      ? Styles.headlinestyle4
                                          .copyWith(color: Colors.white)
                                      : Styles.headlinestyle4),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                  // "${ticket_map["departure_time"]}",
                                  ticket1.departuretime,
                                  style: iscolorful == null
                                      ? Styles.headlinestyle3
                                          .copyWith(color: Colors.white)
                                      : Styles.headlinestyle3),
                              Text("Departure Time",
                                  style: iscolorful == null
                                      ? Styles.headlinestyle4
                                          .copyWith(color: Colors.white)
                                      : Styles.headlinestyle4),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                  // "${ticket_map["number"]}",
                                  ticket1.number.toString(),
                                  style: iscolorful == null
                                      ? Styles.headlinestyle4
                                          .copyWith(color: Colors.white)
                                      : Styles.headlinestyle3),
                              Text("Number",
                                  style: iscolorful == null
                                      ? Styles.headlinestyle4
                                          .copyWith(color: Colors.white)
                                      : Styles.headlinestyle4),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )));
    }

    return Column(
      children: list,
    );
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: FxText.bodyLarge(
                'UPCOMING FLIGHTS',
                fontWeight: 900,
              )),
          FxSpacing.height(7),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: _buildProductList(),
          ),
        ],
      ),
    );
  }
}
