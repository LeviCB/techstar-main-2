import 'dart:convert';

import 'package:techstar/models/profile.dart';
import 'package:techstar/models/post.dart';

class UserData {
  UserData({
    required this.profile,
    required this.posts,
  });

  final Profile profile;
  final List<Post> posts;

  factory UserData.fromRawJson(String str) => UserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        profile: Profile.fromJson(json["profile"]),
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
      };
}
