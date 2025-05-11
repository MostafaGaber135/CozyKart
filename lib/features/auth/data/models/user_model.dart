class UserModel {
  final String id;
  final String email;
  final String password;
  final String role;
  final String? image;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? token;
  final String? refreshToken;
  final Name userName;
  final List<dynamic> wishlist;
  final List<dynamic> ispurchased;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    this.image,
    this.token,
    this.refreshToken,
    this.wishlist = const [],
    this.ispurchased = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      isVerified: json['isVerified'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      userName:
          json['userName'] != null
              ? Name.fromJson(json['userName'])
              : Name(en: '', ar: ''),
      image: json['image'],
      token: json['token'],
      refreshToken: json['refreshToken'],
      wishlist: json['wishlist'] ?? [],
      ispurchased: json['ispurchased'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'userName': userName.toJson(),
      'image': image,
      'role': role,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Name {
  final String en;
  final String ar;

  Name({required this.en, required this.ar});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(en: json['en'] ?? '', ar: json['ar'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'en': en, 'ar': ar};
  }
}

class Address {
  final String en;
  final String ar;

  Address({required this.en, required this.ar});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(en: json['en'] ?? '', ar: json['ar'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'en': en, 'ar': ar};
  }
}
