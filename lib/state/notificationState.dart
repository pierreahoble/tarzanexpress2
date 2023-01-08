import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/appNames.dart';
import '../helper/utils.dart';
import '../Model/notification.dart';

class NotificationState extends ChangeNotifier {
  int _unread = 0;
  int get unread => _unread;
  set unread(int value) {
    _unread = value;
    notifyListeners();
  }

  List<NotificationModel> _notifications;
  List<NotificationModel> get notifications => _notifications;
  set notifications(List<NotificationModel> value) {
    _notifications = value;
    notifyListeners();
  }

  notificationsAdd(NotificationModel notification) {
    _notifications.add(notification);
    notifyListeners();
  }

  clear() {
    notifications = null;
    unread = null;
  }

  Future<List> getUnreadNumber({
    @required BuildContext context,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      var uri =
          Uri.parse(AppNames.hostUrl + AppNames.notificationUnreadCounter);
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
      unread = int.parse(a.toString());
      return [true, a];
    } catch (e) {
      //print("Exception lors du getNotifications(): $e");
    }
    return [false];
  }

  Future<void> notificationIsRead({
    @required BuildContext context,
    @required String notificationId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      final uri = Uri.parse(
          AppNames.hostUrl + AppNames.notificationIsRead + notificationId);
      /* final response =  */ await http.put(
        uri,
        headers: {
          'Authorization': "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      );
      //print("REPONSE EST : ${response.statusCode}");
      //print("BODY IS : ${response.body}");
    } catch (e) {
      //print("Exception lors du notificationIsRead(): $e");
    }
  }

  Future<void> getNotifications({
    @required BuildContext context,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      var uri = Uri.parse(AppNames.hostUrl + AppNames.getNotifications);
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
      _notifications = [];
      for (var i = 0; i < a.length; i++) {
        //print(Map.from(a[i])['commande_statut']);
        await notificationsAdd(
          NotificationModel(
            id: "${a[i]['id']}",
            etatLecture: "${a[i]['etatLecture']}",
            date: "${a[i]['date']}",
            type: "${a[i]['type']}",
            commandeId: "${a[i]['commande_id']}",
            createdAt: "${a[i]['created_at']}",
            updatedAt: "${a[i]['updated_at']}",
            commandeStatutId: "${a[i]['commande_statut_id']}",
            seen: "${a[i]['seen']}",
            commande: Map.from(a[i]['commande']),
            commandeStatut: Map.from(a[i])['commande_statut'],
          ),
        );
      }
    } catch (e) {
      //print("Exception lors du getNotifications(): $e");
    }
  }
}
