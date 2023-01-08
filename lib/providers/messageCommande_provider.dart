import 'package:flutter/foundation.dart';

import '../constants/Api.dart';

class MessageCommandsProvider with ChangeNotifier {
  List<dynamic> _messages_clone;
  List<dynamic> _messages;
  List<dynamic> _clientMessages;
  List<dynamic> _clientMessages_clone;
  bool loading = false;

  List<dynamic> get getMessages => _messages_clone;
  List<dynamic> get getApiMessages => _messages;
  List<dynamic> get getClientMessages => _clientMessages;
  List<dynamic> get getClientMessagesClone => _clientMessages_clone;

  bool get getloading => loading;

  setClientMessages(String token) {
    Api.getChatMessages(token).then((value) {
      _clientMessages = value;
      notifyListeners();
      _clientMessages_clone = new List.from(_clientMessages.reversed);
      notifyListeners();
    });
  }

  addClientMessages(int index, Map<String, dynamic> map) {
    _clientMessages_clone.insert(index, map);

    notifyListeners();
  }

  setMessages(String token, String id) async {
    _messages = null;
    notifyListeners();
    _messages_clone = null;
    notifyListeners();
    Api.commandsMessages(token, id).then((value) {
      _messages = value;
      notifyListeners();
      _messages_clone = new List.from(_messages.reversed);
      notifyListeners();
    });
  }

  clearMessages() {
    _messages_clone.clear();
    notifyListeners();
  }

  setLoading() {
    loading = !loading;
    notifyListeners();
  }

  addMessages(int index, Map<String, dynamic> map) {
    _messages_clone.insert(index, map);

    notifyListeners();
  }

  Future<List<dynamic>> commandsMessages(String token, String id) async {
    try {
      final response = await Api.commandsMessages(token, id);

      return response;
    } catch (err) {
      throw err;
    }
  }

  Future<Map> unreadMessages(String token) async {
    try {
      final response = await Api.unreadMessages(token);
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

  Future<Map> postMessageText(String token, String id, String value) async {
    try {
      final response = await Api.postMessageText(token, id, value);

      int validate = response["status"];
      if (validate == 200) {
        print(response);
        //final data = response;
        //notifyListeners();
        //   return response;
      } else if (validate == 401) {
        print("erreur d'envoie");
        notifyListeners();
        return {};
      } else {
        print("rien ne marche");
        notifyListeners();
        return {};
      }
    } catch (err) {
      throw err;
    }
  }

  Future<Map> updateMessagesState(String token, String id) async {
    try {
      final response = await Api.updateMessagesState(token, id);
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

  Future ClientMessenger(String token, String id, String contenu) async {
    try {
      final response = await Api.clientMessenger(token, id, contenu);
      print("vous avez recu " + response.toString());
      if (response["status"] == 200) {
        print(response);
      } else if (response["status"] == 401) {
        print("Erreur d'envoie");
        notifyListeners();
      } else {
        print("Verifiez votre connexion et réesseyer plus tard");
      }
    } catch (e) {}
  }

  Future getClientChatMessages(String token) async {
    try {
      final response = await Api.getChatMessages(token);
    } catch (e) {}
  }
}
