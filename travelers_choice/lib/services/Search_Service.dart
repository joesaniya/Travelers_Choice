import 'dart:convert';
import 'dart:developer';


import 'package:http/http.dart' as http;

import '../models/search_categories_modal.dart';

class SearchService {
//getattraction
  Future<List<SearchCategoriesModal>?> getCategories() async {
    try {
      var response = await http.get(
        Uri.parse(
            
            'https://a.walletbot.online/api/v1/attractions/categories/all'
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

  

}
