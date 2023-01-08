class Product {
  int id;
  String image;
  int quantite;
  String nom;
  String lien;
  String description;
  bool isExpanded;

  Product({
    this.id,
    this.quantite,
    this.nom,
    this.lien,
    this.description,
    this.image,
    this.isExpanded = false,
  });

  Product.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    quantite = map['quantite'];
    lien = map['lien'];
    nom = map['nom'];
    description = map['description'];
    image = map['image'];
    isExpanded = map['isExpanded'];
  }

  toJson() {
    return {
      'id': id,
      'quantite': quantite,
      'nom': nom,
      'lien': lien,
      'description': description,
      'image': image,
      'isExpanded': isExpanded,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      if (nom != null) 'nom': nom,
      if (lien != null) 'lien': lien,
      if (quantite != null) 'quantite': quantite,
      if (description != null) 'description': description,
      if (image != null) 'image': image,
      if (id != null) 'id': id,
    };
  }

  Product copyWith({
    int id,
    int quantite,
    String nom,
    String lien,
    String description,
    String image,
    bool isExpanded,
  }) {
    return Product(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      description: description ?? this.description,
      lien: lien ?? this.lien,
      quantite: quantite ?? this.quantite,
      image: image ?? this.image,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}
