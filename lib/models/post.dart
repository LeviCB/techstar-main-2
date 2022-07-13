// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

class Post {
  Post({
    required this.id,
    required this.uid,
    required this.image,
    required this.video,
    required this.description,
    required this.text,
    required this.createdAt,
    required this.islike,
    required this.likescount,
    required this.commentscount,
    required this.username,
    required this.profileImage,
  });

  final String id;
  final String uid;
  final String image;
  final String video;
  final String description;
  final String text;
  final DateTime createdAt;
  bool islike;
  final String likescount;
  final String commentscount;
  final String username;
  final String profileImage;

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        uid: json["uid"],
        image: json["image"],
        video: json["video"],
        description: json["description"],
        text: json["text"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        islike: json["islike"] == "1",
        likescount: json["likescount"],
        commentscount: json["commentscount"],
        username: json["username"]??"",
        profileImage: json["profileImage"]??"",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "image": image,
        "video": video,
        "description": description,
        "text": text,
        "created_at": createdAt.toIso8601String(),
        "islike": islike,
        "likescount": likescount,
        "commentscount": commentscount,
        "username": username,
        "profileImage": profileImage,
      };
}
