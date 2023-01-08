


import 'dart:convert';

import 'package:trevashop_v2/constant.dart';
import 'package:http/http.dart' as http;
import 'package:trevashop_v2/Model/api_response.dart';

ApiResponse apiResponse = ApiResponse();
Future<List<dynamic>>getUserCommands() async {

  var url = await Uri.parse(userCommandsLink);
  String token = await getToken();

   try {
    final response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'bearer $token'
    });
  apiResponse.data=responseResult(response,apiResponse);
  } catch (e) {
    print("Oups");
    apiResponse.message = SomethingWentWrong;
  }
  return apiResponse.data;
}

Future<List<dynamic>>getCommandsDetails(String id) async {

  var url = await Uri.parse(baseUrl+"commande/details/"+id);
  String token = await getToken();

   try {
    final response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'bearer $token'
    });
  apiResponse.data=responseResult(response,apiResponse);
  } catch (e) {
    print("Oups");
    apiResponse.message = SomethingWentWrong;
  }
  return apiResponse.data;
}
Future<List<dynamic>>leftToPay() async {

  var url = await Uri.parse(leftToPayLink);
  String token = await getToken();
   try {
    final response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'bearer $token'
    });
  apiResponse.data=responseResult(response,apiResponse);
  } catch (e) {
    print("Oups");
    apiResponse.message = SomethingWentWrong;
  }
  return apiResponse.data;
}

Future<List<dynamic>>detailsLeft() async {

  var url = await Uri.parse(detailsLeftLink);
  String token = await getToken();
   try {
    final response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'bearer $token'
    });
  apiResponse.data=responseResult(response,apiResponse);
  } catch (e) {
    print("Oups");
    apiResponse.message = SomethingWentWrong;
  }
  return apiResponse.data;
}
