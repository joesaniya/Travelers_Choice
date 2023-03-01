import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/get_reviews.dart';

class ReviewService {
  Future<GetReview?> getRevies({required productid}) async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://secure.mytravellerschoice.com/api/v1/attractions/reviews/single/$productid',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application / json'
        },
      );
      if (response.statusCode == 200) {
        log('Review SErvice:${response.body}');
        return GetReview.fromJson(jsonDecode(response.body));
        // detailattractionModalFromJson(response.body);
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future ReviewPost(String place, String title, String description,
      String rating, BuildContext context, String token) async {
    // String basicAuth = token;
    String basicAuth =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2M2ZlMzNjM2RmNGFjYTgzNzM4ODI0MTIiLCJlbWFpbCI6ImFiY2RlMzQxMUBtYWlsLmNvbSIsImlhdCI6MTY3NzYwMzc3OSwiZXhwIjoxNjc4MjA4NTc5fQ.Qb4-NEjy7w2iNR_8SfQEJSTTWKQt0s_e_9eSkBlAVDk";
    try {
      var body = {
        "title": title,
        "description": description,
        "rating": rating,
        "attraction": place
      };

      log('Body Review:${body.toString()}');
      var response = await http.post(
          Uri.parse(
            'https://secure.mytravellerschoice.com/api/v1/attractions/reviews/add',
          ),
          headers: {
            'Content-Type': 'application/json',
            // 'authorization': "Bearer $basicAuth",
            'authorization': "Bearer $basicAuth",
          },
          body: jsonEncode(body));
      log('Body Review1:${response.body}');
      log('sts:${response.statusCode}');
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        print("Review Data => $jsondata");

        return response.body;
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        //snackbar
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(jsondata['error'])));
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
