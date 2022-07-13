class GroupMessage {
    GroupMessage({
        required this.id,
        required this.groupid,
        required this.userid,
        required this.username,
        required this.messages,
        required this.createdAt,
    });

    final String id;
    final String groupid;
    final String userid;
    final String messages;
    final String username;
    final DateTime createdAt;

    factory GroupMessage.fromJson(Map<String, dynamic> json) => GroupMessage(
        id: json["id"],
        groupid: json["groupid"],
        userid: json["userid"],
        messages: json["messages"],
        username: json["username"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "groupid": groupid,
        "userid": userid,
        "messages": messages,
        "created_at": createdAt.toIso8601String(),
    };
}
