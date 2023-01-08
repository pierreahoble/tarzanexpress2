import 'package:flutter/material.dart';
import 'package:trevashop_v2/Model/adresse.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/B1_Home/Home.dart';
import 'package:trevashop_v2/Screen/B3_CartScreen/B3_Cart/B3_Cart_Screen.dart';
import 'package:trevashop_v2/Screen/B3_CartScreen/B3_Cart/livraison.dart';
import 'package:trevashop_v2/providers/commandExecution_provider.dart';
import 'package:trevashop_v2/providers/commande_provider.dart';
import 'package:trevashop_v2/services/localDatabase.dart';
import 'package:provider/provider.dart';
import 'package:trevashop_v2/services/shared_preferences.dart';

class Address extends StatefulWidget {
  final bool sendCommand;
  const Address({@required this.sendCommand});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  String pays = "";
  String ville = "";
  String quartier = "";
  String adresse1 = "";
  String adresse2 = "";
  int a_livraison;
  String token;
  int code = 0;
  bool validate_commande = false;
  bool showModal = false;
  bool showSuccess = false;
  List<dynamic> Products;
  @override
  void initState() {
    // TODO: implement initState
    SharedPreferencesClass.restore("token").then((onValue) {
      setState(() {
        token = onValue;
        print(token);
      });
    });
    Provider.of<CommandeProvider>(context, listen: false)
        .getProducts()
        .then((value) {
      setState(() {
        Products = value;
      });
    });
    super.initState();
  }

  GlobalKey<FormState> _formkey = GlobalKey();
  GlobalKey<FormState> _formkey1 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var Select = Provider.of<CommandExecution>(context);
    var CommandProv = Provider.of<CommandeProvider>(context);

    const IconData directions_boat_outlined =
        IconData(0xefc2, fontFamily: 'MaterialIcons');
    Widget returnTypeTransport() {
      if (Select.Type_Livraison == 15) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.flight), Text("par avion")],
        );
      } else if (Select.Type_Livraison == 16) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(directions_boat_outlined), Text("par bateau")],
        );
      } else {
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Aucun")],
        );
      }
    }

    Widget returnTypeMoyen() {
      if (Select.Moyen_Transport == 0) {
        return Text(" par avion");
      } else if (Select.Moyen_Transport == 1) {
        return Text(" par bateau");
      } else {
        Text("Aucun ");
      }
    }

    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Color(0xFF6991C7)),
            backgroundColor: Color(0xFF020D1F),
            leading: IconButton(
                onPressed: () {
                  if (validate_commande) {
                    Select.setMoyenTransport(2);
                    Select.setTypeLivraison(2);
                    Select.setValidateCommande(3);
                  }
                 Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
            // title: Text(
            //   "Vos Adresse",
            //   style: TextStyle(
            //       fontFamily: "Gotik",
            //       fontSize: 18.0,
            //       color: Colors.black54,
            //       fontWeight: FontWeight.w700),
            // ),
            elevation: 0.0,
            actions: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                title: Text(
                                  "AJOUTER UNE ADRESSE",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.blue),
                                ),
                                scrollable: true,
                                content: Column(
                                  children: [
                                    Form(
                                        key: _formkey1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // DropdownButton(
                                            //   hint: Text("Pays"),
                                            //   isExpanded: true,
                                            //   elevation: 30,
                                            //   items: [
                                            //     DropdownMenuItem<String>(
                                            //       child: Text('No Savings Category'),
                                            //       value: '',
                                            //     ),
                                            //   ],
                                            // ),
                                            Text("Pays"),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty ||
                                                    value == null) {
                                                  return "Vueillez remplir le champ";
                                                }
                                                return null;
                                              },
                                              onSaved: (newValue) {
                                                setState(() {
                                                  pays = newValue;
                                                });
                                              },
                                              onChanged: (value) {
                                                setState(() {
                                                  pays = value;
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text("Ville"),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty ||
                                                    value == null) {
                                                  return "Vueillez remplir le champ";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder()),
                                              onSaved: (newValue) {
                                                setState(() {
                                                  ville = newValue;
                                                });
                                              },
                                              onChanged: (value) {
                                                setState(() {
                                                  ville = value;
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text("QUARTIER"),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty ||
                                                    value == null) {
                                                  return "Vueillez remplir le champ";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder()),
                                              onSaved: (newValue) =>
                                                  quartier = newValue,
                                              onChanged: (value) {
                                                quartier = value;
                                              },
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text("DETAILS SUR ADRESSE"),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty ||
                                                    value == null) {
                                                  return "Vueillez remplir le champ";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder()),
                                              onSaved: (newValue) {
                                                setState(() {
                                                  adresse1 = newValue;
                                                });
                                              },
                                              onChanged: (value) {
                                                setState(() {
                                                  adresse1 = value;
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text("PRECISION"),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty ||
                                                    value == null) {
                                                  return "Vueillez remplir le champ";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder()),
                                              onSaved: (newValue) {
                                                adresse2 = newValue;
                                              },
                                              onChanged: (value) {
                                                setState(() {
                                                  adresse2 = value;
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                if (_formkey1.currentState
                                                    .validate()) {
                                                  setState(() {
                                                    LocalDatabaseManager()
                                                        .insertAdresse(Adresse(
                                                            pays: this.pays,
                                                            ville: this.ville,
                                                            quartier:
                                                                this.quartier,
                                                            adresse1:
                                                                this.adresse1,
                                                            adresse2:
                                                                this.adresse2));
                                                  });
                                                  Navigator.pop(context, true);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'Adresse ajoutée avec succès.'),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Text("VALIDER"),
                                              style: ElevatedButton.styleFrom(
                                                  minimumSize: Size(
                                                      double.infinity, 40)),
                                            )
                                          ],
                                        ))
                                  ],
                                )));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          Text("AJOUTER UNE ADRESSE")
                        ],
                      ))),
            ]),
        body: FutureBuilder<List<Adresse>>(
            future: LocalDatabaseManager().getAdresse(),
            builder: (context, listAdress) {
              if (listAdress.data == null) {
                return Center(child: CircularProgressIndicator());
              }
              return listAdress.data.length == 0
                  ? noItemCart()
                  : ListView.builder(
                      itemCount: listAdress.data.length,
                      itemBuilder: (context, position) {
                        return Card(
                          margin: EdgeInsets.all(10),
                          elevation: 8,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  widget.sendCommand==true?   ElevatedButton(
                                    
                                        onPressed: () {
                                          sendCommandeToApi(context, listAdress, position, returnTypeTransport, Select, CommandProv);
                                        },
                                        child: Text("Selectionnez")):Padding(padding: EdgeInsets.zero),
                                    Text(
                                      "Adresse:${listAdress.data[position].quartier}(${listAdress.data[position].ville},${listAdress.data[position].pays})",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    
                                  ],
                                ),
                               
                                    Row(
                                      children: [
                                        GestureDetector(
                                        onTap: () {
                                         updateAdresse(context, listAdress, position);
                                        },
                                        child:
                                            Icon(Icons.edit, color: Colors.blue)),
                                            SizedBox(width: 10,),
                                            GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        LocalDatabaseManager().deleteAdresse(
                                            listAdress.data[position].id);
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Adresse supprimée !.'),
                                        ),
                                      );
                                    },
                                    child:
                                        Icon(Icons.delete, color: Colors.red))
                                      ],
                                    ),
                                
                              ],
                            ),
                          ),
                        );
                      });
            }));
  }

  Future<dynamic> sendCommandeToApi(BuildContext context, AsyncSnapshot<List<Adresse>> listAdress, int position, Widget returnTypeTransport(), CommandExecution Select, CommandeProvider CommandProv) {
    return showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext context) =>
                                                    AlertDialog(
                                                      title: Center(
                                                        child: Text(
                                                            "Informations generales"),
                                                      ),
                                                      content: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            3,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                                "Details de votre commande :"),
                                                            Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          null,
                                                                      child: Icon(
                                                                          Icons.check),
                                                                      style: ElevatedButton.styleFrom(
                                                                          shape:
                                                                              CircleBorder()),
                                                                    ),
                                                                    Text(
                                                                        "Lieu de livraison")
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text("${listAdress.data[position].pays}" +
                                                                        " ,  ${listAdress.data[position].ville}"),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Column(children: [
                                                              Row(
                                                                children: [
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        null,
                                                                    child: Icon(
                                                                        Icons
                                                                            .check),
                                                                    style: ElevatedButton.styleFrom(
                                                                        shape:
                                                                            CircleBorder()),
                                                                  ),
                                                                  Text(
                                                                      "Transport:"),
                                                                ],
                                                              ),
                                                              returnTypeTransport()
                                                            ]),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Row(
                                                              children: [
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      null,
                                                                  child: Icon(
                                                                      Icons
                                                                          .check),
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    shape:
                                                                        CircleBorder(),
                                                                  ),
                                                                ),
                                                                Text("Quantité de produits :" +
                                                                    "${Products == null || Products == [] ? 0.toString() : Products.length.toString()}")
                                                              ],
                                                            ),
                                                            
                                                          ],
                                                        ),
                                                      ),
                                                      actions: [
                                                       ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                  primary: Color(0xFF020D1F),
                                                                    minimumSize: Size(
                                                                        double
                                                                            .infinity,
                                                                        40)),
                                                            onPressed: () {
                                                              Select
                                                                  .setValidateCommande(
                                                                      0);
                                                              CommandProv
                                                                      .getProducts()
                                                                  .then(
                                                                (value) {
                                                                  setState(
                                                                      () {
                                                                    Products =
                                                                        value;
                                                                  });

                                                                  setState(
                                                                      () {
                                                                    a_livraison =
                                                                        0;
                                                                  });
                                                                  print(listAdress
                                                                      .data[
                                                                          position]
                                                                      .adresse2);
                                                                  Select.sendCommands(
                                                                          Select.Type_Livraison,
                                                                          a_livraison,
                                                                          0,
                                                                          listAdress.data[position].pays,
                                                                          listAdress.data[position].ville,
                                                                          listAdress.data[position].quartier,
                                                                          listAdress.data[position].adresse1,
                                                                          listAdress.data[position].adresse2,
                                                                          Products,
                                                                          token)
                                                                      .then((value) {
                                                                    setState(
                                                                        () {
                                                                      code =
                                                                          value;
                                                                      
                                                                    });

                                                                    if (code ==
                                                                          200) {
                                                                       ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Commande passée avec succes")));
                                                                      }
                                                                  });
                                                                },
                                                              );
                                                            },
                                                            child: Text(
                                                                "Je confirme les informations"))
                                                      ],
                                                    ));
  }

  Future<dynamic> updateAdresse(BuildContext context, AsyncSnapshot<List<Adresse>> listAdress, int position) {
    return showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                                title: Text(
                                                  "MODIFIER UNE ADRESSE",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.blue),
                                                ),
                                                scrollable: true,
                                                content: Column(
                                                  children: [
                                                    Form(
                                                        key: _formkey,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text("Pays"),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            TextFormField(
                                                              validator:
                                                                  (value) {
                                                                if (value
                                                                        .isEmpty ||
                                                                    value ==
                                                                        null) {
                                                                  return "Vueillez remplir le champ";
                                                                }
                                                                return null;
                                                              },
                                                              decoration:
                                                                  InputDecoration(
                                                                enabledBorder:
                                                                    OutlineInputBorder(),
                                                              ),
                                                              initialValue:
                                                                  listAdress
                                                                      .data[
                                                                          position]
                                                                      .pays,
                                                              onChanged:
                                                                  (value) {
                                                                pays = value;
                                                              },
                                                              onSaved:
                                                                  (value) {
                                                                pays = value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text("Ville"),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            TextFormField(
                                                              validator:
                                                                  (value) {
                                                                if (value
                                                                        .isEmpty ||
                                                                    value ==
                                                                        null) {
                                                                  return "Vueillez remplir le champ";
                                                                }
                                                                return null;
                                                              },
                                                              decoration: InputDecoration(
                                                                  enabledBorder:
                                                                      OutlineInputBorder()),
                                                              initialValue:
                                                                  listAdress
                                                                      .data[
                                                                          position]
                                                                      .ville,
                                                              onChanged:
                                                                  (value) {
                                                                ville = value;
                                                              },
                                                              onSaved:
                                                                  (value) {
                                                                ville = value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text("QUARTIER"),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            TextFormField(
                                                              validator:
                                                                  (value) {
                                                                if (value
                                                                        .isEmpty ||
                                                                    value ==
                                                                        null) {
                                                                  return "Vueillez remplir le champ";
                                                                }
                                                                return null;
                                                              },
                                                              decoration: InputDecoration(
                                                                  enabledBorder:
                                                                      OutlineInputBorder()),
                                                              initialValue:
                                                                  listAdress
                                                                      .data[
                                                                          position]
                                                                      .quartier,
                                                              onChanged:
                                                                  (value) {
                                                                quartier =
                                                                    value;
                                                              },
                                                              onSaved:
                                                                  (value) {
                                                                quartier =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                                "DETAILS SUR ADRESSE"),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            TextFormField(
                                                              validator:
                                                                  (value) {
                                                                if (value
                                                                        .isEmpty ||
                                                                    value ==
                                                                        null) {
                                                                  return "Vueillez remplir le champ";
                                                                }
                                                                return null;
                                                              },
                                                              decoration: InputDecoration(
                                                                  enabledBorder:
                                                                      OutlineInputBorder()),
                                                              initialValue:
                                                                  listAdress
                                                                      .data[
                                                                          position]
                                                                      .adresse1,
                                                              onChanged:
                                                                  (value) {
                                                                adresse1 =
                                                                    value;
                                                              },
                                                              onSaved:
                                                                  (value) {
                                                                adresse1 =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text("PRECISION"),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            TextFormField(
                                                              validator:
                                                                  (value) {
                                                                if (value
                                                                        .isEmpty ||
                                                                    value ==
                                                                        null) {
                                                                  return "Vueillez remplir le champ";
                                                                }
                                                                return null;
                                                              },
                                                              decoration: InputDecoration(
                                                                  enabledBorder:
                                                                      OutlineInputBorder()),
                                                              initialValue:
                                                                  listAdress
                                                                      .data[
                                                                          position]
                                                                      .adresse2,
                                                              onChanged:
                                                                  (value) {
                                                                adresse2 =
                                                                    value;
                                                              },
                                                              onSaved:
                                                                  (value) {
                                                                adresse2 =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                if (_formkey
                                                                    .currentState
                                                                    .validate()) {
                                                                  setState(
                                                                      () {
                                                                    LocalDatabaseManager().updateAdresse(Adresse(
                                                                        id: listAdress
                                                                            .data[
                                                                                position]
                                                                            .id,
                                                                        pays: this
                                                                            .pays,
                                                                        ville: this
                                                                            .ville,
                                                                        quartier: this
                                                                            .quartier,
                                                                        adresse1: this
                                                                            .adresse1,
                                                                        adresse2:
                                                                            this.adresse2));
                                                                  });
                                                                }
                                                                Navigator.pop(
                                                                    context,
                                                                    true);
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  const SnackBar(
                                                                    content: Text(
                                                                        'Adresse modifiée avec succès.'),
                                                                  ),
                                                                );
                                                              },
                                                              child: Text(
                                                                  "VALIDER"),
                                                              style: ElevatedButton.styleFrom(
                                                                  minimumSize: Size(
                                                                      double
                                                                          .infinity,
                                                                      40)),
                                                            )
                                                          ],
                                                        ))
                                                  ],
                                                )));
  }
}
