import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/get_reviews.dart';
import '../services/review_Service.dart';

class ReviewAPIController {
  List<GetReview> reviewList = <GetReview>[];

  Future<List<GetReview>?> getReviewList({required productid}) async {
    // isCountryListLoading = true;
    try {
      var data = await ReviewService().getRevies(productid: productid);
      reviewList.clear();
      if (data != null) {
        reviewList.add(data);
        // isCountryListLoading = false;
        return reviewList;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  //post
  Future<bool> postReview(String place, String title, String description,
      String rating, BuildContext context, String token) async {
    try {
      var data = await ReviewService()
          .ReviewPost(place, title, description, rating, context, token);
      if (data != null) {
        log(data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
