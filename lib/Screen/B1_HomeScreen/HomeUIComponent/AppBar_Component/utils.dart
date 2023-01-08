// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../constants/appAssets.dart';
import '../../../../constants/appNames.dart';
// import './model/message.dart';
// import './services/notificationService.dart';
// import './state/messageState.dart';
// import './enum.dart';

// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../main.dart';
// import './state/authState.dart';

// import 'package:http/http.dart' as http;

List boutiquesImg = [
  AppAssets.aliexpress,
  AppAssets.alibaba,
  AppAssets.amazon,
  AppAssets.shein,
  AppAssets.geeksHouse
];
List<Map<String,String>>shop = [
  {"name":"AliExpress","link": AppNames.aliExpressFr,"img": AppAssets.aliexpress},
  {"name":"ALIBABA","link": AppNames.alibabaFr,"img": AppAssets.alibaba},
  {"name":"AMAZON","link":AppNames.amazonFr,"img": AppAssets.amazon},
  {"name":"SHEIN","link":AppNames.sheinFr,"img": AppAssets.shein},
  {"name":"geeks-house","link":AppNames.geeksHouse,"img": AppAssets.geeksHouse},

];

bool checkValidUrl({@required String url}) {
  Pattern pattern =
      r"^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)";
  RegExp regex = new RegExp(pattern);
  return regex.hasMatch(url);
}
 const String whatsapp ="+919144040888";


yellowAppbar({String title}) => AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.orange),
      centerTitle: true,
      title: Text(
        title ?? "BIENVENUE SUR ESUGU",
        style: TextStyle(color: Colors.orange, fontSize: 16),
      ),
    );

noConnectionSnackbar({@required context}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        "Assurez vous d'avoir une bonne connection et réessayez",
        textAlign: TextAlign.center,
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.fromLTRB(15, 0, 15, 30),
    ),
  );
}
