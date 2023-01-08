/*import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/utils.dart';
import '../Model/agencesLivraison.dart';
import '../state/panierState.dart';

import '../constants/appNames.dart';
import '../Model/product.dart';

class NewOrderState extends ChangeNotifier {
  List<Product> _newProducts = [];
  List<Product> get newProducts => _newProducts;
  set newProducts(List<Product> value) {
    _newProducts = value;
    notifyListeners();
  }

  newProductsAdd(Product product) {
    _newProducts.add(product);
    notifyListeners();
  }

  clear() {
    newProducts = [];
  }

  modifyNewProductsElement({
    int index,
    String description,
    String nom,
    String lien,
    String image,
    int quantite,
    bool isExpanded,
  }) {
    _newProducts[index] = _newProducts[index].copyWith(
      nom: nom,
      description: description,
      image: image,
      isExpanded: isExpanded,
      lien: lien,
      quantite: quantite,
    );
    notifyListeners();
  }

  deleteNewProductsElement(int index) {
    _newProducts.removeAt(index);
    notifyListeners();
  }

  getModesLivraison({
    @required BuildContext context,
    bool decompose,
  }) async {
    var response;
    try {
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      var uri = Uri.parse(
        AppNames.hostUrl + AppNames.modesLivraison,
      );
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
        List<AgenceLivraison> listOfAgences = [];
        List<int> modesId = [];
        Map z = Map.from(jsonDecode(response.body));
        List y = z["mode_livraisons"];
        for (var i = 0; i < y.length; i++) {
          modesId.add(Map.from(y[i])['id']);
        }

        List a = z['pays'];
        if (decompose == null) {
          for (var i = 0; i < a.length; i++) {
            List tVilles = a[i]["villes"];
            for (var j = 0; j < tVilles.length; j++) {
              List tAgences = tVilles[j]["agences"];
              for (var k = 0; k < tAgences.length; k++) {
                Map tAgenceK = Map.from(tAgences[k]);
                listOfAgences.add(
                  AgenceLivraison(
                    id: tAgenceK["id"],
                    nomAgence: tAgenceK["nom"],
                    nomPays: a[i]['nom'],
                    nomVille: tVilles[j]['nom'],
                  ),
                );
              }
            }
          }
        }
        return decompose == null
            ? (listOfAgences.isEmpty ? [false] : [true, listOfAgences, modesId])
            : [true, z['pays']];
      }
    } catch (e) {
      //print("Exception lors du getModesLivraison(): $e");
    }
    return [false];
  }

  Future<List> createOrder({
    @required int agenceId,
    @required BuildContext context,
    @required PanierState panierState,
    @required String adresseLivraison,
    @required String pays,
    @required String ville,
    @required String quartier,
    @required String adresse1,
    @required String adresse2,
    @required int modeTransport,
  }) async {
    try {
      ///CREATING REQUEST VARIABLE
      //print("CREATING REQUEST VARIABLE");
      var uri = Uri.parse(AppNames.hostUrl + AppNames.createOrder);
      var request = new http.MultipartRequest("POST", uri);

      ///ADDING FIELDS
      //print("ADDING FIELDS");
      request.fields["a_livraison"] = adresseLivraison;
      if (adresseLivraison != "2")
        request.fields["agence"] =
            agenceId != null ? agenceId.toString() : null;
      /* print("HEYYYY NB PRODUITS =========================" +
          newProducts.length.toString()); */
      request.fields["nbreProduit"] = newProducts.length.toString();
      request.fields["type_livraison_id"] = modeTransport.toString();
      for (var i = 0; i < newProducts.length; i++) {
        request.fields["nom${i + 1}"] = newProducts[i].nom.length > 150
            ? newProducts[i].nom.substring(0, 149)
            : newProducts[i].nom;
        request.fields["description${i + 1}"] =
            newProducts[i].description.length > 150
                ? newProducts[i].description.substring(0, 149)
                : newProducts[i].description;
        request.fields["lien${i + 1}"] = newProducts[i].lien;
        request.fields["quantite${i + 1}"] = newProducts[i].quantite.toString();

        if (!["null", null, ""].contains(newProducts[i].image)) {
          //print("IMAGE IS : ${newProducts[i].image}");
          String dir = (await getApplicationDocumentsDirectory()).path;
          File file = File("$dir/" +
              DateTime.now().millisecondsSinceEpoch.toString() +
              ".png");
          await file.writeAsBytes(base64Decode(newProducts[i].image));
          request.files.add(
            await http.MultipartFile.fromPath("images${i + 1}", file.path),
          );
        }
      }
      if (adresseLivraison == "2") {
        request.fields["pays"] = pays;
        request.fields["ville"] = ville;
        request.fields["quartier"] = quartier;
        request.fields["adresse1"] = adresse1;
        request.fields["adresse2"] = adresse2;
      }

      ///ADDING HEADERS
      //print("ADDING HEADERS");
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      Map<String, String> headers = {
        'Authorization': "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json"
      };
      request.headers.addAll(headers);

      ///SENDING THE REQUEST
      //print("SENDING THE REQUEST");
      var response = await request.send();
      //print('Response status: ${response.statusCode}');

      ///READING THE RESPONSE
      //print("READING THE RESPONSE");
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      //print('status code: ${response.statusCode}');
      //print('Response body: $responseString');
      if (response.statusCode.toString().startsWith("20")) {
        for (var i = 0; i < newProducts.length; i++) {
          int zId = newProducts[i].id;
          for (var j = 0; j < panierState.contentPanier.length; j++) {
            if (panierState.contentPanier[j].id == zId) {
              j = panierState.contentPanier.length + 1;
            }
          }
          //print("zId EST $zId \n zIndex EST $zIndex");
          await panierState.deleteContentPanierElement(id: zId);
        }
        newProducts = [];
        Map payloadHelper = Map.from(jsonDecode(responseString));
        return [
          true,
          (payloadHelper['id'].toString() + '/' + payloadHelper['reference'])
        ];
      }
    } catch (e) {
      //print("Exception lors du createOrder(): $e");
    }
    return [false];
  }
}
*/