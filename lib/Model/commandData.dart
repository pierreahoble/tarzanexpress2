class CommandData {
  String message;
  int status;
  List<Data> data;

  CommandData({this.message, this.status, this.data});

  CommandData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String reference;
  int montantCommande;
  String dateCommande;
  Null information;
  Statut statut;
  List<Produits> produits;
  bool expanded = false;

  Data(
      {this.id,
      this.reference,
      this.montantCommande,
      this.dateCommande,
      this.information,
      this.statut,
      this.produits,
      this.expanded});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    montantCommande = json['montant_commande'];
    dateCommande = json['date_commande'];
    information = json['information'];
    expanded = false;
    statut =
        json['statut'] != null ? new Statut.fromJson(json['statut']) : null;
    if (json['produits'] != null) {
      produits = <Produits>[];
      json['produits'].forEach((v) {
        produits.add(new Produits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference'] = this.reference;
    data['montant_commande'] = this.montantCommande;
    data['date_commande'] = this.dateCommande;
    data['information'] = this.information;
    if (this.statut != null) {
      data['statut'] = this.statut.toJson();
    }
    if (this.produits != null) {
      data['produits'] = this.produits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statut {
  String param1;
  String param3;
  String param4;
  String param5;

  Statut({this.param1, this.param3, this.param4, this.param5});

  Statut.fromJson(Map<String, dynamic> json) {
    param1 = json['param1'];
    param3 = json['param3'];
    param4 = json['param4'];
    param5 = json['param5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['param1'] = this.param1;
    data['param3'] = this.param3;
    data['param4'] = this.param4;
    data['param5'] = this.param5;
    return data;
  }
}

class Produits {
  int id;
  String nom;
  String description;
  String lien;
  String images;
  int montant;
  int quantite;

  Produits(
      {this.id,
      this.nom,
      this.description,
      this.lien,
      this.images,
      this.montant,
      this.quantite});

  Produits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    description = json['description'];
    lien = json['lien'];
    images = json['images'];
    montant = json['montant'];
    quantite = json['quantite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['description'] = this.description;
    data['lien'] = this.lien;
    data['images'] = this.images;
    data['montant'] = this.montant;
    data['quantite'] = this.quantite;
    return data;
  }
}
