import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();
  @Entity(realClass: User)
  factory User({
    @Id(assignable: true) final int? uid,
    @Unique() @JsonKey(name: '_id') final String? id,
    final String? fname,
    final String? lname,
    @Unique() final String? email,
    final String? password,
    final String? avatar,
    final bool? emailVerified,
    final int? postsCount,
    final int? storiesCount,
    final int? nodesCount,
    final int? connsCount,
    final String? role,
    final String? status,
    @Default(false) final bool? isVerified,
    @Default(false) final bool? showOnlineStatus,
    @Property(type: PropertyType.date) final DateTime? lastSeen,
    final String? username,
    @Property(type: PropertyType.date) final DateTime? createdAt,
    @Property(type: PropertyType.date) final DateTime? updatedAt,
    @Property(type: PropertyType.date) final DateTime? usernameChangedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
