import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    required this.posts,
    required this.totalPages,
    required this.currentPage,
  });

  List<Post> posts;
  int totalPages;
  int currentPage;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: int.parse(json["currentPage"]),
      );

  Map<String, dynamic> toJson() => {
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class Post {
  Post({
    required this.id,
    required this.content,
    required this.usertag,
    required this.user,
    required this.profile,
    required this.likes,
    required this.comment,
    required this.shares,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.media,
  });

  String id;
  String content;
  String usertag;
  String user;
  String profile;
  int likes;
  int comment;
  int shares;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? media;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        content: json["content"],
        usertag: json["usertag"],
        user: json["user"],
        profile: json["profile"],
        likes: json["likes"],
        comment: json["comment"],
        shares: json["shares"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        media: json["media"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "content": content,
        "usertag": usertag,
        "user": user,
        "profile": profile,
        "likes": likes,
        "comment": comment,
        "shares": shares,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "media": media,
      };
}
