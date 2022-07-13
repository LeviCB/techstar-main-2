// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

class Comment {
  Comment({
    required this.id,
    required this.uid,
    required this.isLike,
    required this.pid,
    required this.comment,
    required this.createdAt,
    required this.likescount,
    required this.username,
    required this.profileImage,
  });

  final String id;
  final String uid;
  bool isLike;
  final String pid;
  final String comment;
  final DateTime createdAt;
  String likescount;
  final String username;
  final String profileImage;

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        uid: json["uid"],
        pid: json["pid"],
        isLike: json['islike'] == "true",
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        likescount: json["likescount"],
        username: json["username"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "islike": isLike,
        "pid": pid,
        "comment": comment,
        "created_at": createdAt.toIso8601String(),
        "likescount": likescount,
        "username": username,
        "profileImage": profileImage,
      };
}
