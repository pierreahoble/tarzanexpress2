import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/appNames.dart';
import '../helper/utils.dart';
import '../Model/order.dart';

class OrderState extends ChangeNotifier {
  bool _fetchingDone;
  bool get fetchingDone => _fetchingDone;
  set fetchingDone(bool value) {
    _fetchingDone = value;
    notifyListeners();
  }

  List<Order> _orders;
  List<Order> get orders => _orders;
  set orders(List<Order> value) {
    _orders = value;
    notifyListeners();
  }

  clear() {
    fetchingDone = null;
    orders = null;
  }

  ordersAdd(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  Future<List> getOrders({
    @required BuildContext context,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      var uri = Uri.parse(AppNames.hostUrl + AppNames.getOrders);
      var response = await http.get(
        uri,
        headers: {
          'Authorization': "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      );
      //print("REPONSE EST : ${response.statusCode}");
      //print("BODY IS : ${response.body}");
      var a = jsonDecode(response.body);
      List<Order> result = [];
      for (var i = 0; i < a.length; i++) {
        Map d = Map.from(a[i]);
        result.add(
          Order(
            id: "${d["id"]}",
            reference: "${d["reference"]}",
            userId: "${d["user_id"]}",
            detailsCommandeId: "${d["details_commande_id"]}",
            statutId: "${d["statut_id"]}",
            montantLivraison: "${d["montant_livraison"]}",
            montantCommande: "${d["montant_commande"]}",
            montantService: "${d["montant_service"]}",
            information: "${d["information"]}",
            statut: Map.from(d["statut"]),
            detailsCommande: Map.from(d["details_commande"]),
          ),
        );
      }
      return [true, result];
    } catch (e) {
      //print("Exception lors du getOrders(): $e");
    }
    return [false];
  }

  Future<List> getPerId({
    @required BuildContext context,
    @required String id,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('id')) {
        await getNewToken(context: context);
        final String token = prefs.getString("accessToken");
        var uri = Uri.parse(AppNames.hostUrl + AppNames.getOrderPerId + "$id");
        var response = await http.get(
          uri,
          headers: {
            'Authorization': "Bearer $token",
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
        );
        //print("REPONSE EST : ${response.statusCode}");
        //print("BODY IS : ${response.body}");
        var a = jsonDecode(response.body);
        Map b = Map.from(a);
        if ("${b["user_id"]}" == "${prefs.getInt('id')}") {
          return [
            true,
            Order(
              id: "${b["id"]}",
              reference: "${b["reference"]}",
              userId: "${b["user_id"]}",
              detailsCommandeId: "${b["details_commande_id"]}",
              statutId: "${b["statut_id"]}",
              montantLivraison: "${b["montant_livraison"]}",
              montantCommande: "${b["montant_commande"]}",
              montantService: "${b["montant_service"]}",
              information: "${b["information"]}",
              statut: Map.from(b["statut"]),
              detailsCommande: Map.from(b["details_commande"]),
            ),
          ];
        }
      }
    } catch (e) {
      //print("Exception lors du getPerId(): $e");
    }
    return [false];
  }

  Future<List> makeTransaction({
    @required String type,
    @required String methode,
    @required String montant,
    @required String numero,
    @required String commandeId,
    @required String reference,
    @required BuildContext context,
  }) async {
    var response;
    try {
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      var uri = Uri.parse(AppNames.hostUrl +
          ((commandeId == null
              ? AppNames.rechargeWallet
              : (methode == AppNames.methodePaiementPortefeuille
                  ? "api/commande/checkout/wallet"
                  : "api/commande/checkout"))));
      response = await http.post(
        uri,
        headers: {
          'Authorization': "Bearer $token",
          //"Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: {
          if (commandeId != null)
            "identifier": type == "La totalité du montant" ? "0" : "1",
          "montant": montant,
          if (commandeId != null) "cmd_id": commandeId,
          if (methode != AppNames.methodePaiementPortefeuille)
            "network": methode,
          if (methode != AppNames.methodePaiementPortefeuille)
            "phone_number": numero,
        },
      );
      //print("REPONSE EST : ${response.statusCode}");
      //print("BODY IS : ${response.body}");
      Map a = Map.from(jsonDecode(response.body));
      if (response.statusCode.toString().startsWith('20')) {
        if (methode == AppNames.methodePaiementPortefeuille) {
          return [true];
        }
        return [true, a['lien'] as String, a['id'].toString()];
      } else {
        if (methode == AppNames.methodePaiementPortefeuille) {
          /* if ((a['message'] != null) && a['message'] == "solde insuffisant") { */
          return [
            false,
            "Paiement décliné. Solde insuffisant, veuillez recharger le portefeuille",
          ];
        } else {
          return [
            false,
            "Nous avons rencontré un problème. Veuillez réessayer plutard svp !"
          ];
        }
      }
    } catch (e) {
      //print("Exception lors du makeTransaction(): $e");
      return [
        false,
        "Nous avons rencontré un problème. Veuillez réessayer plutard svp !"
      ];
    }
  }

  getPortefeuille({
    @required BuildContext context,
  }) async {
    var response;
    try {
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      var uri = Uri.parse(AppNames.hostUrl + AppNames.checkWalletAmount);
      response = await http.get(
        uri,
        headers: {
          'Authorization': "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      );
      //print("REPONSE EST : ${response.statusCode}");
      //print("BODY IS : ${response.body}");
      if (response.statusCode == 200) {
        Map a = Map.from(jsonDecode(response.body));
        //print("BODY IS : $a");
        return [true, a["valeur_actuelle"]];
      }
    } catch (e) {
      //print("Exception lors du getPortefeuille(): $e");
    }
    return [false];
  }
}
