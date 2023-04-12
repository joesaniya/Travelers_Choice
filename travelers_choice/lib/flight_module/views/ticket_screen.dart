import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hotel_travel/flight_module/views/ticket_view.dart';

import '../utils/app_info_list.dart';
import '../utils/app_layout.dart';
import '../utils/app_styles.dart';
import '../utils/ticket_screen_codes.dart';


class Ticket_screen extends StatelessWidget {
  // const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Applayout.getsize(context);
    return Scaffold(
        backgroundColor: Styles.bgcolor,
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: Applayout.getwidth(20),
                  vertical: Applayout.getheight(20)),
              children: [
                Gap(40),
                Text("Tickets",
                    style: Styles.headlinestyle1.copyWith(fontSize: 35)),
                Gap(15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xFFF4F6FD),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        width: size.width * 0.44,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                        child: Center(
                          child: Text(
                            "Upcoming",
                            style: Styles.textStyle
                                .copyWith(color: Colors.black54),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.41,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                        ),
                        child: Center(
                          child: Text(
                            "Privious",
                            style: Styles.textStyle
                                .copyWith(color: Colors.black54),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(20),
                Container(
                  padding: EdgeInsets.only(right: 15),
                  child: TicketView(
                    ticket_map: ticketList[0],
                    iscolorful: true,
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                ticket_code(
                  bigtext1: "Flutter Dash",
                  smalltext1: "Passenger",
                  bigtext2: "5456775433",
                  smalltext2: "Passport",
                ),
                Container(
                    height: 10,
                    width: 50,
                    // color: Colors.white,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(color: Colors.white),
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Flex(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          direction: Axis.horizontal,
                          children: List.generate(
                              (constraints.constrainWidth() / 15).floor(),
                              (index) => SizedBox(
                                    height: 1,
                                    width: 5,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300),
                                    ),
                                  )),
                        );
                      },
                    )),
                ticket_code(
                  bigtext1: "0055 9887 6554",
                  smalltext1: "Number of  E-tickets",
                  bigtext2: "B2SJ28",
                  smalltext2: "Booking code",
                ),
                dash_lines_code(),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/visa.png"))),
                              ),
                              Text(
                                "***2462",
                                style: Styles.headlinestyle3,
                              )
                            ],
                          ),
                          Gap(5),
                          Text(
                            "Payment Method",
                            style: Styles.headlinestyle4,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$249.99",
                            style: Styles.headlinestyle3,
                          ),
                          Text(
                            "Price",
                            style: Styles.headlinestyle4,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Container(
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(50)

                          ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        // child: BarcodeWidget(
                        //   height: 70,
                        //   barcode: Barcode.code128(),
                        //   data:
                        //       'https://www.linkedin.com/in/abhishek-bhadane-124b13209/',
                        //   drawText: false,
                        // ),
                      ),
                    )),
                Gap(20),
                Container(
                  padding: EdgeInsets.only(right: 20, left: 10),
                  child: TicketView(ticket_map: ticketList[0]),
                )
              ],
            ),
            Positioned(
              left: 25,
              top: 300,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, border: Border.all(width: 2)),
                child: CircleAvatar(
                  maxRadius: 4,
                  backgroundColor: Colors.black,
                ),
              ),
            ),
            Positioned(
              right: 25,
              top: 300,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, border: Border.all(width: 2)),
                child: CircleAvatar(
                  maxRadius: 4,
                  backgroundColor: Colors.black,
                ),
              ),
            )
          ],
        ));
  }
}
