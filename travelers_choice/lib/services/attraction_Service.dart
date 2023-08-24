import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hotel_travel/models/all_attraction_modal.dart';
import 'package:http/http.dart' as http;

import '../card_widgets/customsnackbar.dart';
import '../models/atteraction_model.dart';

import '../models/best_top_model.dart';
import '../models/order_attraction_modal.dart';

class AttractionService {
//getattraction
  Future<AllattractionModal?> getAllAttraction(context) async {
    try {
      var response = await http.get(
        Uri.parse(
            // 'https://a.walletbot.online/api/v1/attractions/all',
            'https://secure.mytravellerschoice.com/api/v1/attractions/all?limit=1000'
            //
            ),
        headers: {
          'Content-Type': 'application/json',
        },
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
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(e.toString())));
      CustomSnackbar.show(
        context: context,
        message: e.toString(),
        backgroundColor: const Color(0xff1529e8),
        duration: const Duration(seconds: 2),
      );

      rethrow;
    }
  }

  //search
  Future<AllattractionModal?> getSearchAttraction(place) async {
    log('message att:$place');
    try {
      var response = await http.get(
        Uri.parse(
            // 'https: //a.walletbot.online/api/v1/attractions/all?limit=1000&destination=$place'
            // 'https://secure.mytravellerschoice.com/api/v1/attractions/all?limit=1000&id=$place'
            'https://secure.mytravellerschoice.com/api/v1/attractions/all?limit=1000&destination=$place'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      // log("search data:${response.body}");

      if (response.statusCode == 200) {
        log("search data:${response.body}");

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
      {required productid,required productslug}) async {
    try {
      var response = await http.get(
        // Uri.parse(
        //   'https://secure.mytravellerschoice.com/api/v1/attractions/single/$productid',
        // ),
         Uri.parse(
          'https://secure.mytravellerschoice.com/api/v1/attractions/single/$productslug',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application / json'
        },
      );
      if (response.statusCode == 200) {
        log(response.body);
        return DetailattractionModal.fromJson(jsonDecode(response.body));
        // detailattractionModalFromJson(response.body);
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

  Future<AllAttractionOrders?> getAttractionOrders(
      String token, context) async {
    try {
      var response = await http.get(
        Uri.parse(
            'https://secure.mytravellerschoice.com/api/v1/attractions/orders/all'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        log(response.body);

        return allAttractionOrdersFromJson(response.body);
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        CustomSnackbar.show(
          context: context,
          message: jsondata['error'],
          backgroundColor: const Color(0xff1529e8),
          duration: const Duration(seconds: 2),
        );
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(jsondata['error'])));
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }


  //top
  Future<BestTopModel?> getTopBest(context) async {
    try {
      var response = await http.get(
        Uri.parse(
            'https://cdn.mytravellerschoice.com/api/v1/home'
            // 'https://secure.mytravellerschoice.com/api/v1/attractions/all?limit=1000'
            
            ),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        log(response.body);

        return bestTopModelFromJson(response.body);
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        return null;
      }
    } catch (e) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(e.toString())));
      CustomSnackbar.show(
        context: context,
        message: e.toString(),
        backgroundColor: const Color(0xff1529e8),
        duration: const Duration(seconds: 2),
      );

      rethrow;
    }
  }
}
