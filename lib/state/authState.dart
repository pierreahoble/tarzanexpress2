import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/phoneInput/utils/phone_number.dart';
import '../helper/utils.dart';

import '../constants/appNames.dart';
import '../Model/user.dart';

class AuthState extends ChangeNotifier {
  List<String> _countriesAvailable;
  List get countriesAvailable => _countriesAvailable;
  set countriesAvailable(List value) {
    _countriesAvailable = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> _countriesAvailableMap;
  List<Map<String, dynamic>> get countriesAvailableMap =>
      _countriesAvailableMap;
  set countriesAvailableMap(List<Map<String, dynamic>> value) {
    _countriesAvailableMap = value;
    notifyListeners();
  }

  PhoneNumber _phoneNumber;
  PhoneNumber get phoneNumber => _phoneNumber;
  set phoneNumber(PhoneNumber value) {
    _phoneNumber = value;
    notifyListeners();
  }

  bool _hasCode = false;
  bool get hasCode => _hasCode;
  set hasCode(bool value) {
    _hasCode = value;
    notifyListeners();
  }

  List<String> _paysNamesList = [];
  List<String> get paysNamesList => _paysNamesList;
  set paysNamesList(List<String> value) {
    _paysNamesList = value;
    notifyListeners();
  }

  Future<bool> getCountriesAvailable() async {
    try {
      var uri = Uri.parse(AppNames.hostUrl + AppNames.getCountries);
      var a = Map.from(jsonDecode((await http.get(uri)).body))['pays'];
      List<String> b = [];
      List<String> m = [];
      countriesAvailableMap = [];
      for (var i = 0; i < a.length; i++) {
        Map<String, dynamic> c = new Map<String, dynamic>.from(a[i]);
        countriesAvailableMap.add(c);
        String d = "${c["abr"] as String}";
        String j = "${c["nom"] as String}";
        if (i == 0) {
          alpha2Code = d;
        }
        b.add(d);
        m.add(j);
      }
      countriesAvailable = b;
      paysNamesList = m;
      return true;
    } catch (e) {
      //print("Exception lors du getCountriesAvailable(): $e");
    }
    return false;
  }

  String _telephoneForRecuperation;
  String get telephoneForRecuperation => _telephoneForRecuperation;
  set telephoneForRecuperation(String value) {
    _telephoneForRecuperation = value;
    notifyListeners();
  }

  PhoneNumber _recuperationPhoneNumber;
  PhoneNumber get recuperationPhoneNumber => _recuperationPhoneNumber;
  set recuperationPhoneNumber(PhoneNumber value) {
    _recuperationPhoneNumber = value;
    notifyListeners();
  }

  Future<List> checkExistence({
    @required String numero,
    @required String alpha2Code,
  }) async {
    var response;
    String errorMessage =
        "Une erreur est survenue. Notre équipe est en train de résoudre le problème. Veuillez réessayer plutard.";
    try {
      var uri = Uri.parse(AppNames.hostUrl + AppNames.checkExistence);
      String paysId = "";
      for (var i = 0; i < countriesAvailableMap.length; i++) {
        if (countriesAvailableMap[i]["abr"] == alpha2Code) {
          paysId = countriesAvailableMap[i]["id"].toString();
          paysName = countriesAvailableMap[i]["nom"].toString();
        }
      }
      response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(
            {"phone_number": numero.replaceAll(" ", ""), "pays_id": paysId}),
      );
      //print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');
      if (response.statusCode.toString().startsWith('20')) {
        /* print("On a " +
            (Map.from(jsonDecode(response.body))['state']).toString()); */
        return [
          true,
          Map.from(jsonDecode(response.body))['state'],
        ];
      }
    } catch (e) {
      //print("Exception lors du checkExistence(): $e");
      //errorMessage = "Numéro ou mot de passe invalide !";
    }
    return [
      false,
      errorMessage,
    ];
  }

  Future<List> recoverPassword({
    @required String numero,
    @required String alpha2Code,
    @required String password,
  }) async {
    var response;
    String errorMessage =
        "Une erreur est survenue. Notre équipe est en train de résoudre le problème. Veuillez réessayer plutard.";
    try {
      var uri = Uri.parse(AppNames.hostUrl + AppNames.recoverPassword);
      String paysId = "";
      for (var i = 0; i < countriesAvailableMap.length; i++) {
        if (countriesAvailableMap[i]["abr"] == alpha2Code) {
          paysId = countriesAvailableMap[i]["id"].toString();
          paysName = countriesAvailableMap[i]["nom"].toString();
        }
      }
      /*print("PHONE : " +
          numero.replaceAll(" ", "") +
          "\n" +
          "pays id : " +
          int.parse(paysId).toString() +
          "\nPASSWORD : " +
          password);*/
      response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode({
          "phone_number": numero.replaceAll(" ", ""),
          "pays_id": int.parse(paysId),
          "password": password
        }),
      );
      //print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');
      if (response.statusCode.toString().startsWith('20')) {
        return [
          true,
        ];
      }
    } catch (e) {
      //print("Exception lors du checkExistence(): $e");
    }
    return [
      false,
      errorMessage,
    ];
  }

  String _userId;
  String get userId => _userId;
  set userId(String value) {
    _userId = value;
    notifyListeners();
  }

  String _nom;
  String get nom => _nom;
  set nom(String value) {
    _nom = value;
    notifyListeners();
  }

  String _prenoms;
  String get prenoms => _prenoms;
  set prenoms(String value) {
    _prenoms = value;
    notifyListeners();
  }

  String _email;
  String get email => _email;
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String _paysName;
  String get paysName => _paysName;
  set paysName(String value) {
    _paysName = value;
    notifyListeners();
  }

  String _alpha2Code;
  String get alpha2Code => _alpha2Code;
  set alpha2Code(String value) {
    _alpha2Code = value;
    notifyListeners();
  }

  String _indicatif;
  String get indicatif => _indicatif;
  set indicatif(String value) {
    _indicatif = value;
    notifyListeners();
  }

  String _telephone;
  String get telephone => _telephone;
  set telephone(String value) {
    _telephone = value;
    notifyListeners();
  }

  String _codeParrainage;
  String get codeParrainage => _codeParrainage;
  set codeParrainage(String value) {
    _codeParrainage = value;
    notifyListeners();
  }

  String _password;
  String get password => _password;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String _confirmPassword;
  String get confirmPassword => _confirmPassword;
  set confirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  User _userModel;
  User get userModel => _userModel;

  reformatPhoneNumber(String s) {
    String reponse = "";
    for (var i = 0; i < s.length; i++) {
      String temp = s.substring(i, i + 1);
      if (temp != "+" && temp != " ") {
        reponse += temp;
      }
    }
    //print(reponse);
    return reponse;
  }

  Future<void> storeCredentials({
    @required final response,
    @required String password,
    @required bool isUpdate,
  }) async {
    try {
      final Map<String, dynamic> c =
          new Map<String, dynamic>.from(jsonDecode(response.body));
      //print("isUpdate:" + isUpdate.toString());
      final prefs = await SharedPreferences.getInstance();
      if (!isUpdate) {
        prefs.setBool("isLoggedIn", true);
        prefs.setString("accessToken", c["access_token"] as String);
        prefs.setString("password", password);
        prefs.setInt("id", c["user"]["id"] as int);
        prefs.setString("nom", c["user"]["nom"] as String);
        prefs.setString("prenoms", c["user"]["prenoms"] as String);
        prefs.setString(
            "nomComplet",
            (c["user"]["prenoms"] as String) +
                " " +
                (c["user"]["nom"] as String));
        prefs.setString("telephone", c["user"]["phone_number"] as String);
        if (c['user']['email'] != null)
          prefs.setString("email", c["user"]["email"] as String);
        prefs.setString("agree", c["user"]["agree"] as String);
        prefs.setInt("paysId", c["user"]["pays_id"] as int);
        prefs.setString(
            "indicatif", Map.from(c["user"]["pays"])['indicatif'] as String);
        prefs.setString(
            "nomPays", Map.from(c["user"]["pays"])['nom'] as String);
        prefs.setString(
            "abrPays", Map.from(c["user"]["pays"])['abr'] as String);
        prefs.setInt("paysId", c["user"]["pays_id"] as int);
        prefs.setInt("verification", c["user"]["verification"] as int);
        prefs.setString("createdAt", c["user"]["created_at"] as String);
        prefs.setString("updatedAt", c["user"]["updated_at"] as String);
        prefs.setString(
            "codeParrainage", c["user"]["code_affiliation"]["code"] as String);
      } else {
        prefs.setInt("id", c["id"] as int);
        prefs.setString("nom", c["nom"] as String);
        prefs.setString("prenoms", c["prenoms"] as String);
        prefs.setString("nomComplet",
            (c["prenoms"] as String) + " " + (c["nom"] as String));
        prefs.setString("telephone", c["phone_number"] as String);
        prefs.setString("email", c["email"] as String);
        prefs.setString("agree", c["agree"] as String);
        prefs.setString(
            "indicatif", Map.from(c["pays"])['indicatif'] as String);
        prefs.setString("nomPays", Map.from(c["pays"])['nom'] as String);
        prefs.setString("abrPays", Map.from(c["pays"])['abr'] as String);
        prefs.setInt("paysId", c["pays_id"] as int);
        prefs.setInt("verification", c["verification"] as int);
        prefs.setString("createdAt", c["created_at"] as String);
        prefs.setString("updatedAt", c["updated_at"] as String);
      }
    } catch (e) {
      //print("Exception lors du storeCredentials: $e");
    }
  }

  Future<List> signIn({
    @required String yPhoneNumber,
    @required String yPassword,
  }) async {
    var response;
    String errorMessage;
    try {
      var uri = Uri.parse(AppNames.hostUrl + AppNames.signIn);
      /* print("phone_number : " +
          telephone.replaceAll(" ", "") +
          "\npassword : " +
          password); */
      response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode({
          "phone_number": "${yPhoneNumber ?? telephone.replaceAll(" ", "")}",
          "password": "${yPassword ?? password}"
        }),
      );
      //print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');
      if (response.statusCode == 401) {
        errorMessage = "Numéro ou mot de passe invalide !";
      }
      if (response.statusCode.toString().startsWith('20')) {
        await storeCredentials(
            isUpdate: false,
            response: response,
            password: yPassword ?? password);
        return [true];
      }
    } catch (e) {
      //print("Exception lors du signIn(): $e");
    }
    return [false, errorMessage];
  }

  Future<List> signUp() async {
    var response;
    String errorMessage;
    bool success = false;
    try {
      var uri = Uri.parse(AppNames.hostUrl + AppNames.signUp);
      String paysId = "";
      for (var i = 0; i < countriesAvailableMap.length; i++) {
        if (countriesAvailableMap[i]["abr"] == alpha2Code) {
          paysId = countriesAvailableMap[i]["id"].toString();
          paysName = countriesAvailableMap[i]["nom"].toString();
        }
      }
      response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode({
          "phone_number": telephone.replaceAll(" ", ""),
          "password": password,
          "pays_id": paysId,
          "agree": "on",
          "email": email,
          "password_confirmation": confirmPassword,
          "nom": nom,
          "prenoms": prenoms,
          "code_parrainage": codeParrainage
        }),
      );
      codeParrainage = null;
      //print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');
      if (response.statusCode.toString().startsWith("20")) {
        /* await storeCredentials(
            isUpdate: false, response: response, password: password); */
        success = true;
      } else {
        success = false;
        var errors = (Map.from(jsonDecode(response.body)))["errors"];
        if (errors["email"] != null && errors["email"] != 'null') {
          errorMessage = "L'email utilisé est déjà enregistré!";
          return [success, errorMessage];
        }
        if (errors["phone_number"] != null &&
            errors["phone_number"] != 'null') {
          errorMessage = "Le numéro de téléphone utilisé est déjà enregistré!";
          return [success, errorMessage];
        }
        if (errors["code_parrainage"] != null &&
            errors["code_parrainage"] != 'null') {
          errorMessage = "Le code de parrainage est invalide";
          return [success, errorMessage];
        }
      }
    } catch (e) {
      //print("Exception lors du signUp(): $e");
      success = false;
    }
    return [success, errorMessage];
  }

  Future<List> updateProfile({
    @required String nom,
    @required String prenoms,
    @required String phoneNumber,
    @required String email,
    @required BuildContext context,
  }) async {
    var response;
    int uId = (await SharedPreferences.getInstance()).getInt("id");
    try {
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      var uri = Uri.parse(AppNames.hostUrl + AppNames.updateProfile + "$uId");
      response = await http.put(
        uri,
        headers: {
          'Authorization': "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode({
          "nom": nom,
          "prenoms": prenoms,
          "phone_number": phoneNumber,
          "email": email
        }),
      );
      //print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        await storeCredentials(
            isUpdate: true, response: response, password: password);
        return [true];
      }
    } catch (e) {
      //print("Exception lors du updateUser(): $e");
    }
    return [false, "Un erreur est survenue"];
  }


  Future<bool> changePassword({
    @required String oldPassword,
    @required String newPassword,
    @required String token,
    @required BuildContext context,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      var uri = Uri.parse(AppNames.hostUrl + AppNames.changePassword);
      var response = await http.put(
        uri,
        headers: {
          'Authorization': "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json
            .encode({'old_password': oldPassword, 'new_password': newPassword}),
      );
      //print('Response status: ${response.statusCode}');
      print(response.body);
      // print('Response body: ${response.body}');
      if (response.statusCode.toString().startsWith('20')) {
        await prefs.setString('password', newPassword);
        return true;
      }
    } catch (e) {
      //print("Exception lors du changePassword(): $e");
    }
    return false;
  }

  Future<List> countFilleul({@required BuildContext context}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      var uri = Uri.parse(AppNames.hostUrl + AppNames.countFilleuls);
      var response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          'Authorization': "Bearer $token",
          "Accept": "application/json"
        },
      );
      //print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return [
          true,
          (Map.from(jsonDecode(response.body)))["nombre_affilies"],
        ];
      }
    } catch (e) {
      //print("Exception lors du countFilleul(): $e");
    }
    return [false];
  }

  clear() {
    countriesAvailable = null;
    countriesAvailableMap = null;
    phoneNumber = null;
    hasCode = false;
    userId = null;
    nom = null;
    prenoms = null;
    email = null;
    paysName = null;
    paysNamesList = [];
    alpha2Code = null;
    indicatif = null;
    telephone = null;
    codeParrainage = null;
    password = null;
    confirmPassword = null;
    telephoneForRecuperation = null;
    recuperationPhoneNumber = null;
  }
}
