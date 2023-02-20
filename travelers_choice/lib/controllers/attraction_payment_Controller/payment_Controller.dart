import 'dart:developer';

import '../../services/payment_Service.dart';

class PaymentController {
  Future<bool> PersonalInfo(
      String name,
      String email,
      String phoneNumber,
      String countryId,
      String paymentProcessor,
      List SelectedActivities) async {
    try {
      var data = PaymentService().PersonalInfo(name, email, phoneNumber,
          countryId, paymentProcessor, SelectedActivities);

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
