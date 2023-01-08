import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/utils.dart';

import '../constants/appNames.dart';
import '../Model/article.dart';

class ArticleState extends ChangeNotifier {
  List<int> _unread;
  List<int> get unread => _unread;
  set unread(List<int> value) {
    _unread = value;
    notifyListeners();
  }

  List<ArticleModel> _articles;
  List<ArticleModel> get articles => _articles;
  set articles(List<ArticleModel> value) {
    _articles = value;
    notifyListeners();
  }

  articleAdd(ArticleModel article) {
    _articles.add(article);
    notifyListeners();
  }

  clear() {
    articles = null;
    unread = null;
  }

  /* Future<List> getUnreadNumber({
    @required BuildContext context,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      var uri = Uri.parse(AppNames.hostUrl + AppNames.articleUnreadCounter);
      var response = await http.get(
        uri,
        headers: {
          'Authorization': "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      );
      print("REPONSE EST : ${response.statusCode}");
      print("BODY IS : ${response.body}");
      var a = jsonDecode(response.body);
      return [true, a];
    } catch (e) {
      print("Exception lors du getUnreadNumberArticle(): $e");
    }
    return [false];
  } */

  /* Future<void> articleIsRead({
    @required BuildContext context,
    @required String articleId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      var uri =
          Uri.parse(AppNames.hostUrl + AppNames.articleIsRead + articleId);
      var response = await http.put(
        uri,
        headers: {
          'Authorization': "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      );
      print("REPONSE EST : ${response.statusCode}");
      print("BODY IS : ${response.body}");
    } catch (e) {
      print("Exception lors du articleIsRead(): $e");
    }
  } */

  Future<void> getArticles({
    @required BuildContext context,
  }) async {
    _articles = null;
    try {
      final prefs = await SharedPreferences.getInstance();
      await getNewToken(context: context);
      final String token = prefs.getString("accessToken");
      var uri = Uri.parse(AppNames.hostUrl + AppNames.getArticles);
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
      _articles = [];
      for (var i = 0; i < a.length; i++) {
        await articleAdd(
          ArticleModel(
            id: "${a[i]['id']}",
            titre: "${a[i]['titre']}",
            photoAvant: "${a[i]['photoAvant']}",
            background: "${a[i]['background']}",
            contenu: "${a[i]['contenu']}",
            typeId: "${a[i]['type_id']}",
            createdAt: "${a[i]['created_at']}",
            updatedAt: "${a[i]['updated_at']}",
            photoAvantLien: "${a[i]['photo_avant_lien']}",
            backgroundLien: "${a[i]['background_lien']}",
            type: Map.from(a[i]['type']),
          ),
        );
      }
    } catch (e) {
      //print("Exception lors du getArticles(): $e");
    }
  }
}
