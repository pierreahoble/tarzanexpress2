import 'package:flutter/material.dart';

enum AdresseLivraisonType {
  RecupererLeColisEnAgence,
  LivraisonAdomicile,
}
enum ModeLivraison {
  AVION,
  BATEAU,
}

final Map<AdresseLivraisonType, String> adressesLivraison = {
  AdresseLivraisonType.RecupererLeColisEnAgence:
      "Récupérer le colis à l'agence",
  AdresseLivraisonType.LivraisonAdomicile: "Livraison à domicile",
};

final Map<ModeLivraison, String> modesLivraison = {
  ModeLivraison.AVION: "EXPRESS - AVION",
  ModeLivraison.BATEAU: "BATEAU",
};

final List<Widget> processDetails = [
  Table(
    border: TableBorder(
      horizontalInside: BorderSide(width: 1),
      verticalInside: BorderSide(width: 1),
    ),
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: [
      TableRow(
        children: [
          Text(
            "Action",
            textAlign: TextAlign.center,
          ),
          Text(
            "Détails",
            textAlign: TextAlign.center,
          ),
        ],
      ),
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              "Processus",
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                Text(
                  " - Exécution Commande Fournisseur\n1 à 5 jours ouvrés\n\n - Du Fournisseur à l'Agence Départ\n1 à 2 jours ouvrés\n\n - De l'Agence Départ au Cargo\n1 à 2 jours ouvrés\n",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              "Livraison",
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              " - Transport colis à destination\n5 à 15 jours ouvrés (Avion)\n45 à 60 jours ouvrés (Bateau)\n\n - Livraison à l'Agence Destination\n1 jour ouvré",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ],
  ),
  SizedBox(height: 14),
  Text(
    "NB : ",
    style: TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.w600,
    ),
  ),
  Text(
    "Le délai de livraison estimé commence à partir de la date d'expédition plutôt que la date de la commande et peut pendre plus de temps que prévu en raison de rupture de stock auprès du fournisseur, procédures de dédouanement ou d'autres causes.\n\nDélai de réception = Délai de processus + Délai de livraison",
    style: TextStyle(
      color: Colors.black,
    ),
  ),
];
