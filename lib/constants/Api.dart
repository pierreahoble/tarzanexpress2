import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trevashop_v2/Model/CartItemData.dart';
import 'package:trevashop_v2/Model/commandData.dart';

import 'package:trevashop_v2/constant.dart';
import 'package:trevashop_v2/state/panierState.dart';

import '../Model/product.dart';

// const String serverUrl = 'http://192.168.0.106:8000/api';
const String serverUrl = 'http://api.esuguserver.com/api';
// const String serverUrl = 'http://192.168.0.106:8000/api';

const Map<String, String> headers = {
  "Content-type": "application/json",
  "Accept": "application/json",
};

Map<String, String> headersBearer(String token) {
  return {
    "Content-type": "application/json",
    "Accept": "application/json",
    'Authorization': 'Bearer $token',
  };
}

Uri fullUri(String uri) {
  return Uri.parse('$serverUrl/$uri');
}

class Api {
  /************************************************************************/
  /*****************************LOGIN ET REGISTER***************************/
  ///***********************************************************************/

  static Future<Map> login(String number, String password) async {
    try {
      final response = await http.post(fullUri("login"),
          headers: headers,
          body: json.encode({
            "phone": number,
            "password": password,
          }));
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map> register(
      String firstName,
      String lastName,
      String password,
      String email,
      String telephone,
      int idCountry,
      String parrainageCode,
      String agree,
      String confirmationPassword) async {
    try {
      final response = await http.post(fullUri("register"),
          headers: headers,
          body: json.encode({
            "phone_number": telephone,
            "password": password,
            "pays_id": idCountry,
            "agree": agree,
            "email": email,
            "password_confirmation": confirmationPassword,
            "nom": lastName,
            "prenoms": firstName,
            "code_parrainage": parrainageCode
          }));
      final data = json.decode(response.body) as Map<String, dynamic>;

      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map> checkNumber(String number, int pays_id) async {
    print(number);
    try {
      final response = await http.post(fullUri("users/check_phone_number"),
          headers: headers,
          body: json.encode({
            "phone_number": number,
            "pays_id": pays_id,
          }));
      final data = json.decode(response.body) as Map<String, dynamic>;
      print(data.toString());
      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map> affiliesCount(String token) async {
    try {
      final response = await http.get(
        fullUri("users/affilies/count"),
        headers: headersBearer(token),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map> UpdateInfo(String id, String token, String firstName,
      String lastName, String phone, String email) async {
    try {
      final response = await http.put(
        fullUri("users/update/" + id),
        body: json.encode({
          "nom": lastName,
          "prenoms": firstName,
          "phone_number": phone,
          "email": email
        }),
        headers: headersBearer(token),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map> changePassword(
      String token, String oldPassword, String newPassword) async {
    try {
      final response = await http.put(
        fullUri("users/change_password"),
        body: json
            .encode({"old_password": oldPassword, "new_password": newPassword}),
        headers: headersBearer(token),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map> logout(String token) async {
    try {
      final response = await http.get(
        fullUri("logout"),
        headers: headersBearer(token),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (err) {
      throw err;
    }
  }

  /************************************************************************/
  /*****************************COMMANDES EXECUTION***************************/
  ///***********************************************************************/
  ///
  static Future<Map<String, dynamic>> transportMode(String token) async {
    try {
      final response = await http.get(
        fullUri("mode-transport"),
        headers: headersBearer(token),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<int> MakeCommande(
    int type_livraison,
    int a_livraison,
    int agence,
    String pays,
    String ville,
    String quartier,
    String adresse1,
    String adresse2,
    List<Product> items,
    String token,
  ) async {
    try {
      var request =
          new http.MultipartRequest("POST", fullUri("commande/store"));

//print(items.)
      ///ADDING FIELDS
      //print("ADDING FIELDS");
      request.fields["a_livraison"] = a_livraison.toString();
      //if (a_livraison.toString() != "2")
      request.fields["agence"] = agence != null ? agence.toString() : null;
      /* print("HEYYYY NB PRODUITS =========================" +
          newProducts.length.toString()); */
      request.fields["nbreProduit"] = items.length.toString();
      request.fields["type_livraison_id"] = type_livraison.toString();
      for (var i = 0; i < items.length; i++) {
        request.fields["nom${i + 1}"] = items[i].nom.length > 150
            ? items[i].nom.substring(0, 149)
            : items[i].nom;
        request.fields["description${i + 1}"] =
            items[i].description.length > 150
                ? items[i].description.substring(0, 149)
                : items[i].description;
        request.fields["lien${i + 1}"] = items[i].lien;
        request.fields["quantite${i + 1}"] = items[i].quantite.toString();

        if (!["null", null, ""].contains(items[i].images)) {
          //print("IMAGE IS : ${newProducts[i].image}");
          String dir = (await getApplicationDocumentsDirectory()).path;
          File file = File("$dir/" +
              DateTime.now().millisecondsSinceEpoch.toString() +
              ".png");
          await file.writeAsBytes(base64Decode(items[i].images));
          request.files.add(
            await http.MultipartFile.fromPath("images${i + 1}", file.path),
          );
        }
      }
      if (a_livraison.toString() == "0") {
        request.fields["pays"] = pays;
        request.fields["ville"] = ville;
        request.fields["quartier"] = quartier;
        request.fields["adresse1"] = adresse1;
        request.fields["adresse2"] = adresse2;
      }

      Map<String, String> headers = {
        'Authorization': "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json"
      };
      request.headers.addAll(headers);

      ///SENDING THE REQUEST
      //print("SENDING THE REQUEST");
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("response from api" + responseString);
      //var data = json.decode(response.stream) as Map<String, dynamic>;
      //print(data);
      if (response.statusCode == 200) {
        for (var i = 0; i < items.length; i++) {
          int zId = items[i].id;
          for (var j = 0; j < PanierState().contentPanier.length; j++) {
            if (PanierState().contentPanier[j].id == zId) {
              j = PanierState().contentPanier.length + 1;
            }
          }
          await PanierState().deleteContentPanierElement(id: zId);
        }
      }
      items = [];

      return response.statusCode;

      // print("response" + data.toString());
      //return data;
    } catch (e) {
      print("Rien ne marche");
      throw e;
    }
  }

  static Future<dynamic> deleteiTem(var items) async {
    for (var i = 0; i < items.length; i++) {
      int zId = items[i].id;
      for (var j = 0; j < PanierState().contentPanier.length; j++) {
        if (PanierState().contentPanier[j].id == zId) {
          j = PanierState().contentPanier.length + 1;
        }
      }
      await PanierState().deleteContentPanierElement(id: zId);
    }
    print("Suppression");
  }

  static Future<CommandData> getCommands(String token) async {
    try {
      final response = await http.get(
        fullUri("commande/all"),
        headers: headersBearer(token),
      );

      final data = CommandData.fromJson(jsonDecode(response.body));

      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map<String, dynamic>> getCommandsDetail(
      String token, int id) async {
    try {
      final response = await http.get(
        fullUri("commande/details/" + id.toString()),
        headers: headersBearer(token),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (err) {
      throw err;
    }
  }

  /************************************************************************/
  /*****************************ARTICLES***************************/
  ///***********************************************************************/
  static Future<Map> getArticlesByType(String token, String type) async {
    try {
      final response = await http.get(
        fullUri("articles/" + type),
        headers: headersBearer(token),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map> articleDetails(String token, String id) async {
    try {
      final response = await http.get(
        fullUri("articles/show/" + id),
        headers: headersBearer(token),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (err) {
      throw err;
    }
  }

  /************************************************************************/
  /*****************************COMMANDS MESSAGES***************************/
  ///***********************************************************************/

  static Future<List<dynamic>> commandsMessages(String token, String id) async {
    try {
      final response = await http.get(
        fullUri("messages/commandes/" + id),
        headers: headersBearer(token),
      );
      print(response.statusCode);
      final data = json.decode(response.body) as List<dynamic>;
      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map> unreadMessages(String token) async {
    try {
      final response = await http.get(
        fullUri("messages/messages-non-lus"),
        headers: headersBearer(token),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map> postMessageText(
      String token, String id, String messageValue) async {
    print(token);
    try {
      final response = await http.post(fullUri("messages/send/" + id),
          headers: headersBearer(token),
          body: json.encode({
            "contenu": messageValue,
          }));
      final data = json.decode(response.body) as Map<String, dynamic>;
      print(data);
      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map> postMessagePicture(
      String token, String id, String messageValue) async {
    try {
      final response = await http.post(fullUri("messages/send/picture/" + id),
          headers: headersBearer(token),
          body: json.encode({
            "contenu": messageValue,
          }));
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map> updateMessagesState(String token, String id) async {
    try {
      final response = await http.put(
        fullUri("messages/commandes/" + id + "/update_messages_states"),
        headers: headersBearer(token),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map> clientMessenger(
      String token, String id, String contenu) async {
    try {
      final response = await http.post(
          fullUri("service_client/chat/send/" + id),
          headers: headersBearer(token),
          body: json.encode({"contenu": contenu}));
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<dynamic>> getChatMessages(String token) async {
    try {
      final response = await http.get(fullUri("service_client/chat"),
          headers: headersBearer(token));
      final data = json.decode(response.body) as List<dynamic>;
      return data;
    } catch (e) {
      throw e;
    }
  }

  /************************************************************************/
  /*****************************PORTEFEUILLE***************************/
  ///***********************************************************************/
  static Future<Map> historicPortefeuille(String token) async {
    try {
      final response = await http.get(
        fullUri("transactions/index"),
        headers: headersBearer(token),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map> payerValeur(String token, String id, String arg) async {
    try {
      final response = await http.get(
        fullUri("commande/checkout/getamount-${arg}/${id}"),
        // fullUri("commande/checkout/getamount-total/12"),
        headers: headersBearer(token),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      // print(data);
      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map> modeAll(String token) async {
    print(token);
    print(fullUri("mode-paiements").toString());
    try {
      final response = await http.get(
        fullUri("mode-paiements"),
        // fullUri("commande/checkout/getamount-total/12"),
        headers: headersBearer(token),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      print(data);
      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map> payCommande(String token, String network, String montant,
      String phone_number, String cmd_id, String password) async {
    try {
      final response = await http.post(
        fullUri("transaction/commande/checkout"),
        body: json.encode({
          "network": network,
          "montant": montant,
          "phone_number": phone_number,
          "cmd_id": cmd_id,
          "password": password
        }),
        headers: headersBearer(token),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      print(data);
      return data;
    } catch (err) {
      throw err;
    }
  }

  /************************************************************************/
  /*****************************NOTIFICATIONS***************************/
  ///***********************************************************************/
  ///

  static Future<List<dynamic>> listNotifications(String token) async {
    try {
      print("appell");
      final response = await http.get(
        fullUri("notifications_view"),
        headers: headersBearer(token),
      );
      print(response);
      final data = json.decode(response.body) as List<dynamic>;
      print(data);
      return data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map> updateNotificationsState(String token) async {
    try {
      final response = await http.put(
        fullUri("notifications/update/read_state"),
        headers: headersBearer(token),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (err) {
      throw err;
    }
  }
}
