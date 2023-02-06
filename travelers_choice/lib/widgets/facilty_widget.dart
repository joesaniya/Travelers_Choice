import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class FacityWidget extends StatelessWidget {
  final IconData iconData;
  final String text;
  const FacityWidget({Key? key, required this.iconData, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return FxContainer.bordered(
      height: 90,
      width: 150,
      margin: const EdgeInsets.only(left: 8, right: 8),
      // padding: const EdgeInsets.only(top: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Center(
        child: Column(
          children: <Widget>[
            Icon(
              iconData,
              color: theme.colorScheme.primary,
              size: 28,
            ),
            Container(
              // height: 20,
              // width: MediaQuery.of(context).size.width,
              // color: Colors.yellow,
              margin: const EdgeInsets.only(top: 8),
              child: Center(
                child: FxText.bodySmall(text,
                    letterSpacing: 0,
                    fontWeight: 600,
                    color: theme.colorScheme.onBackground),
              ),
            )
            // Container(
            //   margin: const EdgeInsets.only(top: 8),
            //   child: FxText.bodySmall(text,
            //       letterSpacing: 0,
            //       fontWeight: 600,
            //       color: theme.colorScheme.onBackground),
            // )
          ],
        ),
      ),
    );
  }
}
