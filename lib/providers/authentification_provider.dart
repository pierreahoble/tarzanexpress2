import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trevashop_v2/providers/signIn.dart';
import 'package:trevashop_v2/services/shared_preferences.dart';
import 'package:trevashop_v2/services/user_service.dart';
import '../../../services/user_service.dart';

import '../constants/Api.dart';

class AuthentificationProvider with ChangeNotifier {
  String name;
  String lastName;
  String phone;
  String email;
  String token;
  int id;
  Map checkedPhone;
  //Map logInfo;

  initValue() async {
    await SharedPreferencesClass.restore("id").then((value) {
      if (value is int) {
        id = value;
      }
    });

    await SharedPreferencesClass.restore("name").then((value) {
      if (value is String) {
        name = value;
      }
    });
    await SharedPreferencesClass.restore("lastName").then((value) {
      if (value is String) {
        lastName = value;
      }
    });

    await SharedPreferencesClass.restore("token").then((value) {
      if (value is String) {
        token = value;
      }
    });

    await SharedPreferencesClass.restore("email").then((value) {
      if (value is String) {
        email = value;
      }
    });
    await SharedPreferencesClass.restore("phone").then((value) {
      if (value is String) {
        phone = value;
      }
    });
    notifyListeners();
  }

  Future<Map> login(
    String name,
    String password,
  ) async {
    try {
      final response = await Api.login(name, password);
      print(response);
      String validate = response["status"];
      if (validate.toLowerCase() == "success") {
        final data = response["data"];
        notifyListeners();
        return data;
      } else if (validate.toLowerCase() == "error") {
        notifyListeners();
        return {};
      } else {
        notifyListeners();
        return {};
      }
    } catch (err) {
      throw err;
    }
  }

  Future<Map> register({@required Request request}) async {
    try {
      final response = await Api.register(
          request.prenoms,
          request.nom,
          request.password,
          request.email,
          request.phone_number,
          request.pays_id,
          request.code_parrainage,
          request.agree,
          request.password_confirmation);
      print(response);
      // String validate = response["status"];
      if (response["access_token"] != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();

        await preferences.setString('nom', response["user"]['nom']);
        await preferences.setString('prenoms', response["user"]['prenoms']);
        await preferences.setString('email', response["user"]['email']);
        await preferences.setString('number', response["user"]['phone_number']);
        await preferences.setString(
            'code', response["user"]['code_affiliation']['code'] ?? '');

        await preferences.setString('token', response["access_token"]);
        //await preferences.setInt('id', response["user"]["id"] ?? 0);

        notifyListeners();
        return {"success": true};
      } else {
        notifyListeners();
        return {};
      }
    } catch (err) {
      throw err;
    }
  }

  Future<Map> checkPhoneNumber(int pays_id, String phone) async {
    try {
      checkedPhone = await Api.checkNumber(phone, pays_id);
      notifyListeners();
      print(checkedPhone.toString());
      return checkedPhone;
    } catch (err) {
      throw err;
    }
  }

  Future<Map> logout(String token) async {
    try {
      final response = await Api.logout(token);
      print(response);
      String validate = response["status"];
      if (validate.toLowerCase() == "success") {
        final data = response["data"];
        notifyListeners();
        return data;
      } else if (validate.toLowerCase() == "error") {
        notifyListeners();
        return {};
      } else {
        notifyListeners();
        return {};
      }
    } catch (err) {
      throw err;
    }
  }

  Future<Map> FilleulNumber(String token) async {
    try {
      final response = await Api.affiliesCount(token);
      print(response);
      String validate = response["status"];
      if (validate.toLowerCase() == "success") {
        final data = response["data"];
        notifyListeners();
        return data;
      } else if (validate.toLowerCase() == "error") {
        notifyListeners();
        return {};
      } else {
        notifyListeners();
        return {};
      }
    } catch (err) {
      throw err;
    }
  }

  Future<Map> updateUserInfo(
    String id,
    String nom,
    String phone,
    String token,
    String firstName,
    String email,
  ) async {
    try {
      final response =
          await Api.UpdateInfo(id, token, nom, firstName, phone, email);
      String validate = response["status"].toString();

      print(response['user']);
      if (response['status'] == 200) {
        final data = response;
        notifyListeners();
        return data;
      } else if (response['status'] == 400) {
        final data = response;
        notifyListeners();
        return data;
      } else {
        notifyListeners();
        return {};
      }
    } catch (err) {
      // throw err;
      print(err);
    }
  }

  void logoutAndRedirectToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokens = await prefs.getString("token");

    Api.logout(tokens).then((value) {
      notifyListeners();
    });
    await prefs.remove("token");
  }

  Future<Map> changePassword(
      String token, String oldPassword, String newPassword) async {
    try {
      final response =
          await Api.changePassword(token, oldPassword, newPassword);
      // print(response);
      // String validate = response["status"];
      if (response["status"] == 200) {
        final data = response;
        notifyListeners();
        return data;
      } else if (response["status"] == 400) {
        final data = response;
        notifyListeners();
        return data;
      } else {
        notifyListeners();
        return {};
      }
    } catch (err) {
      throw err;
    }
  }
}
