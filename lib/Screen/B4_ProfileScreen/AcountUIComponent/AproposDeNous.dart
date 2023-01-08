import 'package:flutter/material.dart';
import '../../../helper/utils.dart';

import '../../../constants/appAssets.dart';
import '../../../constants/appColors.dart';

class ProposDeNous extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: red(title: "A PROPOS DE NOUS "),
      appBar: AppBar(
        backgroundColor: AppColors.red,
        centerTitle: true,
        title: Text('A PROPOS DE NOUS'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 30),
        child: Column(
          children: [
            Column(
              children: [
                Image.asset(
                  AppAssets.logoWithoutNameWhite,
                  width: 500,
                  height: 60,
                  color: AppColors.red,
                ),
                Text(
                  "E-SUGU",
                  style: TextStyle(
                    color: AppColors.red,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Version 1.0",
                  style: TextStyle(
                    color: AppColors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "TarzanExpress est la première application en Afrique concue pour vous accompagner et résoudre toutes vos difficultés par rapports aux commandes en chine.\n\n"
              "Elle est intituive et simple d'utilisation, vous assurant ainsi une meilleure expérience.\n\n"
              "Plus de soucis à vous faire pour le suivi de vos colis, ou encore les coûts élevés du transport de vos marchandises jusqu'à vous.\n\n"
              "A ces fins nous vous offrons les fonctions suivantes:\n\n"
              "- Commande de marchandise sur AliExpress, Alibaba etc ...\n"
              "- Suivi de colis en temps réel\n"
              "- Discussion instantanée avec les administrateurs\n"
              "- Livraison à domicile\n"
              "- Paiement par Mobile money\n",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
