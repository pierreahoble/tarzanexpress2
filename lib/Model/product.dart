class Product {
  int id;
  String images;
  int quantite;
  
  String nom;
  String lien;
  double prix;
  String description;
  bool isExpanded;

  Product({
    this.id,
    this.quantite,
    this.nom,
    this.lien,
    this.description,
    this.prix,
    this.images,
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
    prix = map['prix'];
    description = map['description'];
    images = map['image'];
    isExpanded = map['isExpanded'];
  }

  toJson() {
    return {
      'id': id,
      'quantite': quantite,
      'nom': nom,
      'lien': lien,
      'description': description,
      'prix':prix,
      'image': images,
      'isExpanded': isExpanded,
    };
  }

  Map<String, dynamic> toMap() {
    return {
 'nom': nom,
   'lien': lien,
      'quantite': quantite,
       'description': description,
     'image': images, 'id': id,
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
      images: images ?? this.images,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}
