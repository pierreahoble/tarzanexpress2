import 'package:flutter/foundation.dart';

import '../constants/Api.dart';

class TransactionProvider with ChangeNotifier {
  Future<Map> getPortefeuilleAll(String token) async {
    try {
      final response = await Api.historicPortefeuille(token);
      print(response);
      // String validate = response["status"];
      if (response['status'] == 200) {
        // print(response["montant"]);
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

  Future<Map> getMontantValeur(String token, String id, String arg) async {
    try {
      final response = await Api.payerValeur(token, id, arg);
      // print(response);
      // String validate = response["status"];
      if (response["status"] == 200) {
        // print(response["montant"]);
        final data = response;
        notifyListeners();
        return data;
      } else if (response["status"] == 401) {
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

  Future<Map> ModePaiement(String token) async {
    try {
      final response = await Api.modeAll(token);
      print(response);
      // String validate = response["status"];
      if (response['status'] == 200) {
        // print(response["montant"]);
        final data = response;
        notifyListeners();
        return data;
      } else if (response['status'] == 401) {
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

//Passer a la caisse
  Future<Map> payement(String token, String network, String montant,
      String phone_number, String cmd_id, String password) async {
    try {
      final response = await Api.payCommande(
          token, network, montant, phone_number, cmd_id, password);
      print(response.toString());

      if (response["status"] == 200) {
        // print(response["montant"]);
        final data = response;
        notifyListeners();
        return data;
      } else if (response["status"] == 401) {
        print("Erruer 401");
        final data = response;
        notifyListeners();
        return data;
      } else if (response["status"] == 422) {
        print("Erreur 422");
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
