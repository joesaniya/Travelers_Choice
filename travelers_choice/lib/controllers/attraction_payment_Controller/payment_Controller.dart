import 'dart:developer';

import 'package:flutter/material.dart';

import '../../services/payment_Service.dart';

class PaymentController {
  Future<bool> PersonalInfo(
      String name,
      String email,
      String phoneNumber,
      String countryId,
      String paymentProcessor,
      List SelectedActivities,
       BuildContext context) async {
    try {
      var data = PaymentService().PersonalInformation(name, email, phoneNumber,
          countryId, paymentProcessor, SelectedActivities,context);

      if (data != null) {
        log('Payment Data:${data.toString()}');

        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
