import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trevashop_v2/Model/CartItemData.dart';
import 'package:trevashop_v2/Model/product.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/B1_Home/Home.dart';
import 'package:trevashop_v2/Screen/B3_CartScreen/B3_Cart/livraison.dart';

import 'package:trevashop_v2/providers/commande_provider.dart';

import 'package:trevashop_v2/services/paySelection_services.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../constants/Api.dart';
import '../../../providers/commandExecution_provider.dart';
import '../../../services/shared_preferences.dart';

class Finalisation extends StatefulWidget {
  @override
  State<Finalisation> createState() => _FinalisationState();
}

class _FinalisationState extends State<Finalisation> {
  List<dynamic> ville, agences = [];
  List<dynamic> pays = [];

  int currentStep = 0;
  int statusCode = 0;
  String id_pays = "2";
  String id_ville = "1";
  String id_agence = "1";
  String old_idVille, old_idpays;

  String villeAgence;
  bool loadcities = false;
  bool ville_step = false;
  bool isload = false;
  bool loading_countries = false;
  bool validate_commande = false;
  int a_livraison;
  List<Product> Products;
  String token;

  filtreVille() {
    var temp;

    temp = ville.where((element) => element.id.toString() == id_ville);
    return temp;
  }

  filtreAgence() {
    var temp;
    temp = agences.where((element) => element.id.toString() == id_agence);
    return temp;
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      loading_countries = true;
    });
    getCountries().then((value) {
      setState(() {
        pays = value;
        loading_countries = false;
      });
    });
    super.initState();
    SharedPreferencesClass.restore("token").then((onValue) {
      setState(() {
        token = onValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var CommandProv = Provider.of<CommandeProvider>(context);
    var Select = Provider.of<CommandExecution>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF020D1F),
        leading: IconButton(
          onPressed: () {
            if (validate_commande) {
              Select.setMoyenTransport(2);
              Select.setTypeLivraison(2);
            }
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("SELECTONNEZ VOTRE AGENCE"),
        centerTitle: true,
      ),
      body: LoaderOverlay(
          child: loading_countries
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stepper(
                  currentStep: currentStep,
                  type: StepperType.vertical,
                  onStepCancel: () {
                    if (currentStep > 0) {
                      setState(() {
                        currentStep--;
                        old_idpays = id_pays;
                        old_idVille = id_ville;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('veuillez appuyer sur continue')));
                    }
                  },
                  onStepContinue: () {
                    if (currentStep == 0) {
                      print(old_idpays + " " + id_pays);

                      if (old_idpays == id_pays) {
                        if (currentStep != 2) {
                          setState(() {
                            currentStep += 1;
                          });
                        }
                      } else {
                        context.loaderOverlay.show();
                        getCities(id_pays).then((city) {
                          setState(() {
                            ville = city;
                          });

                          if (currentStep != 2) {
                            setState(() {
                              currentStep += 1;
                            });

                            context.loaderOverlay.hide();
                          }
                        });
                      }
                    } else if (currentStep == 1) {
                      if (old_idVille == id_ville) {
                        if (currentStep != 2) {
                          setState(() {
                            currentStep += 1;
                          });
                        }
                      } else {
                        context.loaderOverlay.show();
                        getAgences(id_ville).then((value) {
                          setState(() {
                            agences = value;
                            print(agences[0].nom);
                          });

                          if (currentStep != 2) {
                            setState(() {
                              currentStep += 1;
                            });

                            context.loaderOverlay.hide();
                          }
                        });
                      }
                    } else if (currentStep == 2) {
                      setState(() {
                        loading_countries = true;
                      });
                      CommandProv.getProducts().then(
                        (value) {
                          print(value.toString());
                          setState(() {
                            Products = value;
                          });
                          setState(() {
                            a_livraison = 1;
                          });
                          var agence = filtreAgence();

                           print(Products.toList().toString());
                          Select.sendCommands(
                                  Select.Type_Livraison,
                                  a_livraison,
                                  int.parse(id_agence),
                                  agence.first.pays,
                                  agence.first.ville,
                                  agence.first.quartier,
                                  agence.first.adresse1,
                                  agence.first.adresse2,
                                  Products,
                                  token)
                              .then((value) {
                            setState(() {
                              statusCode = value;
                            });

                            setState(() {
                              isload = false;
                              validate_commande = true;
                            });

                            if (statusCode == 200) {
                              setState(() {
                                loading_countries = false;
                              });
                              return showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                shape: CircleBorder(),
                                                primary: Colors.green,
                                                elevation: 0),
                                          ),
                                          Text("Success")
                                        ],
                                      )),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Home()));
                                        },
                                        child: Text("ok"))
                                  ],
                                ),
                              );
                            } else {
                              setState(() {
                                loading_countries = false;
                              });
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                      content: Text(
                                          "Une erreur s'est produite , vueillez réesseyer plus tard")));
                            }
                          });
                        },
                      );
                    }
                  },
                  steps: [
                      Step(
                        isActive: currentStep >= 0,
                        title: Text("pays de livraison"),
                        content: DropdownButton(
                            hint: Text("Pays"),
                            value: id_pays,
                            isExpanded: true,
                            elevation: 30,
                            onChanged: (value) {
                              setState(() {
                                old_idpays = id_pays;
                                id_pays = value;
                                loadcities = true;
                              });
                            },
                            items: pays?.map((e) {
                                  return DropdownMenuItem(
                                      value: e.id.toString(),
                                      child: Text("${e.nom}"));
                                })?.toList() ??
                                []),
                      ),
                      Step(
                        isActive: currentStep >= 1,
                        title: Text("ville de la livraison"),
                        content: DropdownButton(
                            value: id_ville,
                            hint: ville == null || ville == []
                                ? Text("Ville indisponible")
                                : Text("Ville"),
                            isExpanded: true,
                            elevation: 30,
                            onChanged: (value) {
                              setState(() {
                                old_idVille = id_ville;
                                id_ville = value;
                              });
                            },
                            items: ville?.map((e) {
                                  return DropdownMenuItem(
                                      value: ville == null || ville == []
                                          ? ""
                                          : e.id.toString(),
                                      child: ville == null || ville == []
                                          ? Text("ville indisponible")
                                          : Text("${e.nom}"));
                                })?.toList() ??
                                []),
                      ),
                      Step(
                        isActive: currentStep >= 2,
                        title: Text("agence de la livraison"),
                        content: DropdownButton(
                            value: id_agence,
                            hint: agences == null || agences == []
                                ? Text("agences indisponible")
                                : Text("agences"),
                            isExpanded: true,
                            elevation: 30,
                            onChanged: (value) {
                              setState(() {
                                id_agence = value;
                                getAgences(id_ville).then((value) {
                                  agences = value;

                                  if (currentStep != 2) {
                                    setState(() {
                                      currentStep++;
                                    });
                                  }
                                });
                              });
                              print(id_agence);
                            },
                            items: agences?.map((e) {
                                  return DropdownMenuItem(
                                      value: agences == null || agences == []
                                          ? ""
                                          : e.id.toString(),
                                      child: agences == null || agences == []
                                          ? ""
                                          : Text("${e.nom}"));
                                })?.toList() ??
                                []),
                      ),
                    ])),
    );
  }
}
