
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/visaModels/create_visa_modal.dart';
import '../models/visaModels/select_visa_modal.dart';
import '../models/visaModels/visa_country_modal.dart';
import 'package:http/http.dart' as http;

import '../models/visaModels/visa_document_model.dart';
import 'package:http_parser/http_parser.dart';


class VisaService{
  late Dio dio;


  Future<List<VisaCountryModal>> getVisaCountry() async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://secure.mytravellerschoice.com/api/v1/visa/all',
        ),
        // headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        log("response${parsed}");
        return parsed.map<VisaCountryModal>((item) => VisaCountryModal.fromJson(item)).toList();

      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }


  Future<SelectVisaModal?> getSelectVisa(String id) async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://secure.mytravellerschoice.com/api/v1/visa/type/all/$id'
        ),
        // headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        log(response.body);
        // SharedPreferences sharedPreferences =
        // await SharedPreferences.getInstance();
        // sharedPreferences.setString(
        //     AppConstants.KEY_ACCESS_TOKEN_CurrenciesList,
        //     jsonEncode(jsondata['currencies']));
        // sharedPreferences.setString("countrycode", countryModalFromJson(response.body).toJson() );

        return selectVisaModalFromJson(response.body);
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }


  Future<CreateVisaApplication> postCreateVisa(

      Map body
      ) async {
    log("bodycheck $body");
    try {
      var response = await http.post(

        Uri.parse(
            'https://secure.mytravellerschoice.com/api/v1/visa/application/create'
        ),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body)
      );

      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        log(response.body);
        // SharedPreferences sharedPreferences =
        // await SharedPreferences.getInstance();
        // sharedPreferences.setString(
        //     AppConstants.KEY_ACCESS_TOKEN_CurrenciesList,
        //     jsonEncode(jsondata['currencies']));
        // sharedPreferences.setString("countrycode", countryModalFromJson(response.body).toJson() );
        log("jsondata$response");

        var createVisaResponse = createVisaApplicationFromJson(response.body);
        return createVisaResponse;
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        return  CreateVisaApplication();
      }
    } catch (e) {
      rethrow;
    }
  }


  Future<VisaDocumentUpload?> postVisaDocumentUpload(

      File image1,
      File image2,
      File image3,
      File image4,
      File image5,
      // String id
      ) async {

    // log("bodycheck $body");
    try {
      // var formData ;
      //
      // var totalFileLength = image.path.split("/").length;
      // // var getFileName = [totalFileLength - 1];
      // var getFileName = image.path.split("/")[totalFileLength - 1];

      var formData;
      var totalFileLength1 = image1.path.split("/").length;
      var getFileName1 = image1.path.split("/")[totalFileLength1 - 1];

      var totalFileLength2 = image2.path.split("/").length;
      var getFileName2 = image1.path.split("/")[totalFileLength2 - 1];

      var totalFileLength3 = image3.path.split("/").length;
      var getFileName3 = image3.path.split("/")[totalFileLength3 - 1];

      var totalFileLength4 = image4.path.split("/").length;
      var getFileName4 = image4.path.split("/")[totalFileLength4 - 1];

      var totalFileLength5 = image5.path.split("/").length;
      var getFileName5 = image5.path.split("/")[totalFileLength5 - 1];

      var dio = Dio();
      formData = FormData.fromMap({
        "passportFistPagePhoto" : await MultipartFile.fromFile(image1.path,filename: getFileName1,contentType: MediaType("image", "jpeg"),),
        "passportLastPagePhoto" : await MultipartFile.fromFile(image2.path,filename: getFileName2,contentType: MediaType("image", "jpeg"),),
        "passportSizePhoto" : await MultipartFile.fromFile(image3.path,filename:  getFileName3,contentType: MediaType("image", "jpeg"),),
        "supportiveDoc1" : await MultipartFile.fromFile(image4.path,filename: getFileName4,contentType: MediaType("image", "jpeg"),),
        "supportiveDoc2": await MultipartFile.fromFile(image5.path,filename: getFileName5,contentType: MediaType("image", "jpeg"),)

      });

      var response = await dio.post(


              'https://secure.mytravellerschoice.com/api/v1/visa/application/document/640c1ab576161cfe732259d0',

          // headers: {'Content-Type': 'application/json'},
          data: formData
      );

      if (response.statusCode == 200) {
        // var jsondata = jsonDecode(response.data);
        // log(response.data);
        // SharedPreferences sharedPreferences =
        // await SharedPreferences.getInstance();
        // sharedPreferences.setString(
        //     AppConstants.KEY_ACCESS_TOKEN_CurrenciesList,
        //     jsonEncode(jsondata['currencies']));
        // sharedPreferences.setString("countrycode", countryModalFromJson(response.body).toJson() );
        log("jsondata$response");

        return visaDocumentUploadFromJson(response.data);
        // return uploadDocuments;
      } else {
        var jsondata = jsonDecode(response.data);
        log(jsondata['error']);
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }


}