import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/appAssets.dart';
import '../constants/appNames.dart';
import '../Model/message.dart';
import '../services/notificationService.dart';
import '../state/messageState.dart';
import '../helper/enum.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../state/authState.dart';

import 'package:http/http.dart' as http;

List boutiquesImg = [
  AppAssets.aliexpress,
  AppAssets.alibaba,
  AppAssets.amazon,
  AppAssets.shein,
];
List<String> boutiquesUrl = [
  AppNames.aliExpressFr,
  AppNames.alibabaFr,
  AppNames.amazonFr,
  AppNames.sheinFr,
];

bool checkValidUrl({@required String url}) {
  Pattern pattern =
      r"^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)";
  RegExp regex = new RegExp(pattern);
  return regex.hasMatch(url);
}

/* tellPusherLastConnection() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('isLoggedIn')) {
    try {
      //print("TRIGGERING RECALLS");
      final int userId = prefs.getInt("id");
      var uri =
          Uri.parse(AppNames.hostUrl + AppNames.triggerMissed + "/$userId");
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      );
      //print("REPONSE EST : ${response.statusCode}");
      //print("BODY IS : ${response.body}");
      if (response.statusCode.toString().startsWith('2')) {
        List a = jsonDecode(response.body) as List;
        if ((a != null) && a.isNotEmpty) {
          for (var i = 0; i < a.length; i++) {
            Map c = Map.from(a[i]);
            try {
              MessageState mState;
              var navKey;
              if (navKey.currentContext != null)
                mState = Provider.of<MessageState>(navKey.currentContext,
                    listen: false);
              int userId;
              /* SharedPreferences.getInstance().then(
                (value) {
                  try {
                    if ([
                      "PROMO",
                      "ACTUALITE",
                      "INFO",
                      "DIVERS",
                    ].contains(c["event-source"])) {
                      //print("PUSHER RESPONSE NOTIFICATION : $c");
                      showNotification(
                        body: "${c['message']}",
                        /* "Une nouvelle actualité pour vous." */
                        helper: ("PRM" + "${c["event-source"]}"),
                      );
                    } else {
                      value.reload().then(
                        (_) {
                          if (value.containsKey('id')) {
                            userId = value.getInt("id");
                            if ("${c["user_id"]}" == "$userId") {
                              if (c["event-source"] == AppNames.eventNewCmd) {
                                showNotification(
                                  body: "${c['message']}",
                                  helper: ("CMD" +
                                      "${c["commande_id"]}" +
                                      '/' +
                                      "${c["reference"]}"),
                                );
                              }
                              if (c["event-source"] == AppNames.eventNewChat) {
                                ///MESSAGE
                                if ("${c["is_admin"]}" == "true") {
                                  if (!(value.containsKey(
                                          "isInside${c["commande_id"]}") &&
                                      value.getBool(
                                          "isInside${c["commande_id"]}"))) {
                                    showNotification(
                                      body: "${c['message']}",
                                      helper: ("MSG" +
                                          "${c["commande_id"]}" +
                                          '/' +
                                          "${c["reference"]}"),
                                    );
                                  }
                                  if (mState != null &&
                                      ("${c["commande_id"]}" ==
                                          mState.commandeWhichFetchingId)) {
                                    mState.messagesAdd(
                                      Message(
                                        id: null,
                                        date: mState.formatDate("${c["date"]}"),
                                        contenu: "${c["contenu"]}",
                                        isAdmin: '1',
                                        commandeId: "${c["commande_id"]}",
                                        createdAt: null,
                                        updatedAt: null,
                                        isReadByAdmin: "1",
                                        type: null,
                                        image: "${c["image"]}",
                                      ),
                                    );
                                  }
                                }
                              }
                              if (c["event-source"] ==
                                  AppNames.eventNewChatClient) {
                                if ("${c["is_admin"]}" == "true") {
                                  if (!value.containsKey('isInsideSAV')) {
                                    showNotification(
                                      body: "${c['message']}",
                                      helper: ("SAV"),
                                    );
                                  }
                                  if (mState != null)
                                    mState.messagesAddSAV(
                                      Message(
                                          id: null,
                                          date:
                                              mState.formatDate("${c["date"]}"),
                                          contenu: "${c["contenu"]}",
                                          isAdmin: '1',
                                          createdAt: null,
                                          updatedAt: null,
                                          isReadByAdmin: "1",
                                          type: null,
                                          image: "${c["image"]}"),
                                    );
                                }
                              }
                              if (c["event-source"] == AppNames.eventRecharge) {
                                showNotification(
                                  body: "${c['message']}",
                                  helper: ("RCG"),
                                );
                              }
                              if (c["event-source"] ==
                                  AppNames.eventPaiementCmd) {
                                showNotification(
                                  body: "${c['message']}",
                                  helper: ("PAY" +
                                      "${c["commande_id"]}" +
                                      '/' +
                                      "${c["reference"]}"),
                                );
                              }
                              if (c["event-source"] ==
                                  AppNames.eventPositionColis) {
                                //print("PUSHER RESPONSE NOTIFICATION : $c");
                                showNotification(
                                  body: "${c['message']}",
                                  helper: ("COL" +
                                      "${c["commande_id"]}" +
                                      '/' +
                                      "${c["commande_reference"]}"),
                                );
                              }
                              if (c["event-source"] ==
                                  AppNames.eventChangementEtat) {
                                showNotification(
                                  body: "${c['message']}",
                                  helper: ("CMD" +
                                      "${c["commande_id"]}" +
                                      '/' +
                                      "${c["reference"]}"),
                                );
                              }
                            }
                          }
                        },
                      );
                    }
                  } catch (e) {
                    //print("Error occured in streamMessages() : $e");
                  }
                },
              ); */
            } catch (e) {
              //print("Error occured in streamMessages() : $e");
            }
          }
        }
      }
    } catch (e) {
      //print("Exception lors du tellPusherLastConnection(): $e");
    }
  }
} */

Future<void> getNewToken({@required BuildContext context}) async {
 // tellPusherLastConnection();
  final prefs = await SharedPreferences.getInstance();
  DateTime actualDateTime = DateTime.now();
  String formattedActualDate = actualDateTime.year.toString() +
      (actualDateTime.month.toString().length > 1
          ? actualDateTime.month.toString()
          : ("0" + actualDateTime.month.toString())) +
      (actualDateTime.day.toString().length > 1
          ? actualDateTime.day.toString()
          : ("0" + actualDateTime.day.toString()));
  if (!prefs.containsKey("lastTokenDate")) {
    fetchTokenAndStore(
        context: context,
        formattedActualDate: formattedActualDate,
        prefs: prefs);
    await prefs.setString("lastTokenDate", formattedActualDate);
  } else {
    String lastTokenDate = prefs.getString("lastTokenDate");
    if (actualDateTime.difference(DateTime.parse(lastTokenDate)).inDays > 5) {
      fetchTokenAndStore(
          context: context,
          formattedActualDate: formattedActualDate,
          prefs: prefs);
    }
  }
}

fetchTokenAndStore({
  @required SharedPreferences prefs,
  @required BuildContext context,
  @required String formattedActualDate,
}) async {
  String telephone = prefs.getString("telephone").toString();
  String password = prefs.getString("password");
  await Provider.of<AuthState>(context, listen: false)
      .signIn(yPhoneNumber: telephone, yPassword: password);
  prefs.setString(
    "lastTokenDate",
    formattedActualDate,
  );
}

const Map<String, AuthStatus> stringToEnum = {
  "AuthStatus.LOGGED_IN": AuthStatus.LOGGED_IN,
  "AuthStatus.NOT_DETERMINED": AuthStatus.NOT_DETERMINED,
  "AuthStatus.NOT_LOGGED_IN": AuthStatus.NOT_LOGGED_IN,
};

/* showSheet(
  BuildContext context, {
  @required Widget child,
  @required VoidCallback onClicked,
}) =>
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          child,
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('OK'),
          onPressed: onClicked,
        ),
      ),
    ); */

yellowAppbar({String title}) => AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.orange),
      centerTitle: true,
      title: Text(
        title ?? "BIENVENUE SUR TarzanExpress",
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
