import 'package:provider/provider.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/HomeUIComponent/AppBar_Component/commandChat.dart';
import 'package:trevashop_v2/services/commande_services.dart';

import '../../../providers/commande_provider.dart';
import '../../../providers/transaction_provider.dart';
import '../../../services/shared_preferences.dart';
import '../../portefeuille_pay.dart';
import '../../webview.dart';

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

class commandDetail extends StatefulWidget {
  final int id;
  final String token;
  const commandDetail({@required this.id, @required this.token});
  @override
  _commandDetailState createState() => _commandDetailState();
}

class _commandDetailState extends State<commandDetail> {
  var result;
  int id;
  var lien;
  var m2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCommandDetail();
  }

// (int.parse(widget.result['montant_commande']) + int.parse(widget.result['montant_service']))

  getCommandDetail() async {
    await CommandeProvider()
        .getCommandsDetails(widget.token, widget.id)
        .then((value) {
      setState(() {
        result = value;
        print("value:===MIke");
        lien = value['produits'][0]['lien'].toString();
        m2 = value['montant_commande'] + value['montant_service'];
        print('le  montant ' + m2.toString());
        print("value:" + value['montant_commande'].toString());
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
            'Detail commande'.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
                fontFamily: "Gotik"),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF020D1F),
          iconTheme: IconThemeData(color: Color(0xFF6991C7)),
        ),
        body: result == null
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
                            Container(
                              height: 150,
                              child: Image.asset(
                                "assets/img/creditCardVisa.png",
                                // height: 190.0,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 45.0, horizontal: 20.0),
                                  child: Text(
                                    '${result['statut']['param1']}',
                                    style: _txtCustomHead.copyWith(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        letterSpacing: 3.5),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(05),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OutlinedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.red.shade300,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopWebview(
                                              brand: lien.toString(),
                                              WebsiteName: "Mon produit".toUpperCase(),
                                            )),
                                  );
                                },
                                child: Text(
                                  "Voir le produit",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Color(0xFF020D1F),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CommandChat(
                                                id: widget.id,
                                                reference:result['reference'],
                                              )));
                                },
                                child: Text(
                                  "Discuter de la commande",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      creditCard(
                        result: result,
                        id: widget.id,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

/// Constructor for Card
class creditCard extends StatefulWidget {
  final dynamic result;
  final int id;

  const creditCard({@required this.result, this.id});

  @override
  State<creditCard> createState() => _creditCardState();
}

class _creditCardState extends State<creditCard> {
  String token;
  String montantDeLaCommande;
  String montantDeLaCommandeTotal;
  var resultats;
  var res;
  var mode;
  var m2;
  bool verifier = false;

  void payerUnepartie() {
    TransactionProvider()
        .getMontantValeur(token, widget.result['id'].toString(), 'commande')
        .then((value) {
      res = value;
      montantDeLaCommande = value['montant_commande'].toString();
      print(montantDeLaCommande);
      return montantDeLaCommande;
    });
  }

  void payerTotalite() {
    TransactionProvider()
        .getMontantValeur(token, widget.result['id'].toString(), 'total')
        .then((value) {
      res = value;
      montantDeLaCommandeTotal = value['montant_total'].toString();
      print(montantDeLaCommandeTotal);
      // return montantDeLaCommande;
    });
  }

  getCommandDetail(token) async {
    await CommandeProvider().getCommandsDetails(token, widget.id).then((value) {
      setState(() {
        print('moi Value');
        resultats = value;
        print("value:" + value.toString());
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      payerUnepartie();
      payerTotalite();
    });

    SharedPreferencesClass.restore('token').then((value) {
      token = value;
      getCommandDetail(value);
      setState(() {
        TransactionProvider().ModePaiement(token).then((value) {
          mode = value;
          print(mode);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    @override
    void _monBottomsheet() {
      showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Container(
                      color: Colors.red,
                      height: 50,
                      child: Center(
                          child: Text(
                        'Choisir la façon vous payer',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))),
                  ListTile(
                    // leading: Icon(Icons.payment),
                    title: Text(
                      "Payer Une partie",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    onTap: () {
                      payerUnepartie();
                      Navigator.pop(context);
                      print(mode.toString());
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new PortefeuillePay(
                            mode: mode,
                            token: token,
                            id: resultats['id'].toString(),
                            montantDeLacommande: montantDeLaCommande,
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    // leading: Icon(Icons.payment),
                    title: Text(
                      "Payer la totalité",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    onTap: () {
                      // payerTotalite();
                      payerTotalite();
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new PortefeuillePay(
                            mode: mode,
                            token: token,
                            id: resultats['id'].toString(),
                            montantDeLacommande: montantDeLaCommandeTotal,
                          ),
                        ),
                      );
                    },
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 15.0, right: 15.0, bottom: 15.0),
      child: Column(
        children: [
          Container(
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
                widget.result['reference'] == null
                    ? Padding(padding: EdgeInsets.zero)
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 20.0,
                          right: 30.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Reference",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${widget.result['reference']}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                //   fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                widget.result['montant_commande'] == null
                    ? Padding(padding: EdgeInsets.zero)
                    : Divider(),
                widget.result['montant_commande'] == null
                    ? Padding(padding: EdgeInsets.zero)
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 20.0,
                          right: 30.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Montant de la commande",
                              style: TextStyle(
                                //color: Colors.green,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${widget.result['montant_commande']} XOF",
                              style: TextStyle(
                                // color: Colors.green,
                                fontSize: 15,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                widget.result['montant_commande'] == null &&
                        widget.result['montant_service'] == null
                    ? Padding(padding: EdgeInsets.zero)
                    : Divider(),
                widget.result['montant_commande'] == null &&
                        widget.result['montant_service'] == null
                    ? Padding(padding: EdgeInsets.zero)
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 20.0,
                          right: 30.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Montant Total",
                              style: TextStyle(
                                //color: Colors.green,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${(widget.result['montant_commande'] + widget.result['montant_service']).toString()} XOF",
                              style: TextStyle(
                                // color: Colors.green,
                                fontSize: 15,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                widget.result['montant_service'] == null
                    ? Padding(padding: EdgeInsets.zero)
                    : Divider(),
                widget.result['montant_service'] == null
                    ? Padding(padding: EdgeInsets.zero)
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 20.0,
                          right: 30.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Frais de service",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${widget.result['montant_service']}" + " XOF",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                //   fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                Divider(),
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
                        "Livraison à domicile",
                        style: TextStyle(
                          // color: Colors.green,
                          color: Colors.black,
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                     widget.result['colis'][0]['agence_id']==1?   "Non":"oui",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          //   fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.result['details_commande']['date_prevu_livraison_min'] ==
                        null
                    ? Padding(padding: EdgeInsets.zero)
                    : Divider(),
                widget.result['details_commande']['date_prevu_livraison_min'] ==
                        null
                    ? Padding(padding: EdgeInsets.zero)
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 20.0,
                          right: 30.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Date min",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${widget.result['details_commande']['date_prevu_livraison_min']}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                //   fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                widget.result['details_commande']['date_prevu_livraison_max'] ==
                        null
                    ? Padding(padding: EdgeInsets.zero)
                    : Divider(),
                widget.result['details_commande']['date_prevu_livraison_max'] ==
                        null
                    ? Padding(padding: EdgeInsets.zero)
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 20.0,
                          right: 30.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Date max",
                              style: TextStyle(
                                // color: Colors.green,
                                color: Colors.black,
                                fontSize: 15,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${widget.result['details_commande']['date_prevu_livraison_max'].toString()}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                //   fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                widget.result['colis'][0]['poids'] == null
                    ? Padding(padding: EdgeInsets.zero)
                    : Divider(),
                widget.result['colis'][0]['poids'] == null
                    ? Padding(padding: EdgeInsets.zero)
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 20.0,
                          right: 30.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Poids",
                              style: TextStyle(
                                //color: Colors.green,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${widget.result['colis'][0]['poids'].toString()} Kg",
                              // "${result['colis'][0]['poids']} ",
                              style: TextStyle(
                                // color: Colors.green,
                                fontSize: 15,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                widget.result['colis'][0]['volume'] == null
                    ? Padding(padding: EdgeInsets.zero)
                    : Divider(),
                widget.result['colis'][0]['volume'] == null
                    ? Padding(padding: EdgeInsets.zero)
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 20.0,
                          right: 30.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Volume",
                              style: TextStyle(
                                //color: Colors.green,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${widget.result['colis'][0]['volume'].toString()}",
                              // "${result['colis'][0]['poids']} ",
                              style: TextStyle(
                                // color: Colors.green,
                                fontSize: 15,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                widget.result['colis'][0]['transport'] == null
                    ? Padding(padding: EdgeInsets.zero)
                    : Divider(),
                widget.result['colis'][0]['transport'] == null
                    ? Padding(padding: EdgeInsets.zero)
                    : Padding(
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
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Transport',
                                    style: TextStyle(
                                      //  color: Colors.red,
                                      fontSize: 15,
                                      //  fontWeight: FontWeight.w900,
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
                                    '${widget.result['colis'][0]['transport'].toString()} XOF',
                                    style: TextStyle(
                                      // color: Colors.red,
                                      fontSize: 15,
                                      //fontWeight: FontWeight.w900
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                widget.result['statut']['param1'] == "En cours de traitement"
                    ? Container(
                        height: 50.0,
                        width: 1000.0,
                        color: Colors.grey,
                        child: Center(
                          child: Text(
                            'En Cours de traitement...',
                            style: _txtCustomHead.copyWith(
                                fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                      )
                    : Container(
                        height: 50.0,
                        width: 1000.0,
                        color: Colors.red.shade400,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              _monBottomsheet();
                            },
                            child: Text('Payer la commande',
                                style: _txtCustomHead.copyWith(
                                    fontSize: 15.0, color: Colors.white)),
                          ),
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

class MyBottomSheetChoixPaiement extends StatefulWidget {
  final int id;
  final String token;
  const MyBottomSheetChoixPaiement({@required this.id, @required this.token});

  @override
  State<MyBottomSheetChoixPaiement> createState() =>
      _MyBottomSheetChoixPaiementState();
}

class _MyBottomSheetChoixPaiementState
    extends State<MyBottomSheetChoixPaiement> {
  var result;
  String token;
  String montant;
  var mode;

  getCommandDetail() async {
    await CommandeProvider()
        .getCommandsDetails(widget.token, widget.id)
        .then((value) {
      setState(() {
        result = value;
        print("value:" + value.toString());
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferencesClass.restore('token').then((value) {
      token = value;
      getCommandDetail();
      setState(() {
        TransactionProvider().ModePaiement(token).then((value) {
          mode = value;
          print(mode);
        });
      });
    });
  }

  // ignore: missing_return
  String payer() {
    TransactionProvider()
        .getMontantValeur(token, result['id'].toString(), 'commande')
        .then((value) {
      montant = value['montant_commande'].toString();
      return montant;
    });
  }

  @override
  Widget build(BuildContext context) {
    _onPressedShowModalPort() {
      showDialog(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
          title: new Text(
            'RECAPITULATION',
            textAlign: TextAlign.center,
          ),
          content: Column(
            children: [
              Text("Montant a payer"),
              SizedBox(
                height: 20,
              ),
              Text("${montant}"),
              Container(
                padding: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                width: 350,
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 12),
                    border: InputBorder.none,
                    label: Text("votre Mot de passe"),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Valider")),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
              height: 50,
              child: Center(
                  child: Text(
                'Choisir la façon vous payer',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ))),
          ListTile(
            // leading: Icon(Icons.payment),
            title: Text(
              "Payer Une partie",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            onTap: () {
              payer();
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new PortefeuillePay(
                        montant: result,
                        mode: mode,
                      )));
            },
          ),
          ListTile(
            // leading: Icon(Icons.payment),
            title: Text(
              "Payer la totalité",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            onTap: () {
              _onPressedShowModalPort();
            },
          ),
          SizedBox(
            height: 20,
          ),
          Container(
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
              children: [
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
                        "Reference colis",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${result['details_commande']['colis'][0]['reference'].toString()}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          //   fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
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
                        "Poids",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${result['details_commande']['colis'][0]['poids'].toString()}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          //   fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
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
                        "Volume",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${result['details_commande']['colis'][0]['volume'].toString()}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          //   fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
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
                        "Volume",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${result['details_commande']['colis'][0]['volume'].toString()}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          //   fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("payer commande"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 40)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

/// Constructor for Transactions
class transactionsDetail extends StatelessWidget {
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





////Bottom Sheet 

