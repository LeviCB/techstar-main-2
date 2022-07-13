import 'dart:convert';

class Message {
  Message({
    this.id,
    required this.fromid,
    required this.toid,
    required this.message,
    required this.isread,
    required this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String fromid;
  final String toid;
  final String message;
  final String isread;
  final DateTime createdAt;
  final dynamic updatedAt;

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        fromid: json["fromid"],
        toid: json["toid"],
        message: json["message"],
        isread: json["isread"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fromid": fromid,
        "toid": toid,
        "message": message,
        "isread": isread,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
      };
}
