import 'package:flutter/material.dart';

class AddCityWidgets extends StatefulWidget {
   final int index;
  const AddCityWidgets({ required this.index});

  @override
  State<AddCityWidgets> createState() => _AddCityWidgetsState();
}

class _AddCityWidgetsState extends State<AddCityWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      color: Colors.red,
    );
  }
}