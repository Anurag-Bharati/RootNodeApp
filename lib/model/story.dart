import 'package:objectbox/objectbox.dart';
import 'package:rootnode/model/user.dart';
import 'dart:convert';

@Entity()
class Story {
  Story({
    this.id,
    this.type,
    this.owner,
    this.heading,
    this.likesCount,
    this.watchCount,
    this.media,
    this.status,
    this.visibility,
    this.likeable,
    this.seenBy,
    this.createdAt,
    this.updatedAt,
    this.storyId = 0,
  });

  @Id(assignable: true)
  int storyId;
  @Unique()
  String? id;
  String? type;
  User? owner;
  String? heading;
  int? likesCount;
  int? watchCount;
  String? status;
  StoryFile? media;
  String? visibility;
  bool? likeable;
  List<String>? seenBy;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  factory Story.fromRawJson(String str) => Story.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["_id"],
        type: json["type"],
        owner: json["owner"] == null ? null : User.fromJson(json["owner"]),
        heading: json["heading"],
        likesCount: json["likesCount"],
        watchCount: json["watchCount"],
        status: json["status"],
        media: json["media"] == null ? null : StoryFile.fromJson(json),
        visibility: json["visibility"],
        likeable: json["likeable"],
        seenBy: json["seenBy"] == null
            ? []
            : List<String>.from(json["seenBy"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "owner": owner?.toJson(),
        "heading": heading,
        "visibility": visibility,
        "likeable": likeable,
      };
}

class StoryFile {
  StoryFile({
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

  factory StoryFile.fromRawJson(String str) =>
      StoryFile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoryFile.fromJson(Map<String, dynamic> json) => StoryFile(
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
