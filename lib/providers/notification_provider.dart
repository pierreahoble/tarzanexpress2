import 'package:flutter/foundation.dart';
import 'package:trevashop_v2/Model/notification.dart';

import '../constants/Api.dart';

class NotificationProvider with ChangeNotifier {
//int _read;
// set checked(int value) {
//     _read = value;
//     notifyListeners();
//   }
  List<dynamic> _notifications ;
  bool notificated = false;
  bool unNotificated = true;
// bool get read => _read;
  List<dynamic> get getNotifications => _notifications;
  

  setNotifications(String token) async {
    print("debut");
    try {
      Api.listNotifications(token).then((value) {
        print(value.toString());
        _notifications = value;

        notifyListeners();
      });
    } catch (err) {
      throw err;
    }
  }

  insertNotification(int index, Map notifications) {
    _notifications.insert(index, notifications);
    notifyListeners();
  }

  deleteNotification(index) {
    _notifications.removeAt(index);
  }
}
