import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../../theme/app_theme.dart';
import '../../theme/custom_theme.dart';
import '../controller/flight_list_controller.dart';

class FlightDetailChip extends StatefulWidget {
  final IconData iconData;
  final String label;
  FlightDetailChip(this.iconData, this.label);

  @override
  State<FlightDetailChip> createState() => _FlightDetailChipState();
}

class _FlightDetailChipState extends State<FlightDetailChip>
    with TickerProviderStateMixin {
  late CustomTheme customTheme;
  late ThemeData theme, theme1;
  late FlightListController controller;

  double? customwidth;

  @override
  void initState() {
    super.initState();

    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    controller = FxControllerStore.put(FlightListController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<FlightListController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    return RawChip(
      label: Text(widget.label),
      labelStyle: TextStyle(color: Colors.black, fontSize: 14.0),
      backgroundColor: Colors.amber,
      avatar: Icon(
       widget. iconData,
        size: 14.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    );
  }
}
