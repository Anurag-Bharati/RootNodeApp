import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  @Entity(realClass: Message)
  factory Message({
    @JsonKey(ignore: true) @Id(assignable: true) final int? mid,
    @Unique() @JsonKey(name: '_id') final String? id,
    required String text,
    required String senderId,
    required String receiverId,
    @Property(type: PropertyType.date) required DateTime createdAt,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
