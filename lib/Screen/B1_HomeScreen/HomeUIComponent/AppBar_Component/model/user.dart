class User {
  String key;
  String email;
  String userId;
  String userName;
  String nom;
  String prenoms;
  String profilePic;
  String contact;
  String location;
  String createdAt;
  bool isVerified;
  String fcmToken;

  User({
    this.email,
    this.userId,
    this.profilePic,
    this.key,
    this.contact,
    this.location,
    this.createdAt,
    this.userName,
    this.prenoms,
    this.nom,
    this.isVerified,
    this.fcmToken,
  });

  User.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    email = map['email'];
    userId = map['userId'];
    profilePic = map['profilePic'];
    key = map['key'];
    location = map['location'];
    contact = map['contact'];
    createdAt = map['createdAt'];
    userName = map['userName'];
    prenoms = map['prenoms'];
    nom = map['nom'];
    fcmToken = map['fcmToken'];
    isVerified = map['isVerified'] ?? false;
  }
  toJson() {
    return {
      'key': key,
      "userId": userId,
      "email": email,
      'profilePic': profilePic,
      'contact': contact,
      'location': location,
      'createdAt': createdAt,
      'userName': userName,
      'nom': nom,
      'prenoms': prenoms,
      'isVerified': isVerified ?? false,
      'fcmToken': fcmToken,
    };
  }

  User copyWith({
    String email,
    String userId,
    String displayName,
    String profilePic,
    String key,
    String contact,
    bio,
    String dob,
    String location,
    String createdAt,
    String userName,
    String prenoms,
    String nom,
    int followers,
    int following,
    String webSite,
    bool isVerified,
    String fcmToken,
    List<String> followingList,
  }) {
    return User(
      email: email ?? this.email,
      contact: contact ?? this.contact,
      createdAt: createdAt ?? this.createdAt,
      isVerified: isVerified ?? this.isVerified,
      key: key ?? this.key,
      location: location ?? this.location,
      profilePic: profilePic ?? this.profilePic,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      prenoms: prenoms ?? this.prenoms,
      nom: nom ?? this.nom,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}
