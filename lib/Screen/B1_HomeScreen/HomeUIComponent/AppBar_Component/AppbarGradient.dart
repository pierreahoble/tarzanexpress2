import 'package:provider/provider.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:trevashop_v2/Screen/B4_ProfileScreen/AcountUIComponent/Message.dart';
import 'package:trevashop_v2/Screen/B4_ProfileScreen/AcountUIComponent/Notification.dart';
import 'package:trevashop_v2/Screen/OpeningApps/LoginOrSignup/Login.dart';
import 'package:trevashop_v2/providers/authentification_provider.dart';

import 'Search.dart';

class AppbarGradient extends StatefulWidget {
  @override
  _AppbarGradientState createState() => _AppbarGradientState();
}

class _AppbarGradientState extends State<AppbarGradient> {
  String CountNotice = "4";

  /// Build Appbar in layout home
  @override
  Widget build(BuildContext context) {
    /// Create responsive height and padding
    final MediaQueryData media = MediaQuery.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    var data = EasyLocalizationProvider.of(context).data;
    var AuthProv = Provider.of<AuthentificationProvider>(context);

    /// Create component in appbar
    return EasyLocalizationProvider(
      data: data,
      child: Container(
        padding: EdgeInsets.only(top: statusBarHeight, left: 10, right: 10),
        height: 58.0 + statusBarHeight,
        decoration: BoxDecoration(

            /// gradient in appbar
            gradient: LinearGradient(
                colors: [
                  const Color(0xFFA3BDED),
                  const Color(0xFF6991C7),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              "assets/logo2.png",
              height: 60,
              width: 60,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // IconButton(
                //     onPressed: () {
                //       Navigator.of(context).push(PageRouteBuilder(
                //           pageBuilder: (_, __, ___) => new chat()));
                //     },
                //     icon: Icon(
                //       Icons.whatsapp,
                //       color: Colors.white,
                //     )
                //     ),

                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new Notifications()));
                    },
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      AuthProv.logoutAndRedirectToHome();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ))
                //  SizedBox(
                //   width: 20,
                // ),
                //  InkWell(
                //     onTap: () {
                //       Navigator.of(context).push(PageRouteBuilder(
                //           pageBuilder: (_, __, ___) => new chat()));
                //     },
                //     child: Image.asset(
                //       "assets/img/chat.png",
                //       height: media.devicePixelRatio + 20.0,
                //     )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
