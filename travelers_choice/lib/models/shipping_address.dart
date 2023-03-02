import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ShippingAddress {
  String name;
  bool isDefault;
  IconData icon;

  ShippingAddress(this.name, this.isDefault, this.icon);

  static List<ShippingAddress> shipping() {
    List<ShippingAddress> list = [];

    list.add(ShippingAddress('ccavenue', false, FeatherIcons.home));
    list.add(ShippingAddress('Razorpay', true, FeatherIcons.briefcase));
    return list;
  }
}
