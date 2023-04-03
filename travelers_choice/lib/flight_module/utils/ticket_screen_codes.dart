import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'app_styles.dart';


class dash_lines_code extends StatelessWidget {
  const dash_lines_code({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 12,
        width: 50,
        // color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: Colors.white),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: List.generate(
                  (constraints.constrainWidth() / 15).floor(),
                  (index) => SizedBox(
                        height: 1,
                        width: 5,
                        child: DecoratedBox(
                          decoration:
                              BoxDecoration(color: Colors.grey.shade300),
                        ),
                      )),
            );
          },
        ));
  }
}

class ticket_code extends StatelessWidget {
  final String bigtext1;
  final String smalltext1;
  final String bigtext2;
  final String smalltext2;
  ticket_code(
      {required this.bigtext1,
      required this.smalltext1,
      required this.bigtext2,
      required this.smalltext2});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bigtext1,
                style: Styles.headlinestyle3,
              ),
              Gap(5),
              Text(
                smalltext1,
                style: Styles.headlinestyle4,
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                bigtext2,
                style: Styles.headlinestyle3,
              ),
              Text(
                smalltext2,
                style: Styles.headlinestyle4,
              )
            ],
          )
        ],
      ),
    );
  }
}
