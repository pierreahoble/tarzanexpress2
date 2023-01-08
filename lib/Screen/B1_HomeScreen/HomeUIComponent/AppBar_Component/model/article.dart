class ArticleModel {
  String id;
  String titre;
  String photoAvant;
  String background;
  String contenu;
  String typeId;
  String createdAt;
  String updatedAt;
  String photoAvantLien;
  String backgroundLien;
  Map<String, dynamic> type;

  ArticleModel({
    this.id,
    this.titre,
    this.photoAvant,
    this.background,
    this.contenu,
    this.typeId,
    this.createdAt,
    this.updatedAt,
    this.photoAvantLien,
    this.backgroundLien,
    this.type,
  });

  ArticleModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    titre = map['titre'];
    photoAvant = map['photo_avant'];
    background = map['background'];
    contenu = map['contenu'];
    typeId = map['type_id'];
    createdAt = map['created_at'];
    updatedAt = map['updated_at'];
    photoAvantLien = map['photo_avant_lien'];
    backgroundLien = map['background_lien'];
    type = map['type'];
  }
  toJson() {
    return {
      "id": id,
      "titre": titre,
      "photo_avant": photoAvant,
      "background": background,
      "contenu": contenu,
      "type_id": typeId,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "photo_avant_lien": photoAvantLien,
      "background_lien": backgroundLien,
      "type": type,
    };
  }

  ArticleModel copyWith({
    String id,
    String titre,
    String photoAvant,
    String background,
    String contenu,
    String typeId,
    String createdAt,
    String updatedAt,
    String photoAvantLien,
    String backgroundLien,
    Map<String, dynamic> type,
  }) {
    return ArticleModel(
      id: id ?? this.id,
      titre: titre ?? this.titre,
      photoAvant: photoAvant ?? this.photoAvant,
      background: background ?? this.background,
      contenu: contenu ?? this.contenu,
      typeId: typeId ?? this.typeId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      photoAvantLien: photoAvantLien ?? this.photoAvantLien,
      backgroundLien: backgroundLien ?? this.backgroundLien,
      type: type ?? this.type,
    );
  }
}
