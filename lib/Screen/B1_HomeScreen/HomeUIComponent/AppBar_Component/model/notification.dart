class NotificationModel {
  String id;
  String etatLecture;
  String date;
  String type;
  String commandeId;
  String createdAt;
  String updatedAt;
  String commandeStatutId;
  String seen;
  Map<String, dynamic> commande;
  Map<String, dynamic> commandeStatut;

  NotificationModel({
    this.id,
    this.etatLecture,
    this.date,
    this.type,
    this.commandeId,
    this.createdAt,
    this.updatedAt,
    this.commandeStatutId,
    this.seen,
    this.commande,
    this.commandeStatut,
  });

  NotificationModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    etatLecture = map['etatLecture'];
    date = map['date'];
    type = map['type'];
    commandeId = map['commande_id'];
    createdAt = map['created_at'];
    updatedAt = map['updated_at'];
    commandeStatutId = map['commande_statut_id'];
    seen = map['seen'];
    commande = map['commande'];
    commandeStatut = map['commande_statut'];
  }
  toJson() {
    return {
      "id": id,
      "etatLecture": etatLecture,
      "date": date,
      "type": type,
      "commande_id": commandeId,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "commande_statut_id": commandeStatutId,
      "seen": seen,
      "commande": commande,
      "commande_statut": commandeStatut
    };
  }

  NotificationModel copyWith({
    String id,
    String etatLecture,
    String date,
    String type,
    String commandeId,
    String createdAt,
    String updatedAt,
    String commandeStatutId,
    String seen,
    Map<String, dynamic> commande,
    Map<String, dynamic> commandeStatut,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      etatLecture: etatLecture ?? this.etatLecture,
      date: date ?? this.date,
      type: type ?? this.type,
      commandeId: commandeId ?? this.commandeId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      commandeStatutId: commandeStatutId ?? this.commandeStatutId,
      seen: seen ?? this.seen,
      commande: commande ?? this.commande,
      commandeStatut: commandeStatut ?? commandeStatut,
    );
  }
}
