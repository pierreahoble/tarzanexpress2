import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/pusher_service.dart';

PusherService pusherService = PusherService();

class AppState extends ChangeNotifier {
  bool _initialFetchDone;
  bool get initialFetchDone => _initialFetchDone;
  set initialFetchDone(bool val) {
    _initialFetchDone = val;
    notifyListeners();
  }

  SharedPreferences _prefs;
  SharedPreferences get prefs => _prefs;
  set prefs(value) {
    _prefs = value;
    notifyListeners();
  }

  Future<void> loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool _isBusy;
  bool get isBusy => _isBusy;
  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  set pageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }

  clear() {
    initialFetchDone = null;
    prefs = null;
    isBusy = null;
    pageIndex = null;
  }

  checkPusherAlive({@required BuildContext context}) async {
    if (pusherService.currentConnectionState == 'DISCONNECTED') {
      await pusherService.firePusher(
        'tarzan-express',
        [
          'chat',
          'push',
          'chat_client',
          'portefeuille_recharge',
          'confirmation_paiement',
          'position_colis'
        ],
      );
    }
  }
}
