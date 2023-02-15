import 'package:objectbox/objectbox.dart';
import 'dart:convert';

@Entity()
class User {
  User(
      {this.avatar,
      this.id,
      this.fname,
      this.lname,
      this.email,
      this.password,
      this.emailVerified,
      this.postsCount,
      this.storiesCount,
      this.nodesCount,
      this.connsCount,
      this.role,
      this.status,
      this.isVerified,
      this.showOnlineStatus,
      this.lastSeen,
      this.username,
      this.createdAt,
      this.updatedAt,
      this.usernameChangedAt,
      this.uid = 0});

  @Id(assignable: true)
  int uid;
  @Unique()
  String? id;
  String? fname;
  String? lname;
  @Unique()
  String? email;
  String? password;
  String? avatar;
  bool? emailVerified;
  int? postsCount;
  int? storiesCount;
  int? nodesCount;
  int? connsCount;
  String? role;
  String? status;
  bool? isVerified;
  bool? showOnlineStatus;
  DateTime? lastSeen;
  String? username;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;
  @Property(type: PropertyType.date)
  DateTime? usernameChangedAt;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatar: json["avatar"],
        id: json["_id"],
        fname: json["fname"],
        lname: json["lname"],
        email: json["email"],
        emailVerified: json["emailVerified"],
        postsCount: json["postsCount"],
        storiesCount: json["storiesCount"],
        nodesCount: json["nodesCount"],
        connsCount: json["connsCount"],
        role: json["role"],
        status: json["status"],
        isVerified: json["isVerified"],
        showOnlineStatus: json["showOnlineStatus"],
        lastSeen: json["lastSeen"],
        username: json["username"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        usernameChangedAt: json["usernameChangedAt"] == null
            ? null
            : DateTime.parse(json["usernameChangedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "fname": fname,
        "lname": lname,
        "username": username,
        "email": email,
        "showOnlineStatus": showOnlineStatus,
        "password": password,
      };
}
