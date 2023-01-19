import 'package:objectbox/objectbox.dart';
import 'package:rootnode/model/user.dart';
import 'dart:convert';

@Entity()
class Post {
  Post({
    this.type,
    this.caption,
    this.isMarkdown,
    this.visibility,
    this.commentable,
    this.likeable,
    this.shareable,
    this.pid = 0,
  });

  @Id(assignable: true)
  int pid;

  @Unique()
  String? id;
  String? type;

  final owner = ToOne<User>();
  final mediaFiles = ToMany<MediaFile>();

  String? caption;
  bool? isMarkdown;
  int? likesCount;
  int? commentsCount;
  int? sharesCount;
  String? status;
  String? visibility;
  bool? commentable;
  bool? likeable;
  bool? shareable;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;
}

@Entity()
class MediaFile {
  MediaFile({
    this.id,
    this.url,
    this.type,
    this.mediaId = 0,
  });

  @Id(assignable: true)
  int mediaId;

  String? url;
  String? type;

  @Unique()
  String? id;

  factory MediaFile.fromRawJson(String str) =>
      MediaFile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MediaFile.fromJson(Map<String, dynamic> json) => MediaFile(
        url: json["url"],
        type: json["type"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "type": type,
        "_id": id,
      };
}
