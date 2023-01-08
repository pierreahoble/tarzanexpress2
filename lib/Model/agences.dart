class Agence {
  int id;
  int ville_id;
  int adresse_id;
  String nom;
  String pays;
  String ville;
  String quartier;
  String adresse1;
  String adresse2;

  Agence(
      {this.id,
      this.ville_id,
      this.adresse_id,
      this.nom,
      this.pays,
      this.ville,
      this.quartier,
      this.adresse1,
      this.adresse2});

  factory Agence.fromJson(Map<String, dynamic> json) {
    return Agence(
        id: json['id'],
        ville_id: json['ville_id'],
        adresse_id: json['adresse_id'],
        nom: json['nom'],
        pays: json['adresse']['pays'],
        ville: json['adresse']['ville'],
        quartier: json['adresse']['quartier'],
        adresse1: json['adresse']['adresse1'],
        adresse2: json['adresse']['adresse2']);
  }
}
