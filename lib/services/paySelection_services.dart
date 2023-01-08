import 'dart:convert';

import 'package:trevashop_v2/Model/agences.dart';
import 'package:trevashop_v2/Model/api_response.dart';
import 'package:trevashop_v2/Model/pays.dart';
import 'package:trevashop_v2/Model/ville.dart';

import 'package:trevashop_v2/constant.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getCountries() async {
  var url = await Uri.parse(paysUrl);
  String token = await getToken();
  ApiResponse apiResponse = ApiResponse();
  try {
    print(url);
    final response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    print(response.toString());
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        apiResponse.data =
            jsonDecode(response.body).map((p) => Pays.fromJson(p)).toList();
        apiResponse.data as List<dynamic>;

        break;

      default:
        apiResponse.message = FectDataError;
    }
  } catch (e) {
    apiResponse.message = SomethingWentWrong;
  }
  /*for (var item in apiResponse.data) {
          print(item.nom);
        }*/

  return apiResponse.data;
}

Future<List<dynamic>> getCities(String pays_id) async {
  String countriesUrl = baseUrl + "pays/$pays_id/villes";
  print(countriesUrl);
  var url = await Uri.parse(countriesUrl);
  String token = await getToken();
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data =
            jsonDecode(response.body).map((p) => Ville.fromJson(p)).toList();
        apiResponse.data as List<dynamic>;

        print(apiResponse.data);
        break;
      default:
        apiResponse.message = FectDataError;
    }
  } catch (e) {
    apiResponse.message = SomethingWentWrong;
  }

  return apiResponse.data;
}

Future<List<dynamic>> getAgences(String ville_id) async {
  String agencesUrl = baseUrl + "villes/$ville_id/agences";
  print(agencesUrl);
  var url = await Uri.parse(agencesUrl);
  String token = await getToken();
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        apiResponse.data =
            jsonDecode(response.body).map((p) => Agence.fromJson(p)).toList();
        apiResponse.data as List<dynamic>;

        print(apiResponse.data);
        break;
      default:
        apiResponse.message = FectDataError;
    }
  } catch (e) {
    apiResponse.message = SomethingWentWrong;
  }

  return apiResponse.data;
}
