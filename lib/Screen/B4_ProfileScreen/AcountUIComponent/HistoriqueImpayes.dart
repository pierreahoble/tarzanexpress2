import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:trevashop_v2/constants/appColors.dart';

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

Widget customColumn({@required String imgPath, @required String PrdName, @required String PrdPrice, @required String PrdQte}) {
  return Column(
    children: [
      Padding(
        padding:  EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              imgPath,
              width: 60,
              height: 60,
            ),
             OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.blue,
                        ),
                      ),
                      onPressed: () {
                          
                      },
                      child: Text(
                    "Détails",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
            Flexible(
              child: Column(
                children: [
                  Text(PrdName),
                  Text(PrdPrice +' X '+PrdQte)
                ],
                
              ),
            ),
          ],
        ),
      ),
      Divider(),
    ],
  );
}


class HistoriqueImpayes extends StatefulWidget {
  @override
  _HistoriqueImpayesState createState() => _HistoriqueImpayesState();
}

class _HistoriqueImpayesState extends State<HistoriqueImpayes> {
    List<bool> listOfExpanded = [];

TextStyle zStyle = TextStyle(fontSize: 13.0);
  @override
  void initState() {
    mounted
        ? setState(() {
            listOfExpanded = [
              for (var i = 0;
                  i <10;
                  i++)
                false
            ];
          })
        : listOfExpanded = [
            for (var i = 0;
                i < 10;
                i++)
              false
          ];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size dSize = MediaQuery.of(context).size;
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
            'Impayé(s)',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
                color: Colors.black54,
                fontFamily: "Gotik"),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Color(0xFF6991C7)),
        ),
        body: SingleChildScrollView(
          child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0;
            i < 10;
            i++)
          Card(
            elevation: 4,
            margin: EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Expanded(
                  child: ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        listOfExpanded[i] = !listOfExpanded[i];
                      });
                    },
                    children: [
                      ExpansionPanel(
                        isExpanded: listOfExpanded[i],
                        canTapOnHeader: true,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Date: 10/10/2021",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "A payer: 1500 (XOF)",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        body: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var j = 0; j < 4; j = j + 2)
                                customColumn(
                                  imgPath: "assets/img/baner4.png",
                                  PrdName: "Basket",
                                  PrdPrice: "3500",
                                  PrdQte: "4"
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 20),
                                child: GestureDetector(
                                  onTap: () {
                                     
                                  },
                                  child: Text(
                                    "Effectuer le paiement",
                                    style: zStyle.copyWith(color: AppColors.green),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ),
                ],
              ),
          ),
          ],
        ),
        ),
      ),
    );
  }
}

/// Constructor for Card
class creditCard extends StatelessWidget {
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
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 20.0, right: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'myPersonal',
                    style: _txtCustomHead.copyWith(
                        fontSize: 15.0, fontWeight: FontWeight.w600),
                  ),
                  Image.asset(
                    "assets/img/credit.png",
                    height: 30.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 5.0, left: 20.0, right: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'cardNumber',
                        style: _txtCustomSub,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child:
                            Text('numberCC'),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'exp',
                        style: _txtCustomSub,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text("12/29"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
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
                      Text(
                        'cardName',
                        style: _txtCustomSub,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text('nameCC'),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'cvv',
                        style: _txtCustomSub,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text('cvCC'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                height: 50.0,
                width: 1000.0,
                color: Colors.blueGrey.withOpacity(0.1),
                child: Center(
                    child: Text('editDetail',
                        style: _txtCustomHead.copyWith(
                            fontSize: 15.0, color: Colors.blueGrey))))
          ],
        ),
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
      padding: const EdgeInsets.only(
          top: 10.0, left: 15.0, right: 15.0, bottom: 10.0),
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
            ProduitsPart(),
            dataTransaction(
              date: 'datePayment1',
              item: 'itemPayment1',
              price: "\$ 50",
            ),
            dataTransaction(
              date: 'datePayment2',
              item: 'itemPayment2',
              price: "\$ 1000",
            ),
            dataTransaction(
              date: 'datePayment3',
              item: 'itemPayment3',
              price: "\$ 2500",
            ),
            dataTransaction(
              date: 'datePayment4',
              item: 'itemPayment4',
              price: "\$ 50",
            ),
            dataTransaction(
              date: 'datePayment5',
              item: 'itemPayment5',
              price: "\$ 50",
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

  dataTransaction({this.date, this.item, this.price});

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  date,
                  style: _txtCustomSub.copyWith(
                      color: Colors.black38,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                width: 130.0,
                child: Text(
                  item,
                  style: _txtCustomSub.copyWith(color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(price,
                  style: _txtCustomSub.copyWith(
                    color: Colors.redAccent,
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


class ProduitsPart extends StatefulWidget {
 
  @override
  _ProduitsPartState createState() => _ProduitsPartState();
}

class _ProduitsPartState extends State<ProduitsPart> {
  // List<bool> listOfExpanded = [];

  @override
  void initState() {
    // mounted
    //     ? setState(() {
    //         listOfExpanded = [
    //           for (var i = 0;
    //               i <
    //                   widget
    //                       .order.detailsCommande["colis"][0]["produits"].length;
    //               i++)
    //             false
    //         ];
    //       })
    //     : listOfExpanded = [
    //         for (var i = 0;
    //             i < widget.order.detailsCommande["colis"][0]["produits"].length;
    //             i++)
    //           false
    //       ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List parts(int i) => [
          "Nom", 'Commande Alibaba',
          "Description", 'Achats des produits',
          "Montant", "140000",
          "Quantité", "12",
          "Poids", "160 KG",
          "Statut", "En Cours",
        ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      
          Row(
            children: [
              // Expanded(
              //   child: ExpansionPanelList(
              //     expansionCallback: (int index, bool isExpanded) {
                    
              //     },
              //     children: [
              //       ExpansionPanel(
              //         // isExpanded: true,
              //         canTapOnHeader: true,
              //         headerBuilder: (BuildContext context, bool isExpanded) {
              //           return Padding(
              //             padding: const EdgeInsets.only(left: 10),
              //             child: Text(
              //               "Commande",
              //               textAlign: TextAlign.left,
              //               overflow: TextOverflow.ellipsis,
              //               style: TextStyle(
              //                 fontSize: 18.0,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //           );
              //         },
              //         body: Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 15),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
                            
              //                 customColumn(
              //                   firstPart: "parts(i)[j]",
              //                   secondPart: "parts(i)[j + 1]",
              //                 ),
              //               Padding(
              //                 padding:
              //                     const EdgeInsets.fromLTRB(10, 10, 10, 20),
              //                 child: GestureDetector(
              //                   onTap: () async {
              //                     /* print(
              //                         "LE LIEN EST : ${widget.order.detailsCommande["colis"][0]["produits"][i]["lien"]}"); */
              //                     // String gLien =
              //                     //     "${widget.order.detailsCommande["colis"][0]["produits"][i]["lien"] as String}";
              //                     // if (checkValidUrl(url: gLien)) {
              //                     //   Navigator.push(
              //                     //     context,
              //                     //     MaterialPageRoute(
              //                     //       builder: (context) => ViewProduct(
              //                     //         initialUrl: gLien,
              //                     //       ),
              //                     //     ),
              //                     //   );
              //                     // } else {
              //                     //   ScaffoldMessenger.of(context).showSnackBar(
              //                     //     SnackBar(
              //                     //       content: Text(
              //                     //         "Le lien associé est invalide ou expiré!",
              //                     //         textAlign: TextAlign.center,
              //                     //       ),
              //                     //       behavior: SnackBarBehavior.floating,
              //                     //       margin:
              //                     //           EdgeInsets.fromLTRB(15, 0, 15, 30),
              //                     //     ),
              //                     //   );
              //                     // }
              //                   },
                                
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
      ],
    );
  }
}
