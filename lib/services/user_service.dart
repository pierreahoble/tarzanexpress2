import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:trevashop_v2/Model/api_response.dart';
import 'package:trevashop_v2/Model/user.dart';
import 'package:trevashop_v2/constant.dart';

Future<ApiResponse> Register(
    String nom,
    String prenoms,
    String email,
    String password,
    String password_confirmation,
    String phone_number,
    int pays_id,
    bool agree,
    String code_parrainage) async {
  final url = Uri.parse(resgisterUrl);
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(url, headers: headers, body: {
      'phone_number': phone_number,
      'password': password,
      'pays_id': pays_id,
      'agree': agree,
      'email': email,
      'password_confirmation': password_confirmation,
      'nom': nom,
      'prenom': prenoms,
      'code_parrainage': code_parrainage
    });

    apiResponse = await returnResponse(response);
  } catch (e) {
    apiResponse.message = serverError;
  }

  return apiResponse;
}

//login
Future<ApiResponse> login(String number, String password) async {
  ApiResponse apiResponse = ApiResponse();
  final url = Uri.parse(loginUrl);
  try {
    print(url);
    print(number);
    final response = await http.post(url,
        headers: headers, body: {'phone_number': number, 'password': password});
        print("status code " + response.toString());

    apiResponse = await returnResponse(response);
  } catch (e) {
    apiResponse.message = "Il semble que quelque chose ne va pas , Veuillez résseyer plus tard";
  }
  return apiResponse;
}

Future<ApiResponse> returnResponse(http.Response response) async {
  ApiResponse apiResponse = ApiResponse();
  print("status code " + response.statusCode.toString());
  switch (response.statusCode) {
    case 200:
      print("ca marche ");
      apiResponse.data = User.fromJson(jsonDecode(response.body));

      break;
    case 422:
      final errors = jsonDecode(response.body)['errors'];
      apiResponse.message = errors[errors.keys.elementAt(0)[0]];
      break;
      break;
    case 401:
    case 403:
      apiResponse.message = UnAuthorized;
      break;
    case 500:
      apiResponse.message = SomethingWentWrong;
      break;
    default:
      apiResponse.message = FectDataError + '${response.statusCode}';
  }

  return apiResponse;
}

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}
