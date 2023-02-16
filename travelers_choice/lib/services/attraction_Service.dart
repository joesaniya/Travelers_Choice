import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hotel_travel/models/all_attraction_modal.dart';
import 'package:http/http.dart' as http;

import '../models/atteraction_model.dart';

class AttractionService {
//getattraction
  Future<AllattractionModal?> getAllAttraction(context) async {
    try {
      var response = await http.get(
        Uri.parse(
            // 'https://a.walletbot.online/api/v1/attractions/all',
            'https://a.walletbot.online/api/v1/attractions/all?limit=1000'
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
      ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text("Please Select Mr/Ms/Mrs")));
      
      rethrow;
    }
  }

  //search
  Future<AllattractionModal?> getSearchAttraction(place) async {
    try {
      var response = await http.get(
        Uri.parse(
            // 'https: //a.walletbot.online/api/v1/attractions/all?limit=1000&destination=$place'
            'https://a.walletbot.online/api/v1/attractions/all?limit=1000&id=$place'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      // log("search data:${response.body}");

      if (response.statusCode == 200) {
        // log("search data:${response.body}");

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
}
