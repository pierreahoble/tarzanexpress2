import 'dart:ui';

import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:trevashop_v2/Screen/B4_ProfileScreen/AcountUIComponent/AproposDeNous.dart';
import 'package:trevashop_v2/Screen/B4_ProfileScreen/AcountUIComponent/CallCenter.dart';
import 'package:trevashop_v2/Screen/B4_ProfileScreen/AcountUIComponent/CreditCardSetting.dart';
import 'package:trevashop_v2/Screen/B4_ProfileScreen/AcountUIComponent/Historique.dart';
import 'package:trevashop_v2/Screen/B4_ProfileScreen/AcountUIComponent/HistoriqueImpayes.dart';
import 'package:trevashop_v2/Screen/B4_ProfileScreen/AcountUIComponent/Message.dart';
import 'package:trevashop_v2/Screen/B4_ProfileScreen/AcountUIComponent/Notification.dart';
import 'package:trevashop_v2/Screen/B4_ProfileScreen/AcountUIComponent/PageProfile.dart';
import 'package:trevashop_v2/Screen/B5_CommandScreen/UIcomponentCommand/payerRecap.dart';
import 'package:trevashop_v2/constants/appAssets.dart';
import 'package:trevashop_v2/constants/appColors.dart';
import 'package:trevashop_v2/constants/appNames.dart';
import 'package:trevashop_v2/widgets/customWidgets.dart';

import '../../../providers/transaction_provider.dart';
import '../../../services/shared_preferences.dart';
import '../../B3_CartScreen/B3_Cart/address.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

/// Custom Font
var _txt = TextStyle(
  color: Colors.black,
  fontFamily: "Sans",
);

/// Get _txt and custom value of Variable for Name User
var _txtName = _txt.copyWith(fontWeight: FontWeight.w700, fontSize: 17.0);

/// Get _txt and custom value of Variable for Edit text
var _txtEdit = _txt.copyWith(color: Colors.black26, fontSize: 15.0);

/// Get _txt and custom value of Variable for Category Text
var _txtCategory = _txt.copyWith(
    fontSize: 14.5, color: Colors.black54, fontWeight: FontWeight.w500);

class _ProfilState extends State<Profil> {
  String nom;
  String prenoms;
  String token;
  String montant;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    SharedPreferencesClass.restore('nom').then((value) {
      setState(() {
        nom = value;
        print(nom);
      });
    });

    SharedPreferencesClass.restore('prenoms').then((value) {
      setState(() {
        prenoms = value;
        print(prenoms);
      });
    });

    SharedPreferencesClass.restore('token').then((value) {
      setState(() {
        token = value;
        getMontant(token);
        // print(token);
      });
    });
  }

  void getMontant(token) {
    TransactionProvider().getPortefeuilleAll(token).then((value) {
      setState(() {
        print(value);
        montant = value['solde_portefeuille'].toString();
        print(montant);
        return montant;
      });
    });
  }

  void getTransaction() {}

  String methode;
  void selectPaymentType({
    @required BuildContext context,
  }) {
    methode = null;
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          List zContent = [
            AppAssets.logoFlooz,
            AppAssets.logoTMoney,
          ];
          List zContentText = [
            AppNames.methodePaiementFLOOZ,
            AppNames.methodePaiementTMONEY,
          ];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              color: Colors.white,
              margin:
                  EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Recharger par :",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.amber[800],
                    ),
                  ),
                  SizedBox(height: 12),
                  for (var i = 0; i < zContent.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.5),
                      child: GestureDetector(
                        onTap: () {
                          methode = zContentText[i];
                          //print("METHODE == $methode");
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PayerRecap(
                                  commandeId: null,
                                  montantApayer: null,
                                  method: methode,
                                  reference: null,
                                  type: null),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 2, color: AppColors.indigo),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              margin: const EdgeInsets.only(left: 8.0),
                              decoration: BoxDecoration(
                                color: zContentText[i] ==
                                        AppNames.methodePaiementFLOOZ
                                    ? Colors.black
                                    : Colors.yellowAccent[700],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Image.asset(
                                zContent[i],
                                height: 45,
                                width: 75,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(height: 25)
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    /// Declare MediaQueryData
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Size dSize = MediaQuery.of(context).size;
    double sizeWidth = mediaQueryData.size.width;

    /// To Sett PhotoProfile,Name and Edit Profile
    var _profile = Padding(
      padding: EdgeInsets.only(
        top: 75.0,
        left: dSize.width * 0.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Container(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Container(
                height: 90.0,
                width: 90.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2.5),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/images/user-avatar.png"))),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 5.0),
              //   child: Text(
              //     "name",
              //     style: _txtName,
              //   ),
              // ),
              // InkWell(
              //   onTap: null,
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 0.0),
              //     child: Text(
              //      "modifier le profil",
              //       style: _txtEdit,
              //     ),
              //   ),
              // ),
            ],
          ),
          // Container(),
        ],
      ),
    );

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                /// Setting Header Banner

                Container(
                  // width: 100,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          image: AssetImage("assets/logo1.png"),
                          fit: BoxFit.cover)),
                ),

                /// Calling _profile variable
                _profile,

                Card(
                  elevation: 8,
                  margin: EdgeInsets.only(
                      top: dSize.height * 0.30, left: dSize.width * 0.025),
                  // padding: EdgeInsets.all(dSize.width * 0.02),
                  child: Container(
                    width: fullWidth(context) - 21,
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.1),
                            blurRadius: 4.5,
                            spreadRadius: 1.0,
                          )
                        ]),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              nom != null ? nom.toUpperCase() : '',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              prenoms ?? '',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Montant',
                                  style: TextStyle(
                                      color: Colors.blue[700], fontSize: 15),
                                ),
                                montant == null
                                    ? Text("0 XOF")
                                    : Text(
                                        "${montant.toString()} XOF",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                              ],
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green)),
                              onPressed: () {
                                selectPaymentType(
                                  context: context,
                                );
                              },
                              child: Container(
                                width: 100,
                                child: Text(
                                  "Recharger votre Compte",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Card(
                //   elevation: 8,
                //   margin: EdgeInsets.only(
                //       top: dSize.height * 0.30, left: dSize.width * 0.025),
                //   // padding: EdgeInsets.all(dSize.width * 0.02),
                //   child: Container(
                //     width: fullWidth(context) - 21,
                //     padding: EdgeInsets.all(25),
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //         boxShadow: [
                //           BoxShadow(
                //             color: Colors.black12.withOpacity(0.1),
                //             blurRadius: 4.5,
                //             spreadRadius: 1.0,
                //           )
                //         ]),
                //     child: Column(
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: <Widget>[
                //             FittedBox(
                //               child: Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Text(
                //                     "Solde (XOF) :",
                //                     style: TextStyle(
                //                       color: Colors.blue,
                //                       fontSize: 14.0,
                //                     ),
                //                   ),
                //                   SizedBox(
                //                     height: 8,
                //                   ),
                //                   Text(
                //                     "2500 F CFA",
                //                     style: TextStyle(
                //                       color: Colors.blue,
                //                       fontSize: 14.0,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             GestureDetector(
                //               onTap: () {
                //                 Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                     builder: (context) => HistoriqueImpayes(),
                //                   ),
                //                 );
                //               },
                //               child: Column(
                //                 children: [
                //                   Image.asset(
                //                     "assets/icon/rembours.png",
                //                     width: 30,
                //                     height: 30,
                //                     color: Colors.redAccent,
                //                   ),
                //                   Text(
                //                     "Impayé(s)",
                //                     style: TextStyle(
                //                       fontSize: 13.0,
                //                       color: Colors.red,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             GestureDetector(
                //               onTap: () {
                //                 selectPaymentType(
                //                   context: context,
                //                 );
                //               },
                //               child: Column(
                //                 mainAxisSize: MainAxisSize.min,
                //                 children: [
                //                   Icon(
                //                     Icons.credit_card,
                //                     size: 30,
                //                     color: Colors.greenAccent,
                //                   ),
                //                   Text(
                //                     "Recharge",
                //                     style: TextStyle(
                //                       fontSize: 13.0,
                //                       color: Colors.greenAccent,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             // Row(
                //             //   children: [
                //             //         GestureDetector(
                //             //           onTap: () {
                //             //             Navigator.push(
                //             //                 context,
                //             //                 MaterialPageRoute(
                //             //                   builder: (context) => Cart(),
                //             //                 ),
                //             //               );
                //             //           },
                //             //           child: Image.asset(
                //             //           AppAssets.cartAdd,
                //             //           height: 25,
                //             //           width: sizeWidth * 0.15,
                //             //           ),
                //             //         ),
                //             //        GestureDetector(
                //             //           onTap: () {
                //             //             //  Navigator.push(
                //             //             //     context,
                //             //             //     MaterialPageRoute(
                //             //             //       builder: (context) => Notification(),
                //             //             //     ),
                //             //             //   );
                //             //           },
                //             //           child:Image.asset(
                //             //         AppAssets.noNotifIcon,
                //             //         height: 30,
                //             //         width: sizeWidth * 0.15,
                //             //       ),
                //             //       ),
                //             //   ]
                //             // )
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Column(
                    /// Setting Category List
                    children: <Widget>[
                      /// Call category class
                      SizedBox(
                        height: 50,
                      ),
                      category(
                        txt: 'Informations personnelles',
                        padding: 20.0,
                        image: "assets/icon/Profile.png",
                        tap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) => new ProfilePage()));
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 85.0, right: 30.0),
                        child: Divider(
                          color: Colors.black12,
                          height: 2.0,
                        ),
                      ),
                      category(
                        txt: 'Vos Adresses',
                        padding: 26.0,
                        image: "assets/icon/adresse.png",
                        tap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) => new Address()));
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 85.0, right: 30.0),
                        child: Divider(
                          color: Colors.black12,
                          height: 2.0,
                        ),
                      ),
                      category(
                        txt: ' Notifications',
                        padding: 26.0,
                        image: "assets/icon/notification.png",
                        tap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  new Notifications()));
                        },
                      ),
                      
                     
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 85.0, right: 30.0),
                        child: Divider(
                          color: Colors.black12,
                          height: 2.0,
                        ),
                      ),
                      category(
                        txt: 'service client',
                        padding: 26.0,
                        image: "assets/icon/girlcallcenter.png",
                        tap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) => new callCenter()));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 85.0, right: 30.0),
                        child: Divider(
                          color: Colors.black12,
                          height: 2.0,
                        ),
                      ),
                      category(
                        txt: 'Mon portefeuille',
                        padding: 26.0,
                        image: "assets/icon/Wallet.png",
                        tap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  new creditCardSetting()));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 85.0, right: 30.0),
                        child: Divider(
                          color: Colors.black12,
                          height: 2.0,
                        ),
                      ),
                      category(
                        txt: 'Mes transactions',
                        padding: 26.0,
                        image: "assets/icon/shopping-cart.png",
                        tap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  new HistoriquePortefeuille()));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 85.0, right: 30.0),
                        child: Divider(
                          color: Colors.black12,
                          height: 2.0,
                        ),
                      ),
                      category(
                        padding: 26.0,
                        txt: 'A propos',
                        image: "assets/icon/menu.png",
                        tap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) => new ProposDeNous()));
                        },
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20.0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Component category class to set list
class category extends StatelessWidget {
  @override
  String txt, image;
  GestureTapCallback tap;
  double padding;

  category({this.txt, this.image, this.tap, this.padding});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: padding),
                  child: Image.asset(
                    image,
                    height: 25.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    txt,
                    style: _txtCategory,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
