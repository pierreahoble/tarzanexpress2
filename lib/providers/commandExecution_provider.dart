import 'package:flutter/foundation.dart';

import '../Model/CartItemData.dart';
import '../Model/product.dart';
import '../constants/Api.dart';

class CommandExecution with ChangeNotifier {
  //Si Moyen_Transport = 15 alors le transport est avion si 16 le transport est bateau
  int Moyen_Transport = 2; //je l'initialise a 2
  List<dynamic> liste;
  String pays_nom;
  int validate_commande = 3;

  //type de livraison Agence => 0 , domicile -> 1
  int Type_Livraison = 2;

  int get MoyenTransport => Moyen_Transport;
  int get TypeLivraison => Type_Livraison;
  int get getValidateCommande => validate_commande;
  List<dynamic> get getListe => liste;
  void setMoyenTransport(int value) {
    Moyen_Transport = value;
    notifyListeners();
  }

  void setValidateCommande(int value) {
    validate_commande = value;
    notifyListeners();
  }

  void setTypeLivraison(int value) {
    Type_Livraison = value;
    notifyListeners();
  }

  Future<Map> transportMode(String token) async {
    try {
      final response = await Api.transportMode(token);
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

  sendCommands(
      int commandType,
      int a_livraison,
      int agence,
      String pays,
      String ville,
      String quartier,
      String adresse1,
      String adresse2,
      List<Product> items,
      String token) async {
    try {
      final response = await Api.MakeCommande(commandType, a_livraison, agence, pays, ville, quartier, adresse1, adresse2, items, token);
      return response;
    } catch (err) {
      throw err;
    }
  }

  Future<Map> getCommands(String token) async {
    try {
      final response = await Api.transportMode(token);
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

  Future<Map> getCommandDetails(String token, int id) async {
    try {
      final response = await Api.getCommandsDetail(token, id);
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

  void setListe(List<dynamic> value) {
    liste = value;
    notifyListeners();
  }
}
