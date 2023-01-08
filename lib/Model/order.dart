class Order {
  String id;
  String reference;
  String userId;
  String detailsCommandeId;
  String statutId;
  String montantLivraison;
  String montantCommande;
  String montantService;
  String information;
  Map<String, dynamic> statut;
  Map<String, dynamic> detailsCommande;

  Order({
    this.id,
    this.reference,
    this.userId,
    this.detailsCommandeId,
    this.statutId,
    this.montantLivraison,
    this.montantCommande,
    this.montantService,
    this.information,
    this.statut,
    this.detailsCommande,
  });

  Order.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    reference = map['reference'];
    userId = map['user_id'];
    detailsCommandeId = map['details_commande_id'];
    statutId = map['statut_id'];
    montantLivraison = map['montant_livraison'];
    montantCommande = map['montant_commande'];
    montantService = map['montant_service'];
    information = map['information'];
    statut = map['statut'];
    detailsCommande = map['details_commande'];
  }
  toJson() {
    return {
      "id": id,
      "reference": reference,
      "user_id": userId,
      "details_commande_id": detailsCommandeId,
      "statut_id": statutId,
      "montant_livraison": montantLivraison,
      "montant_commande": montantCommande,
      "montant_service": montantService,
      "information": information,
      "statut": statut,
      "details_commande": detailsCommande,
    };
  }

  Order copyWith({
    String id,
    String reference,
    String userId,
    String detailsCommandeId,
    String statutId,
    String montantLivraison,
    String montantCommande,
    String montantService,
    String information,
    Map<String, dynamic> statut,
    Map<String, dynamic> detailsCommande,
  }) {
    return Order(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      userId: userId ?? this.userId,
      detailsCommandeId: detailsCommandeId ?? this.detailsCommandeId,
      statutId: statutId ?? this.statutId,
      montantLivraison: montantLivraison ?? this.montantLivraison,
      montantCommande: montantCommande ?? this.montantCommande,
      montantService: montantService ?? this.montantService,
      information: information ?? this.information,
      statut: statut ?? this.statut,
      detailsCommande: detailsCommande ?? this.detailsCommande,
    );
  }
}
