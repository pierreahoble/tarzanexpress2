import 'package:flutter/material.dart';

class Adresse {
  int id;
  String pays;
  String ville;
  String quartier;
  String adresse1;
  String adresse2;
  String idFromServer;

  Adresse({
    this.id,
    @required this.pays,
    @required this.ville,
    @required this.quartier,
    @required this.adresse1,
    @required this.adresse2,
    @required this.idFromServer,
  });

  Adresse.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    pays = map['pays'];
    ville = map['ville'];
    quartier = map['quartier'];
    adresse1 = map['adresse1'];
    adresse2 = map['adresse2'];
    idFromServer = map['idFromServer'];
  }

  toJson() {
    return {
      'id': id,
      'pays': pays,
      'ville': ville,
      'quartier': quartier,
      'adresse1': adresse1,
      'adresse2': adresse2,
      'idFromServer': idFromServer
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pays': pays,
      'ville': ville,
      'quartier': quartier,
      'adresse1': adresse1,
      'adresse2': adresse2,
      'idFromServer': idFromServer
    };
  }

  Adresse copyWith({
    int id,
    String pays,
    String ville,
    String quartier,
    String adresse1,
    String adresse2,
    String idFromServer,
  }) {
    return Adresse(
      id: id ?? this.id,
      pays: pays ?? this.pays,
      ville: ville ?? this.ville,
      quartier: quartier ?? this.quartier,
      adresse1: adresse1 ?? this.adresse1,
      adresse2: adresse2 ?? this.adresse2,
      idFromServer: idFromServer ?? this.idFromServer,
    );
  }
}
