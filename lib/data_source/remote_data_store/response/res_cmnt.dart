import 'dart:convert';
import 'package:rootnode/model/comment/comment.dart';

class CommentResponse {
  CommentResponse({
    this.comments,
    this.totalPages,
    this.currentPage,
  });

  List<Comment>? comments;
  int? totalPages;
  int? currentPage;

  factory CommentResponse.fromRawJson(String str) =>
      CommentResponse.fromJson(json.decode(str));

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      CommentResponse(
        comments: json["data"] == null
            ? []
            : List<Comment>.from(json["data"]!.map((x) => Comment.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );
}
