

import 'dart:convert';

import 'package:trevashop_v2/constant.dart';
import 'package:http/http.dart' as http;
import 'package:trevashop_v2/Model/api_response.dart';

ApiResponse apiResponse = ApiResponse();

Future<List<dynamic>> getArticleByType(String type,String token) async {

  var url = await Uri.parse(baseUrl+"articles/"+type);
  

   try {
    final response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    print("responsevalue"+response.toString());
    switch (response.statusCode) {
      case 200:
        apiResponse.data =apiResponse.data as List<dynamic>;
        print(apiResponse.data);
      break;

      case 422:
      apiResponse.data =apiResponse.data as List<dynamic>;
      return apiResponse.data;
      break;

      default:
        apiResponse.message = FectDataError;
        print("Rien ne marche");
    }
  } catch (e) {
    print("Oups");
    apiResponse.message = SomethingWentWrong;
  }
  return apiResponse.data;
}


Future<List<dynamic>> showArticle(String id) async {

  var url = await Uri.parse(baseUrl+"articles/show/"+id);
  String token = await getToken();

   try {
    final response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data =apiResponse.data as List<dynamic>;
        print(apiResponse.data);
      break;
      
      case 422:
      apiResponse.data =apiResponse.data as List<dynamic>;
      return apiResponse.data;
      break;

      default:
        apiResponse.message = FectDataError;
        print("Rien ne marche");
    }
  } catch (e) {
    print("Oups");
    apiResponse.message = SomethingWentWrong;
  }
  return apiResponse.data;
}