import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trevashop_v2/Model/user.dart';
import 'package:trevashop_v2/services/shared_preferences.dart';

import 'authentification_provider.dart';

class SignIn extends ChangeNotifier {
  Request request = Request();
  AuthentificationProvider prov = AuthentificationProvider();
  String nom, prenoms, mail, number;

  Request get getRequest => request;
  String get getNom => nom;
  String get getPrenoms => prenoms;
  String get getMail => mail;
  String get getNumber => number;

  void first_validation(
    String nom,
    String prenoms,
    String email,
  ) {
    print("bon");
    request.saveFirstScreenData(nom, prenoms, email);
    notifyListeners();
  }

  void second_validation(String phone) {
    request.saveSecondScreenData(phone);
    notifyListeners();
  }

  void third_validation(String password, String passwordConf) {
    request.saveThirdScreenData(password, passwordConf);
    notifyListeners();
  }

  void setCodeParainnage(String code) {
    request.setCodeParain(code);
    notifyListeners();
  }

  storeUserEmail(String email) {
    mail = email;
    notifyListeners();
  }

//stocker les informations de l'utilisateur a la connexion
  Future<dynamic> register() async {
    await prov.register(request: this.request).then((value) {
      print("value " + value.toString());
      return value;
    });
  }
}

class Request extends ChangeNotifier {
  String nom;
  String prenoms;
  String email;
  String password;
  String password_confirmation;
  String phone_number;
  int pays_id;
  String agree;
  String code_parrainage;
  Request(
      {this.nom,
      this.prenoms,
      this.email,
      this.password,
      this.password_confirmation,
      this.phone_number,
      this.pays_id,
      this.agree,
      this.code_parrainage});

  void saveFirstScreenData(
    String nom,
    String prenoms,
    String email,
  ) {
    this.nom = nom;
    this.prenoms = prenoms;
    this.email = email;
    this.password = password;
    this.password_confirmation = password_confirmation;
    notifyListeners();
  }

  void saveSecondScreenData(String phone) {
    this.phone_number = phone;
    notifyListeners();
    //this.agree="on";
    this.pays_id = 1;
    notifyListeners();
  }

  void saveThirdScreenData(String password, String passwordConf) {
    this.password = password;
    this.password_confirmation = passwordConf;

    this.agree = "on";
  }

  void setCodeParain(String code) {
    this.code_parrainage = code;
  }
}
