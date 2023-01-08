import 'package:trevashop_v2/Model/agences.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/HomeUIComponent/AppBar_Component/model/agencesLivraison.dart';

class Ville {
  int id;
  String nom;
  Agence agences;

  Ville({this.id, this.nom, this.agences});

  factory Ville.fromJson(Map<String, dynamic> json) {
    return Ville(id: json['id'], nom: json['nom'], agences: json['agence']);
  }
}
