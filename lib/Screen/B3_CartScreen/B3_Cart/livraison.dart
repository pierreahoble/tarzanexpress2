import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trevashop_v2/Model/CartItemData.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:trevashop_v2/Model/api_response.dart';
import 'package:trevashop_v2/Model/pays.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/HomeUIComponent/AppBar_Component/model/user.dart';
import 'package:trevashop_v2/Screen/B3_CartScreen/B3_Cart/address.dart';
import 'package:trevashop_v2/Screen/B3_CartScreen/B3_Cart/finalisation_comand.dart';

import 'package:trevashop_v2/services/paySelection_services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:trevashop_v2/services/shared_preferences.dart';

import '../../../providers/commandExecution_provider.dart';

class Livraison extends StatefulWidget {
  const Livraison({Key key}) : super(key: key);

  @override
  State<Livraison> createState() => _LivraisonState();
}

class _LivraisonState extends State<Livraison> {
 

  @override
  void initState() {
    

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int currentStep = 0;
    String id_pays = "2";
    String id_ville = "1";
    bool loadcities = false;
    var Select = Provider.of<CommandExecution>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
          backgroundColor: Color(0xFF020D1F),
          //foregroundColor: Colors.orange,
          title: Text(
            "livraison infos".toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 0.6,
                fontFamily: "Sans",
                color: Colors.white,
                fontSize: 20.0),
          ),
        ),
        body: LoaderOverlay(
            child: SingleChildScrollView(
                child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                height: 150.0,
                width: 150.0,
                decoration: BoxDecoration(
                 //   border: Border.all(color: Colors.white, width: 2.5),
                    //shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/logo3.jpg"))),
                ),
              ),
             
              Container(
                decoration: BoxDecoration(color: Color(0xFF020D1F), boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "TYPE DE LIVRAISON",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.6,
                        fontFamily: "Sans",
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RadioSelection("MODE AVION-EXPRESS", 15, () {
                    Select.setTypeLivraison(15);
                    print(Select.Moyen_Transport);
                  }, Select.Type_Livraison == 15 ? Colors.red : Colors.grey),
                  RadioSelection("MODE BATEAU", 16, () {
                    Select.setTypeLivraison(16);
                    print(Select.Moyen_Transport);
                  }, Select.Type_Livraison == 16 ? Colors.red : Colors.grey),
                  SizedBox(
                    height: 15,
                  )
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(color: Color(0xFF020D1F), boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "CHOISIR UNE ADRESSE",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.6,
                          fontFamily: "Sans",
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RadioSelection("AGENCE", 0, () {
                      Select.setMoyenTransport(0);
   Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Finalisation()));

                     ;
                    },
                        Select.Moyen_Transport == 0
                            ? Colors.red
                            : Colors.grey),
                    RadioSelection(" A UNE ADRESSE", 1, () {
                      Select.setMoyenTransport(1);
                    },
                        Select.Moyen_Transport == 1
                            ? Colors.red
                            : Colors.grey),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              
              Select.Moyen_Transport == 1
                  ? TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Address(sendCommand: true)));
                      },
                      child: Row(
                        children: [
                          Text(
                            "CHOISISSEZ UNE ADDRESSE",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              fontFamily: "Sans",
                            ),
                          ),
                          Icon(Icons.arrow_right_outlined,color: Colors.white,)
                        ],
                      ))
                  : Padding(padding: EdgeInsets.zero) /*Image.asset(
              "assets/imgIllustration/IlustrasiCart.png",
              height: 300.0,
            ),*/
            ],
          ),
        ))));
  }
}

Widget RadioSelection(String text, int select, Function onTap, Color color) {
  return Container(
    child: Row(
      children: [
        ElevatedButton(
          onPressed: onTap,
          child: Icon(Icons.check),
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(), elevation: 0, primary: color),
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.6,
            fontFamily: "Sans",
          ),
        )
      ],
    ),
  );
}
