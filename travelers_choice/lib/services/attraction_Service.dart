import 'dart:convert';
import 'dart:developer';

import 'package:hotel_travel/models/all_attraction_modal.dart';
import 'package:http/http.dart' as http;

import '../models/atteraction_model.dart';

class AttractionService {
//getattraction
  Future<AllattractionModal?> getAllAttraction() async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://a.walletbot.online/api/v1/attractions/all',
        ),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        log(response.body);
        return allattractionModalFromJson(response.body);
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  // //detailAttraction

  Future<DetailattractionModal?> getdetailAttraction(
      {required productid}) async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://a.walletbot.online/api/v1/attractions/single/$productid',
        ),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        log(response.body);
        return detailattractionModalFromJson(response.body);
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        return null;
      }
    } catch (e) {
      rethrow;
    }

    // Future<DetailattractionModal?> getdetailAttraction() async {
    //   try {
    //     var response = await http.get(
    //       Uri.parse(
    //         'https://a.walletbot.online/api/v1/attractions/single/63afca1b5896ed6d0f297449',
    //         // 'https://a.walletbot.online/api/v1/attractions/single/${id}',
    //       ),
    //       headers: {'Content-Type': 'application/json'},
    //     );
    //     if (response.statusCode == 200) {
    //       log(response.body);
    //       return detailattractionModalFromJson(response.body);
    //     } else {
    //       var jsondata = jsonDecode(response.body);
    //       log(jsondata['error']);
    //       return null;
    //     }
    //   } catch (e) {
    //     rethrow;
    //   }
  }
}
