class Pays {
  int id;
  String nom;
  String abr;
  String indicatif;

  Pays({this.id, this.nom, this.abr, this.indicatif});

  // ignore: missing_return
  factory Pays.fromJson(Map<String, dynamic> map) {
    return Pays(
        id: map['id'],
        nom: map['nom'],
        abr: map['abr'],
        indicatif: map['indicatif']);
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'nom': nom, 'abr': abr, 'indicatif': indicatif};
}
