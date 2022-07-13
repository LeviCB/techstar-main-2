// To parse this JSON data, do
//
//     final GroupChat = GroupChatFromJson(jsonString);

import 'dart:convert';

class GroupChat {
  GroupChat({
    required this.id,
    required this.name,
    required this.image,
    required this.isactive,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.isread,
    required this.lastmessage,
    required this.lastmessagetime,
  });

  final String id;
  final String name;
  final String image;
  final String isactive;
  final String createdBy;
  final DateTime createdAt;
  final dynamic updatedAt;
  final String isread;
  final String? lastmessage;
  final DateTime? lastmessagetime;

  factory GroupChat.fromRawJson(String str) =>
      GroupChat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GroupChat.fromJson(Map<String, dynamic> json) => GroupChat(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        isactive: json["isactive"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        isread: json["isread"],
        lastmessage: json["lastmessage"],
        lastmessagetime: json["lastmessagetime"] == null
            ? null
            : DateTime.parse(json["lastmessagetime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "isactive": isactive,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "isread": isread,
        "lastmessage": lastmessage,
        "lastmessagetime": lastmessagetime!.toIso8601String(),
      };
}
