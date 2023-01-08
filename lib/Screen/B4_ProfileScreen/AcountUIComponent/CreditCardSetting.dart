import 'package:provider/provider.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';

import '../../../providers/authentification_provider.dart';
import '../../../providers/transaction_provider.dart';
import '../../../services/shared_preferences.dart';

/// Custom Text Header
var _txtCustomHead = TextStyle(
  color: Colors.black54,
  fontSize: 17.0,
  fontWeight: FontWeight.w600,
  fontFamily: "Gotik",
);

/// Custom Text Detail
var _txtCustomSub = TextStyle(
  color: Colors.black38,
  fontSize: 13.5,
  fontWeight: FontWeight.w500,
  fontFamily: "Gotik",
);

class creditCardSetting extends StatefulWidget {
  @override
  _creditCardSettingState createState() => _creditCardSettingState();
}

class _creditCardSettingState extends State<creditCardSetting> {
  String nom, prenoms, token;
  var resultat, montant, montant_portefeuille;

  void initState() {
    // Provider.of<TransactionProvider>(context,listen: false);
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
        getTransaction(value);
      });
    });
  }

  getTransaction(String token) {
    TransactionProvider().getPortefeuilleAll(token).then((value) {
      setState(() {
        resultat = value;
        montant = resultat['montant'];
        montant_portefeuille = resultat['solde_portefeuille'];
        // print(resultat);
        return resultat;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop(false);
              },
              child: Icon(Icons.arrow_back)),
          elevation: 0.0,
          title: Text(
            'Portefeuille',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
                color: Colors.black54,
                fontFamily: "Gotik"),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Color(0xFF6991C7)),
        ),
        body: resultat == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 15.0, right: 15.0),
                        child: Stack(
                          children: <Widget>[
                            Image.asset(
                              "assets/img/creditCardVisa.png",
                              height: 170.0,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: mediaQuery.padding.top + 75.0),
                                  child: Text(
                                    'Mobile Money',
                                    style: _txtCustomHead.copyWith(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        letterSpacing: 3.5),
                                  ),
                                ),
                                // Padding(
                                //   padding: EdgeInsets.only(
                                //       top: mediaQuery.padding.top + 10.0,
                                //       left: 20.0,
                                //       right: 20.0),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: <Widget>[
                                //       Text(
                                //         'cardName',
                                //         style: _txtCustomSub.copyWith(
                                //             color: Colors.white),
                                //       ),
                                //       Text('cvv',
                                //           style: _txtCustomSub.copyWith(
                                //               color: Colors.white)),
                                //     ],
                                //   ),
                                // ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 40.0, top: 2.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      // Text('numberCC',
                                      //     style: _txtCustomSub.copyWith(
                                      //         color: Colors.white)),
                                      // Text('cvCC',
                                      //     style: _txtCustomSub.copyWith(
                                      //         color: Colors.white)),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 15.0, right: 20.0),
                        child: Text(
                          'Informations',
                          style: _txtCustomHead,
                        ),
                      ),
                      creditCard(
                          nom: nom,
                          prenoms: prenoms,
                          montant: montant.toString(),
                          portefeuille: montant_portefeuille.toString()),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 15.0, bottom: 10.0, right: 20.0),
                        child: Text(
                          'Dernieres activites du compte',
                          style: _txtCustomHead.copyWith(fontSize: 16.0),
                        ),
                      ),
                      transactionsDetail()
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

/// Constructor for Card
class creditCard extends StatelessWidget {
  final String nom, prenoms, montant, portefeuille;

  const creditCard(
      {@required this.nom,
      @required this.prenoms,
      @required this.montant,
      @required this.portefeuille});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4.5,
                spreadRadius: 1.0,
              )
            ]),
        child: Column(
          children: <Widget>[
            // Padding(
            //   padding:
            //       const EdgeInsets.only(top: 20.0, left: 20.0, right: 60.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       Text(
            //         'Mes informations',
            //         style: _txtCustomHead.copyWith(
            //             fontSize: 15.0, fontWeight: FontWeight.w600),
            //       ),
            //       Image.asset(
            //         "assets/img/credit.png",
            //         height: 30.0,
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       top: 20.0, bottom: 5.0, left: 20.0, right: 60.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //           // Text(
            //           //   'cardNumber',
            //           //   style: _txtCustomSub,
            //           // ),
            //           Padding(
            //             padding: const EdgeInsets.only(top: 5.0),
            //             child: Text('Nom '),
            //           ),
            //         ],
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //           // Text(
            //           //   'exp',
            //           //   style: _txtCustomSub,
            //           // ),
            //           Padding(
            //             padding: const EdgeInsets.only(top: 5.0),
            //             child: Text("Mike Nador"),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 20.0,
                right: 30.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nom :",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${nom}  ${prenoms}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 20.0,
                right: 30.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Solde sur le Compte",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${portefeuille ?? "0"}  XOF",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            montant != "0"
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      bottom: 30.0,
                      left: 20.0,
                      right: 30.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Text(
                            //   'cardName',
                            //   style: _txtCustomSub,
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                'Reste à Payer',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Text(
                            //   'cvv',
                            //   style: _txtCustomSub,
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                "${montant}",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Padding(padding: EdgeInsets.all(10)),
            Container(
                height: 50.0,
                width: 1000.0,
                color: Colors.green,
                child: Center(
                    child: GestureDetector(
                  onTap: () {},
                  child: Text('Récharger votre compte',
                      style: _txtCustomHead.copyWith(
                          fontSize: 15.0, color: Colors.white)),
                )))
          ],
        ),
      ),
    );
  }
}

/// Constructor for Transactions
class transactionsDetail extends StatefulWidget {
  @override
  State<transactionsDetail> createState() => _transactionsDetailState();
}

class _transactionsDetailState extends State<transactionsDetail> {
  dynamic transactions;
  String token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferencesClass.restore("token").then((onValue) {
      setState(() {
        print("token" + onValue.toString());
        TransactionProvider().getPortefeuilleAll(onValue).then((value) {
          transactions = value['transaction'];
          print(transactions);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, left: 0.0, right: 8.0, bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.5,
              spreadRadius: 1.0,
            )
          ],
        ),
        child: Column(
          children: <Widget>[
            dataTransaction(
              date: DateTime.now().toString(),
              item: 'Commandes',
              price: "xof 50",
            ),
            dataTransaction(
              date: DateTime.now().toString(),
              item: 'Ventes',
              price: "xof 1000",
              verifie: 1,
            ),
            dataTransaction(
              date: DateTime.now().toString(),
              item: 'Commandes',
              price: "xof 2500",
              verifie: 1,
            ),
            dataTransaction(
              date: DateTime.now().toString(),
              item: 'Ventes',
              price: "xof 50",
            ),
            dataTransaction(
              date: DateTime.now().toString(),
              item: 'Commandes',
              price: "xof 50",
              verifie: 1,
            ),
          ],
        ),
      ),
    );
  }
}

/// Constructor for Transactions Data
class dataTransaction extends StatelessWidget {
  @override
  String date, item, price;
  int verifie = 0;

  dataTransaction({this.date, this.item, this.price, this.verifie});

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  onPressed: () {},
                  icon: verifie == 1
                      ? Icon(
                          Icons.auto_graph,
                          color: Colors.green,
                          size: 35,
                        )
                      : Icon(
                          Icons.auto_graph,
                          color: Colors.red,
                          size: 35,
                        )),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  date,
                  style: _txtCustomSub.copyWith(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              // Container(
              //   width: 130.0,
              //   child: Text(
              //     item,
              //     style: _txtCustomSub.copyWith(color: Colors.black54),
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // ),
              Text(price,
                  style: _txtCustomSub.copyWith(
                    color: verifie == 1 ? Colors.green : Colors.redAccent,
                    fontSize: 16.0,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Divider(
            height: 0.5,
            color: Colors.black12,
          ),
        ),
      ],
    );
  }
}
