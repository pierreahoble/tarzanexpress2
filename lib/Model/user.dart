class User {
  int id;
  int pays_id;

  String code;
  String nom;
  String email;
  String prenoms;
  String phone_number;

  String access_token;
  User(
      {this.id,
      this.pays_id,
      this.code,
      this.nom,
      this.email,
      this.prenoms,
      this.phone_number,
      this.access_token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'],
        pays_id: json['user']['pays_id'],
        code: json['user']['code_affiliation']['code'],
        nom: json['user']['nom'],
        email: json['user']['email'],
        prenoms: json['user']['prenoms'],
        phone_number: json['user']['phone_number'] as String,
        access_token: json['access_token']);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'pays_id': pays_id,
        'code': code,
        'nom': nom,
        'email': email,
        'prenoms': prenoms,
        'phone_number': phone_number,
        'access_token': access_token
      };
}
