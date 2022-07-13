import 'dart:convert';

class Request {
    Request({
        required this.id,
        required this.fid,
        required this.tid,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.profileImage,
        required this.name,
        required this.username,
        required this.address,
        required this.mobile,
        required this.email,
        required this.bio,
        required this.password,
        required this.otp,
        required this.deletedAt,
    });

    final String id;
    final String fid;
    final String tid;
    final String status;
    final DateTime createdAt;
    final dynamic updatedAt;
    final String profileImage;
    final String name;
    final String username;
    final String address;
    final String mobile;
    final String email;
    final String bio;
    final String password;
    final String otp;
    final dynamic deletedAt;

    factory Request.fromRawJson(String str) => Request.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: json["id"],
        fid: json["fid"],
        tid: json["tid"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        profileImage: json["profileImage"],
        name: json["name"],
        username: json["username"],
        address: json["address"],
        mobile: json["mobile"],
        email: json["email"],
        bio: json["bio"] == null || json['bio'] == "" ? "Hey! their I am usinh TechStar." : json['bio'],
        password: json["password"],
        otp: json["otp"],
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fid": fid,
        "tid": tid,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "profileImage": profileImage,
        "name": name,
        "username": username,
        "address": address,
        "mobile": mobile,
        "email": email,
        "bio": bio,
        "password": password,
        "otp": otp,
        "deleted_at": deletedAt,
    };
}
