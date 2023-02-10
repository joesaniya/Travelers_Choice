import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/all_attraction_modal.dart';
import '../models/search_categories_modal.dart';

class SearchService {
//getattraction
  Future<List<SearchCategoriesModal>?> getCategories() async {
    try {
      var response = await http.get(
        Uri.parse('https://a.walletbot.online/api/v1/attractions/categories/all'
            //
            ),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        log(response.body);

        return searchCategoriesModalFromJson(response.body);
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  //categorySheet<
  Future<AllattractionModal?> getAllAttraction(place, categoryid) async {
    try {
      var response = await http.get(
        Uri.parse(
            'https://a.walletbot.online/api/v1/attractions/all?search=$place&limit=1000&destination=$place&category=$categoryid'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        log("https://a.walletbot.online/api/v1/attractions/all?search=$place&limit=1000&destination=$place&category=$categoryid"
            "Category LIst          ${response.body}");

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
}
