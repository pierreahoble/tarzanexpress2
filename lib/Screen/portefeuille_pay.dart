import 'package:flutter/material.dart';

import '../constants/appColors.dart';
import '../providers/transaction_provider.dart';
import '../services/shared_preferences.dart';
import 'B4_ProfileScreen/AcountUIComponent/CommandeDetail.dart';

class PortefeuillePay extends StatefulWidget {
  String montant;
  var mode;
  String token;
  String id;
  String montantDeLacommande; //Designe la façon l'utilisateur paie sa commande

  PortefeuillePay(
      {this.montant,
      @required this.mode,
      @required this.token,
      @required this.id,
      @required this.montantDeLacommande,
      Key key})
      : super(key: key);

  @override
  State<PortefeuillePay> createState() => _PortefeuillePayState();
}

class _PortefeuillePayState extends State<PortefeuillePay> {
  String dropdownValue = "";
  List<dynamic> items;
  String montant, token, phone_number, cmd_id;
  bool progress = false;
  TextEditingController password = new TextEditingController();

  void myShowModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
        title: new Text(
          'RECAPITULATIF DE PAIEMENT',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: AppColors.green),
        ),
        content: Container(
          height: 130,
          child: Column(
            children: [
              Text(
                "Paiement éffectué avec succès d'un montant de ${montant} XOF",
                style: TextStyle(fontSize: 17.0),
              ),
              SizedBox(
                height: 20,
              ),
              Icon(Icons.check_circle, color: AppColors.green, size: 50),
            ],
          ),
        ),
        actions: <Widget>[
          Container(
            width: double.infinity,
            // color: AppColors.green,
            decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Valider",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recupData();

    setState(() {
      dropdownValue = widget.mode['data'][0]['nom'].toString();
      items = widget.mode['data'];
      print(items);
      montant = widget.montantDeLacommande;
      print(widget.montantDeLacommande);
    });
  }

  bool visibilite = false;

  void _onSubmit() async {
    progress = true;
    var response;
    // print(password.text);
    response = await TransactionProvider().payement(
        token, dropdownValue, montant, phone_number, cmd_id, password.text);
    if (response['status'] == 200) {
      setState(() {
        progress = false;
        myShowModal();
        password.text = '';
      });
      // print(response);

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     duration: Duration(seconds: 5),
      //     backgroundColor: AppColors.green,
      //     content: Text(
      //       response['message'].toString(),
      //       textAlign: TextAlign.center,
      //       style: TextStyle(color: Colors.white, fontSize: 13.0),
      //     ),
      //     behavior: SnackBarBehavior.floating,
      //     margin: EdgeInsets.fromLTRB(18, 0, 18, 49),
      //   ),
      // );
      // Navigator.of(context).pop(
      //   PageRouteBuilder(
      //     pageBuilder: (_, __, ___) => new commandDetail(
      //       id: int.parse(cmd_id),
      //       token: token,
      //     ),
      //   ),
      // );
    } else if (response['status'] == 422) {
      setState(() {
        progress = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: AppColors.red,
          content: Text(
            response['message'].toString(),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 15.0),
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.fromLTRB(18, 0, 18, 49),
        ),
      );
    } else if (response['status'] == 401) {
      setState(() {
        progress = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: AppColors.red,
          content: Text(
            response['message'].toString(),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 15.0),
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.fromLTRB(18, 0, 18, 49),
        ),
      );
    }
  }

  void recupData() {
    SharedPreferencesClass.restore('token').then((value) {
      setState(() {
        token = value;
        print(token);
      });
    });

    SharedPreferencesClass.restore('number').then((value) {
      setState(() {
        phone_number = value.toString();
      });
    });
    cmd_id = widget.id;
    print(cmd_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text("Recapitulaton de votre paiement"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
          child: Column(children: [
            Text(
              "RECAPITULATIF DE VOTRE PAIEMENT",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Montant a payer",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // CircularProgressIndicator(),
                Text(
                  "${montant} XOF",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              // width: 300,
              child: DropdownButton(
                isExpanded: true,
                hint: Text('Choisissez'),
                icon: const Icon(Icons.keyboard_arrow_down),
                value: dropdownValue,
                items: items.map((item) {
                  return DropdownMenuItem(
                    value: item['nom'].toString(),
                    child: Text("${item['nom'].toString()}"),
                  );
                }).toList(),
                onChanged: (newvalue) {
                  setState(() {
                    dropdownValue = newvalue;
                    if (newvalue == "PORTEFEUILLE") {
                      visibilite = true;
                      print(visibilite);
                    } else {
                      visibilite = false;
                    }
                  });
                },
              ),
            ),
            Visibility(
              replacement: Text(
                "Choisir le mode de paiement",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              visible: visibilite,
              child: Container(
                padding: const EdgeInsets.only(left: 15),
                child: TextField(
                  onSubmitted: (value) {
                    if (value.isEmpty) {
                      return "Remplisser les champas s'il vous plait";
                    }
                  },
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 12),
                    border: InputBorder.none,
                    label: Text("votre Mot de passe"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            progress
                ? CircularProgressIndicator(
                    backgroundColor: Colors.red,
                    color: Colors.white,
                  )
                : Container(
                    padding: const EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          progress = true;
                          _onSubmit();
                        });
                        // // status ? myShowModal() : '';
                        // myShowModal();
                      },
                      child: Text(
                        "Payer Votre Commande",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      style:
                          OutlinedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  )
          ]),
        ));
  }
}
