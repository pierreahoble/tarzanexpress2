import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trevashop_v2/Screen/B3_CartScreen/B3_Cart/B3_Cart_Screen.dart';
import 'package:trevashop_v2/Screen/B4_ProfileScreen/AcountUIComponent/PageProfile.dart';
import 'package:trevashop_v2/Screen/B5_CommandScreen/UIcomponentCommand/HistoriqueCommandes.dart';
import 'package:trevashop_v2/Screen/B5_CommandScreen/UIcomponentCommand/commandeEnCours.dart';
import 'package:trevashop_v2/state/panierState.dart';
import './UIcomponentCommand/debtDetails.dart';
import './UIcomponentCommand/transactionState.dart';
import '../../../constants/appAssets.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../constants/appColors.dart';
// import '../../../page/inApp/compte/profilePage.dart';
// import 'aide.dart';
import './UIcomponentCommand/historiqueTransactions.dart';

class Commande extends StatefulWidget {
  @override
  _CommandeState createState() => _CommandeState();
}

class _CommandeState extends State<Commande> {
  String methode;
  String suggestionText;


  @override
  Widget build(BuildContext context) {
    Size dSize = MediaQuery.of(context).size;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double sizeWidth = mediaQueryData.size.width;
    List typesCommandes = [
      Icons.account_balance_wallet_outlined,
      "Non-payées",
      Icons.wallet_giftcard_outlined,
      "En attente d'expédition",
      Icons.directions_bus_outlined,
      "Expédiées",
      Icons.cancel_outlined,
      "Annulées",
      Icons.info_outline,
      "En attente d'avis",
      Icons.done,
      "Terminées"
    ];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration(milliseconds: 1),
            () {
              setState(() {});
            },
          );
        },
        child: Builder(
          builder: (context) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            // padding: EdgeInsets.fromLTRB(dSize.width * 0.03,
            //     dSize.width * 0.039, dSize.width * 0.03, dSize.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Padding(
                  padding:EdgeInsets.zero,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: dSize.height/7,
                        width: 150.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2.5),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/logo3.jpg"),
                          ),
                        ),
                      ),
                      Text(
                        'Vos Commandes'.toUpperCase(),
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
            
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      _MyListView(
                        onPress: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  new HistoriqueCommande(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.payment_rounded,
                          color: Colors.white,
                        ),
                        text: "Non Payées",
                      ),
                      _MyListView(
                        icon: Icon(
                          Icons.directions_bus_outlined,
                          color: Colors.white,
                        ),
                        text: "En attente de Livraison",
                      ),
                      _MyListView(
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                        ),
                        text: "Expédiées",
                      ),
                      _MyListView(
                        icon: Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                        text: "Annulées",
                      ),
                      _MyListView(
                        icon: Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                        text: "Terminées",
                      ),
                    ],
                  ),
                ),



                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 4,
                          color:
                              AppColors.scaffoldBackgroundYellowForWelcomePage,
                          child: Container(
                              padding: EdgeInsets.all(10),
                              width: dSize.width * 0.9,
                              child: Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    AppAssets.demandedevis,
                                    height: 25,
                                    width: sizeWidth * 0.1,
                                  ),
                                  // SizedBox(width: 4),
                                  Text(
                                    "Réclamations",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 23,
                                    color: AppColors.redAppbar,
                                  ),
                                ],
                              )),
                        ),
                       
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MyListView extends StatelessWidget {
  final String text;
  final Widget icon;
  final Function onPress;

  const _MyListView({
    @required this.text,
    this.icon,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Card(
        color: Color(0xFF020D1F),
        elevation: 10.0,
        child: ListTile(
          leading: icon,
          title: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// Constructor Data Orders
class qeueuItem extends StatelessWidget {
  @override
  static var _txtCustomOrder = TextStyle(
    color: Colors.black45,
    fontSize: 15.5,
    fontWeight: FontWeight.w800,
    fontFamily: "Gotik",
  );

  String icon, txtHeader;
  double paddingValue;

  qeueuItem({this.icon, this.txtHeader, this.paddingValue});

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new HistoriqueCommande()));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  icon,
                  width: 32,
                  height: 32,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 10.0,
                      right: mediaQueryData.padding.right + paddingValue),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(txtHeader, style: _txtCustomOrder),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
