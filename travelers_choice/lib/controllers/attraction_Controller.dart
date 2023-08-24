import 'dart:developer';

import 'package:hotel_travel/models/all_attraction_modal.dart';
import 'package:hotel_travel/services/Search_Service.dart';
import '../models/atteraction_model.dart';

import '../models/best_top_model.dart';
import '../models/search_categories_modal.dart';
import '../services/attraction_Service.dart';

class AttractionController {
  //allattractions
  List<AllattractionModal> allattractionList = <AllattractionModal>[];
  bool isAllAttractionListLoading = true;
  Future<AllattractionModal?> getAllattractionList(context) async {
    // isCountryListLoading = true;
    try {
      var data = await AttractionService().getAllAttraction(context);
      allattractionList.clear();
      if (data != null) {
        allattractionList.add(data);
        // isCountryListLoading = false;
        return data; //removed true
      } else {
        return null; //falseremoved
      }
    } catch (e) {
      rethrow;
    }
  }

  //search

  Future<AllattractionModal?> getSearchattractionList(place) async {
    // isCountryListLoading = true;
    try {
      var data = await AttractionService().getSearchAttraction(place);
      allattractionList.clear();
      if (data != null) {
        log('controllergetsearch');
        allattractionList.add(data);
        // isCountryListLoading = false;

        return data; //removed true
      } else {
        log('null data');
        return null; //falseremoved
      }
    } catch (e) {
      rethrow;
    }
  }

  //searchcattegories

  //detailAttractions
  List<DetailattractionModal> detailattractionList = <DetailattractionModal>[];
  bool isdetailAttractionListLoading = true;
  Future<List<DetailattractionModal>?> getDetailattractionList(
      {required productid, required productslug}) async {
    // isCountryListLoading = true;
    try {
      // var data =
      //     await AttractionService().getdetailAttraction(productid: productid);
      var data = await AttractionService()
          .getdetailAttraction(productid: productid, productslug: productslug);
      detailattractionList.clear();
      if (data != null) {
        detailattractionList.add(data);
        // isCountryListLoading = false;
        return detailattractionList;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  //getCategories
  List<List<SearchCategoriesModal>?> categoriesList =
      <List<SearchCategoriesModal>?>[];
  bool isAllCategoriesListLoading = true;
  Future<List<SearchCategoriesModal>?> getAllcategoriesList() async {
    // isCountryListLoading = true;
    try {
      var data = await SearchService().getCategories();
      categoriesList.clear();
      if (data != null) {
        categoriesList.add(data);
        // isCountryListLoading = false;
        return data; //removed true
      } else {
        return null; //falseremoved
      }
    } catch (e) {
      rethrow;
    }
  }


  //bestop
  List<BestTopModel> bestTopList = <BestTopModel>[];
  bool isbestTopListLoading = true;
  Future<BestTopModel?> getTopBestattractionList(context) async {
    // isCountryListLoading = true;
    try {
      var data = await AttractionService().getTopBest(context);
      bestTopList.clear();
      if (data != null) {
        bestTopList.add(data);
        // isCountryListLoading = false;
        return data; //removed true
      } else {
        return null; //falseremoved
      }
    } catch (e) {
      rethrow;
    }
  }
}
