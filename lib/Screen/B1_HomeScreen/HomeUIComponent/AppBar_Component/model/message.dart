class Message {
  String id;
  String contenu;
  String date;
  String isAdmin;
  String commandeId;
  String createdAt;
  String updatedAt;
  String isReadByAdmin;
  String type;
  String image;

  Message({
    this.id,
    this.contenu,
    this.date,
    this.isAdmin,
    this.commandeId,
    this.createdAt,
    this.updatedAt,
    this.isReadByAdmin,
    this.type,
    this.image,
  });

  Message.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    contenu = map['contenu'];
    date = map['date'];
    isAdmin = map['is_admin'];
    commandeId = map['commande_id'];
    createdAt = map['created_at'];
    updatedAt = map['updated_at'];
    isReadByAdmin = map['is_read_by_admin'];
    type = map['type'];
    image = map['image'];
  }
  toJson() {
    return {
      "id": id,
      "contenu": contenu,
      "date": date,
      "is_admin": isAdmin,
      "commande_id": commandeId,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "is_read_by_admin": isReadByAdmin,
      "type": type,
      "image": image,
    };
  }

  Message copyWith({
    String id,
    String contenu,
    String date,
    String isAdmin,
    String commandeId,
    String createdAt,
    String updatedAt,
    String isReadByAdmin,
    String type,
    String image,
  }) {
    return Message(
      id: id ?? this.id,
      contenu: contenu ?? this.contenu,
      date: date ?? this.date,
      isAdmin: isAdmin ?? this.isAdmin,
      commandeId: commandeId ?? this.commandeId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isReadByAdmin: isReadByAdmin ?? this.isReadByAdmin,
      type: type ?? this.type,
      image: image ?? this.image,
    );
  }
}
