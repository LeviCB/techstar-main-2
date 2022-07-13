import 'dart:convert';

class Profile {
  Profile.member({
    required this.id,
    required this.profileImage,
    required this.username,
    required this.bio,
  });
  Profile({
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
    required this.followers,
    required this.following,
    required this.postcount,
  });

  final String id;
  final String profileImage;
  final String username;
  final dynamic bio;
  String? name;
  String? address;
  String? mobile;
  String? email;
  String? password;
  String? otp;
  DateTime? createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  String? followers;
  String? following;
  String? postcount;

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJsonMember(Map<String, dynamic> json) => Profile.member(
        id: json["id"],
        profileImage: json["profileImage"] ?? "",
        username: json["username"] ?? "",
        bio: json["bio"] == null || json['bio'] == ""
            ? "Hey! their I am using Techstar."
            : json['bio'],
      );

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        profileImage: json["profileImage"] ?? "",
        name: json["name"] ?? "",
        username: json["username"] ?? "",
        address: json["address"] ?? "",
        mobile: json["mobile"] ?? "",
        email: json["email"] ?? "",
        bio: json["bio"] == null || json['bio'] == ""
            ? "Hey! their I am using Techstar."
            : json['bio'],
        password: json["password"] ?? "",
        otp: json["otp"] ?? "",
        createdAt:
            DateTime.parse(json["created_at"] ?? DateTime.now().toString()),
        updatedAt: json["updated_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
        followers: json["followers"],
        following: json["following"],
        postcount: json["postcount"],
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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "followers": followers,
        "following": following,
        "postcount": postcount,
      };
}
