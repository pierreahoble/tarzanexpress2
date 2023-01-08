import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/appNames.dart';
import '../../../helper/utils.dart';

class TransactionState extends ChangeNotifier {
  Future<List> getTransacts({
    @required BuildContext context,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      var uri = Uri.parse(AppNames.hostUrl + AppNames.getTransacts);
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
      if (response.statusCode.toString().startsWith("20")) {
        return [true, a];
      }
    } catch (e) {
      //print("Exception lors du getNotifications(): $e");
    }
    return [false];
  }

  Future<List> debts({
    @required BuildContext context,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      var uri = Uri.parse(AppNames.hostUrl + AppNames.debts);
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
      if (response.statusCode.toString().startsWith("20")) {
        return [
          true,
          a['montant'],
        ];
      }
    } catch (e) {
      //print("Exception lors du debts(): $e");
    }
    return [false];
  }

  Future<List> debtsDetails({
    @required BuildContext context,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      var uri = Uri.parse(AppNames.hostUrl + AppNames.debtsDetails);
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
      if (response.statusCode.toString().startsWith("20")) {
        return [true, a];
      }
    } catch (e) {
      //print("Exception lors du debtsDetails(): $e");
    }
    return [false];
  }

  Future<List> checkState({
    @required BuildContext context,
    @required String transactionId,
  }) async {
    if (transactionId != null) {
      try {
        final prefs = await SharedPreferences.getInstance();
        await getNewToken(context: context);
        final String token = prefs.getString("accessToken");
        var uri = Uri.parse(AppNames.hostUrl +
            AppNames.checkState +
            "$transactionId/check-state");
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
        if (response.statusCode.toString().startsWith("20")) {
          return [true, a];
        }
      } catch (e) {
        //print("Exception lors du checkState(): $e");
        //
      }
    }
    return [false];
  }
}
