// To parse this JSON data, do
//
//     final chatUser = chatUserFromJson(jsonString);

import 'dart:convert';

class ChatUser {
    ChatUser({
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
        required this.readcount,
        required this.lastmessage,
        required this.lastmessagetime,
    });

    final String id;
    final String profileImage;
    final String name;
    final String username;
    final String address;
    final String mobile;
    final String email;
    final String bio;
    final String password;
    final String otp;
    final DateTime createdAt;
    final dynamic updatedAt;
    final dynamic deletedAt;
    final String readcount;
    final String lastmessage;
    final DateTime? lastmessagetime;

    factory ChatUser.fromRawJson(String str) => ChatUser.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        id: json["id"],
        profileImage: json["profileImage"],
        name: json["name"],
        username: json["username"],
        address: json["address"],
        mobile: json["mobile"],
        email: json["email"],
        bio: json["bio"],
        password: json["password"],
        otp: json["otp"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        readcount: json["readcount"],
        lastmessage: json["lastmessage"]??"",
        lastmessagetime:json["lastmessagetime"] == null ? null : DateTime.parse(json["lastmessagetime"]),
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
        "readcount": readcount,
        "lastmessage": lastmessage,
        "lastmessagetime": lastmessagetime!.toIso8601String(),
    };
}
