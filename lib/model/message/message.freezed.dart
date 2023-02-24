// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  @JsonKey(ignore: true)
  @Id(assignable: true)
  int? get mid => throw _privateConstructorUsedError;
  @Unique()
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  String? get senderId => throw _privateConstructorUsedError;
  String? get receiverId => throw _privateConstructorUsedError;
  @Property(type: PropertyType.date)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {@JsonKey(ignore: true) @Id(assignable: true) int? mid,
      @Unique() @JsonKey(name: '_id') String? id,
      String? text,
      String? senderId,
      String? receiverId,
      @Property(type: PropertyType.date) DateTime? createdAt});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mid = freezed,
    Object? id = freezed,
    Object? text = freezed,
    Object? senderId = freezed,
    Object? receiverId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      mid: freezed == mid
          ? _value.mid
          : mid // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String?,
      receiverId: freezed == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$_MessageCopyWith(
          _$_Message value, $Res Function(_$_Message) then) =
      __$$_MessageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(ignore: true) @Id(assignable: true) int? mid,
      @Unique() @JsonKey(name: '_id') String? id,
      String? text,
      String? senderId,
      String? receiverId,
      @Property(type: PropertyType.date) DateTime? createdAt});
}

/// @nodoc
class __$$_MessageCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$_Message>
    implements _$$_MessageCopyWith<$Res> {
  __$$_MessageCopyWithImpl(_$_Message _value, $Res Function(_$_Message) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mid = freezed,
    Object? id = freezed,
    Object? text = freezed,
    Object? senderId = freezed,
    Object? receiverId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_Message(
      mid: freezed == mid
          ? _value.mid
          : mid // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String?,
      receiverId: freezed == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@Entity(realClass: Message)
class _$_Message implements _Message {
  _$_Message(
      {@JsonKey(ignore: true) @Id(assignable: true) this.mid,
      @Unique() @JsonKey(name: '_id') this.id,
      this.text,
      this.senderId,
      this.receiverId,
      @Property(type: PropertyType.date) this.createdAt});

  factory _$_Message.fromJson(Map<String, dynamic> json) =>
      _$$_MessageFromJson(json);

  @override
  @JsonKey(ignore: true)
  @Id(assignable: true)
  final int? mid;
  @override
  @Unique()
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? text;
  @override
  final String? senderId;
  @override
  final String? receiverId;
  @override
  @Property(type: PropertyType.date)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Message(mid: $mid, id: $id, text: $text, senderId: $senderId, receiverId: $receiverId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Message &&
            (identical(other.mid, mid) || other.mid == mid) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, mid, id, text, senderId, receiverId, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageCopyWith<_$_Message> get copyWith =>
      __$$_MessageCopyWithImpl<_$_Message>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  factory _Message(
          {@JsonKey(ignore: true) @Id(assignable: true) final int? mid,
          @Unique() @JsonKey(name: '_id') final String? id,
          final String? text,
          final String? senderId,
          final String? receiverId,
          @Property(type: PropertyType.date) final DateTime? createdAt}) =
      _$_Message;

  factory _Message.fromJson(Map<String, dynamic> json) = _$_Message.fromJson;

  @override
  @JsonKey(ignore: true)
  @Id(assignable: true)
  int? get mid;
  @override
  @Unique()
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get text;
  @override
  String? get senderId;
  @override
  String? get receiverId;
  @override
  @Property(type: PropertyType.date)
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_MessageCopyWith<_$_Message> get copyWith =>
      throw _privateConstructorUsedError;
}
