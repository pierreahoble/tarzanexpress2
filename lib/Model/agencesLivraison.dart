import 'package:flutter/material.dart';

class AgenceLivraison {
  int id;
  String nomAgence;
  String nomPays;
  String nomVille;

  AgenceLivraison({
    @required this.id,
    @required this.nomAgence,
    @required this.nomPays,
    @required this.nomVille,
  });

  AgenceLivraison.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    nomAgence = map['nomAgence'];
    nomPays = map['nomPays'];
    nomVille = map['nomVille'];
  }

  toJson() {
    return {
      'id': id,
      'nomAgence': nomAgence,
      'nomPays': nomPays,
      'nomVille': nomVille,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomAgence': nomAgence,
      'nomPays': nomPays,
      'nomVille': nomVille,
    };
  }

  AgenceLivraison copyWith({
    int id,
    String nomAgence,
    String nomPays,
    String nomVille,
  }) {
    return AgenceLivraison(
      id: id ?? this.id,
      nomAgence: nomAgence ?? this.nomAgence,
      nomPays: nomPays ?? this.nomPays,
      nomVille: nomVille ?? this.nomVille,
    );
  }
}
