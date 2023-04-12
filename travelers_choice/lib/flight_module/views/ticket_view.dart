import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../utils/app_layout.dart';
import '../utils/app_styles.dart';
import '../widgets/circula_container.dart';

class TicketView extends StatelessWidget {
  TicketView({required this.ticket_map, this.iscolorful});
  final Map<String, dynamic> ticket_map;
  final bool? iscolorful;
  @override
  Widget build(BuildContext context) {
    final size = Applayout.getsize(context);
    return SizedBox(
      width: size.width * 0.85,
      height: 169,
      child: Container(
        margin: EdgeInsets.only(left: 16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(21),
                      topRight: Radius.circular(21)),
                  color: iscolorful == null ? Color(0xFF526799) : Colors.white),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "${ticket_map["from"]["code"]}",
                        style: iscolorful == null
                            ? Styles.headlinestyle3
                                .copyWith(color: Colors.white)
                            : Styles.headlinestyle3,
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
                                        (constraints.constrainWidth() / 6)
                                            .floor(),
                                        (index) => Text(
                                              "-",
                                              style: TextStyle(
                                                  color: iscolorful == null
                                                      ? Colors.white
                                                      : Colors.grey.shade300),
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
                                    ? Colors.white
                                    : Color(0xFF8ACCF7),
                              ),
                            ),
                          ),
                        ],
                      )),
                      CircularContainer(
                        iscolorful: true,
                      ),
                      Spacer(),
                      Text(
                        "${ticket_map["to"]["code"]}",
                        style: iscolorful == null
                            ? Styles.headlinestyle3
                                .copyWith(color: Colors.white)
                            : Styles.headlinestyle3,
                      )
                    ],
                  ),
                  Gap(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${ticket_map["from"]["name"]}",
                        style: iscolorful == null
                            ? Styles.headlinestyle4
                                .copyWith(color: Colors.white)
                            : Styles.headlinestyle4,
                      ),
                      Text(
                        "${ticket_map["flying_time"]}",
                        style: iscolorful == null
                            ? Styles.headlinestyle4
                                .copyWith(color: Colors.white)
                            : Styles.headlinestyle4,
                      ),
                      Text(
                        "${ticket_map["to"]["name"]}",
                        style: iscolorful == null
                            ? Styles.headlinestyle4
                                .copyWith(color: Colors.white)
                            : Styles.headlinestyle4,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              color: iscolorful == null ? Styles.orangecolor : Colors.white,
              child: Row(
                children: [
                  SizedBox(
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
                    padding: EdgeInsets.all(6),
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              (constraints.constrainWidth() / 15).floor(),
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
                  SizedBox(
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
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: iscolorful == null
                          ? Radius.circular(21)
                          : Radius.circular(0),
                      bottomRight: iscolorful == null
                          ? Radius.circular(21)
                          : Radius.circular(0)),
                  color:
                      iscolorful == null ? Styles.orangecolor : Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "${ticket_map["date"]}",
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
                      Text("${ticket_map["departure_time"]}",
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
                      Text("${ticket_map["number"]}",
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
    );
  }
}
