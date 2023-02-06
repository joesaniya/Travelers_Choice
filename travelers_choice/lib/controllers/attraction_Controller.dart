import 'package:hotel_travel/models/all_attraction_modal.dart';
import '../models/atteraction_model.dart';

import '../services/attraction_Service.dart';

class AttractionController {
  //allattractions
  List<AllattractionModal> allattractionList = <AllattractionModal>[];
  bool isAllAttractionListLoading = true;
  Future<AllattractionModal?> getAllattractionList() async {
    // isCountryListLoading = true;
    try {
      var data = await AttractionService().getAllAttraction();
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

  //detailAttractions
  List<DetailattractionModal> detailattractionList = <DetailattractionModal>[];
  bool isdetailAttractionListLoading = true;
  Future<List<DetailattractionModal>?> getDetailattractionList(
      {required productid}) async {
    // isCountryListLoading = true;
    try {
      var data =
          await AttractionService().getdetailAttraction(productid: productid);
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
}
