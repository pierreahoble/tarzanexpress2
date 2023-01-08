import 'dart:convert';

import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:trevashop_v2/Model/CartItemData.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:trevashop_v2/Screen/B3_CartScreen/B3_Cart/livraison.dart';
import 'package:trevashop_v2/Screen/B3_CartScreen/CartUIComponent/Delivery.dart';
import 'package:trevashop_v2/Screen/ItemSelected.dart';
import 'package:trevashop_v2/providers/commande_provider.dart';
import 'package:trevashop_v2/state/panierState.dart';
import 'package:provider/provider.dart';

import '../../../Model/product.dart';
import '../../webview.dart';

class Cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<Cart> {
  List<dynamic> allProduct;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        setState(() {
          Provider.of<PanierState>(context, listen: false).getProducts();
          Provider.of<PanierState>(context, listen: false).clearSlelected();
        });
      } catch (e) {}
    });

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        setState(() {
          Provider.of<PanierState>(context, listen: false).clearSlelected();
        });
      } catch (e) {}
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    var basketProvider = Provider.of<PanierState>(context);
    var select = Provider.of<PanierState>(context).selected;
    var crud = Provider.of<CommandeProvider>(context);

    return EasyLocalizationProvider(
        data: data,
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Color(0xFF6991C7)),
              // centerTitle: true,
              backgroundColor: Colors.white,
              title: Text(
                "Panier",
                style: TextStyle(
                    fontFamily: "Gotik",
                    fontSize: 18.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700),
              ),
              elevation: 0.0,
              actions: [
            basketProvider.allTake==false?GestureDetector(
                        onTap: (){
                          basketProvider.selectAll();
                        },
                        child: Card(
                          color: Colors.black,
                            child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: Text(
                              "Tout prendre",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                      ):GestureDetector(
                        onTap: (){
                          basketProvider.removeAll();
                        },
                        child: Card(
                          color: Colors.grey,
                            child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: Text(
                              "Tout retirer",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                      ),
                if (select != null && select.length != 0)
                  Row(
                    children: [
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                             // basketProvider.removeAll()
                                    Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Livraison())) 
                                  ;
                            },
                            child:
                                Text("Passer la commande (${select.length})")),
                      ),
                    ],
                  )
                else
                  Padding(padding: EdgeInsets.zero)
              ],
            ),

            ///
            ///
            /// Checking item value of cart
            ///
            ///
            body: Consumer<PanierState>(builder: (context, a, _) {
              if (a.contentPanier == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (a.contentPanier.length == 0) {
                  return noItemCart();
                } else {
                  return ListView(
                    children: [
                      for (var i = 0; i < a.contentPanier.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 0.0, right: 0.0),

                          /// Background Constructor for card
                          child: Container(
                            height: 180.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  blurRadius: 3.5,
                                  spreadRadius: 0.4,
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.all(5.0),

                                        /// Image item
                                        child: Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                basketProvider.contentOrRemove(
                                                    a.contentPanier[i]);
                                              },
                                              child:
                                                  basketProvider.productInCard(
                                                          a.contentPanier[i])
                                                      ? Icon(Icons.check)
                                                      : null,
                                              style: ElevatedButton.styleFrom(
                                                  shape: CircleBorder(),
                                                  primary: basketProvider
                                                          .productInCard(a
                                                              .contentPanier[i])
                                                      ? Colors.green
                                                      : Colors.grey,
                                                  elevation: 0),
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.1),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black12
                                                              .withOpacity(0.1),
                                                          blurRadius: 0.5,
                                                          spreadRadius: 0.1)
                                                    ]),
                                                child: a.contentPanier[i]
                                                            .images !=
                                                        "null"
                                                    ? Image.memory(
                                                        base64Decode(a
                                                            .contentPanier[i]
                                                            .images),
                                                        height: 130.0,
                                                        width: 120.0,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Container(
                                                        height: 130.0,
                                                        width: 120.0,
                                                        color: Colors.grey,
                                                        child: Center(
                                                            child: Text(
                                                                "Pas d'image")),
                                                      ))
                                          ],
                                        )),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25.0, left: 10.0, right: 5.0),
                                        child: Column(
                                          /// Text Information Item
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${a.contentPanier[i].nom}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Sans",
                                                color: Colors.black87,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10.0)),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 18.0, left: 0.0),
                                              child: Container(
                                                width: 112.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white70,
                                                    border: Border.all(
                                                        color: Colors.black12
                                                            .withOpacity(0.1))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    /// Decrease of value item
                                                    InkWell(
                                                      onTap: () {
                                                        basketProvider
                                                            .decreaseNumber(
                                                                a.contentPanier[
                                                                    i]);
                                                      },
                                                      child: Container(
                                                        height: 30.0,
                                                        width: 30.0,
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                right: BorderSide(
                                                                    color: Colors
                                                                        .black12
                                                                        .withOpacity(
                                                                            0.1)))),
                                                        child: Center(
                                                            child: Text("-")),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 18.0),
                                                      child: Text(a
                                                          .contentPanier[i]
                                                          .quantite
                                                          .toString()),
                                                    ),

                                                    /// Increasing value of item
                                                    InkWell(
                                                      onTap: () {
                                                        basketProvider
                                                            .increaseNumber(
                                                                a.contentPanier[
                                                                    i]);
                                                      },
                                                      child: Container(
                                                        height: 30.0,
                                                        width: 28.0,
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                left: BorderSide(
                                                                    color: Colors
                                                                        .black12
                                                                        .withOpacity(
                                                                            0.1)))),
                                                        child: Center(
                                                            child: Text("+")),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              settings: RouteSettings(
                                                                  arguments: a
                                                                      .contentPanier[
                                                                          i]
                                                                      .id),
                                                              builder:
                                                                  (context) =>
                                                                      ItemSelected(
                                                                        productUrl: a
                                                                            .contentPanier[i]
                                                                            .lien,
                                                                        productName: a
                                                                            .contentPanier[i]
                                                                            .nom,
                                                                        productDescription: a
                                                                            .contentPanier[i]
                                                                            .description,
                                                                        productQuantite: a
                                                                            .contentPanier[i]
                                                                            .quantite,
                                                                      )));
                                                    },
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: Colors.blue,
                                                    )),
                                                IconButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        crud
                                                            .deleteContentPanierElement(
                                                                id: a
                                                                    .contentPanier[
                                                                        i]
                                                                    .id)
                                                            .then((value) {});
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  'Produit supprimee')));
                                                      /*   showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Confirmation"),
                                      content: Text(
                                          "Voulez-vous supprimer ce produit du panier?"),
                                      actions: [
                                        TextButton(
                                          child: Text("OUI",
                                              style: TextStyle(
                                                  color: Colors.red)),
                                          onPressed: () {
                                            
                                            setState(() {
                                              crud.deleteContentPanierElement(
                                                id: a.contentPanier[i]
                                                    .id).then((value){
                                                      Navigator.pop(context);
                                                    });
                                            });
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            "NON",
                                            style: TextStyle(
                                                color: Colors.blue),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  },
                                ); */
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    )),
                                                IconButton(
                                                    onPressed: () async {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    ShopWebview(
                                                                      brand: a
                                                                          .contentPanier[
                                                                              i]
                                                                          .lien,
                                                                      WebsiteName:
                                                                          "Produit",
                                                                    )),
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.remove_red_eye,
                                                      color: Colors.green,
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(top: 8.0)),
                              ],
                            ),
                          ),
                        )
                    ],
                  );
                }
              }
            })));

    /* FutureBuilder(
              future:allProduct ,
              builder: (context, ) {
                if (.data == null) {
                  return Center(child: CircularProgressIndicator());
                }
                return .data.length == 0
                    ? noItemCart()
                    : panierItems(, basketProvider, crud);
              }),
        )); */
  }
}

///
///
/// If no item cart this class showing
///
class noItemCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      color: Colors.white,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: mediaQueryData.padding.top + 50.0)),
            Image.asset(
              "assets/imgIllustration/IlustrasiCart.png",
              height: 300.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Text(
              "Aucun",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.5,
                  color: Colors.black26.withOpacity(0.2),
                  fontFamily: "Popins"),
            ),
          ],
        ),
      ),
    );
  }
}
