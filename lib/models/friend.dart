import 'dart:convert';

class Friend {
  Friend({
    required this.id,
    required this.profileImage,
    required this.name,
    required this.username,
    required this.address,
    required this.mobile,
    required this.email,
    required this.bio,
    required this.password,
    required this.otp,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  final String id;
  final String profileImage;
  final String name;
  final String username;
  final String address;
  final String mobile;
  final String email;
  final dynamic bio;
  final String password;
  final String otp;
  final DateTime createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;

  factory Friend.fromRawJson(String str) => Friend.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        id: json["id"],
        profileImage: json["profileImage"] ?? "",
        name: json["name"] ?? "",
        username: json["username"] ?? "",
        address: json["address"] ?? "",
        mobile: json["mobile"] ?? "",
        email: json["email"] ?? "",
        bio: json["bio"] == null || json['bio'] == "" ? "Hey! their I am usinh TechStar." : json['bio'],
        password: json["password"] ?? "",
        otp: json["otp"] ?? "",
        createdAt: DateTime.parse(json["created_at"]??DateTime.now().toString()),
        updatedAt: json["updated_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profileImage": profileImage,
        "name": name,
        "username": username,
        "address": address,
        "mobile": mobile,
        "email": email,
        "bio": bio,
        "password": password,
        "otp": otp,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
