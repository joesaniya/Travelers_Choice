

import '../models/get_reviews.dart';
import '../services/review_Service.dart';

class ReviewAPIController{
   List<GetReview> reviewList = <GetReview>[];
  
  Future<List<GetReview>?> getReviewList(
      {required productid}) async {
    // isCountryListLoading = true;
    try {
      var data =
          await ReviewService().getRevies(productid: productid);
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
}