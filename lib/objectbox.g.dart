// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'model/post.dart';
import 'model/story.dart';
import 'model/user.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 6138479246504221594),
      name: 'User',
      lastPropertyId: const IdUid(20, 9041089780929871417),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5115801486177743412),
            name: 'uid',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 8093898177353580005),
            name: 'fname',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8776623099835251897),
            name: 'lname',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 4232165894689590937),
            name: 'email',
            type: 9,
            flags: 2080,
            indexId: const IdUid(2, 7657929131341665203)),
        ModelProperty(
            id: const IdUid(5, 5113996005119566160),
            name: 'username',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 1586253395544762102),
            name: 'password',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 8069922519351292753),
            name: 'id',
            type: 9,
            flags: 2080,
            indexId: const IdUid(1, 2783890494657467140)),
        ModelProperty(
            id: const IdUid(8, 419775958847083397),
            name: 'avatar',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 1782414650770189387),
            name: 'emailVerified',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 7759540973278672008),
            name: 'postsCount',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 2788229061688583000),
            name: 'storiesCount',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 2033463862497646420),
            name: 'nodesCount',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(13, 5370286352775302310),
            name: 'role',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(14, 2287307098108665787),
            name: 'status',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(15, 5259066186921182738),
            name: 'isVerified',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(16, 8257013226826044270),
            name: 'showOnlineStatus',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(17, 39071100786601352),
            name: 'lastSeen',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(18, 3750907936504814030),
            name: 'createdAt',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(19, 6293594934558927518),
            name: 'updatedAt',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(20, 9041089780929871417),
            name: 'usernameChangedAt',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 3439376138474405713),
      name: 'Post',
      lastPropertyId: const IdUid(16, 5191317787550452106),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4712174053600475515),
            name: 'pid',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 7555269797919283973),
            name: 'id',
            type: 9,
            flags: 2080,
            indexId: const IdUid(3, 934702963201159521)),
        ModelProperty(
            id: const IdUid(3, 2642482374407616868),
            name: 'type',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 8905309756497988367),
            name: 'caption',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 6996807753662661769),
            name: 'isMarkdown',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 6955064353978140720),
            name: 'likesCount',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 4402141742999573679),
            name: 'commentsCount',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 2979070987454085696),
            name: 'sharesCount',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 8299167776480417960),
            name: 'status',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 7251736078924423423),
            name: 'visibility',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 5020243950465656554),
            name: 'commentable',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(13, 2676767346236483750),
            name: 'likeable',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(14, 6317496253491969096),
            name: 'shareable',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(15, 2106616773223134460),
            name: 'createdAt',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(16, 5191317787550452106),
            name: 'updatedAt',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 3200740966856453186),
      name: 'MediaFile',
      lastPropertyId: const IdUid(4, 671623484672568852),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6114360824703127427),
            name: 'mediaId',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 7276195067416246420),
            name: 'url',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8249074972377429513),
            name: 'type',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 671623484672568852),
            name: 'id',
            type: 9,
            flags: 2080,
            indexId: const IdUid(5, 6360670171826796046))
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 3915084085433421223),
      name: 'Story',
      lastPropertyId: const IdUid(12, 2871486317808580817),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5281342022726176054),
            name: 'storyId',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 1861875227471639409),
            name: 'id',
            type: 9,
            flags: 2080,
            indexId: const IdUid(6, 2994870038586928502)),
        ModelProperty(
            id: const IdUid(3, 3782621823877601322),
            name: 'type',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2603067226680828925),
            name: 'heading',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2087805284040158575),
            name: 'likesCount',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 2554701045589056990),
            name: 'watchCount',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 3143836766694416383),
            name: 'status',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 7131381447180983958),
            name: 'visibility',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 3695933232609251406),
            name: 'likeable',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 1601054104833571222),
            name: 'seenBy',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 3904754751371635212),
            name: 'createdAt',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 2871486317808580817),
            name: 'updatedAt',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(5, 3915084085433421223),
      lastIndexId: const IdUid(6, 2994870038586928502),
      lastRelationId: const IdUid(1, 403350268397340821),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [2699268489578170829],
      retiredIndexUids: const [2433313747825919311],
      retiredPropertyUids: const [
        2030185796248820130,
        7009055727808038331,
        2513401695189787634,
        3525353863616344592,
        2755848102466310107,
        1122245704203414127,
        4008318482510895496,
        4978889775581275855,
        991586820671630698,
        1574207132782248598,
        2441702369856461457,
        3807741057244717721,
        2913352306531719849,
        5102395500943955716,
        7052601362960841130,
        8506438372257683967
      ],
      retiredRelationUids: const [403350268397340821],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    User: EntityDefinition<User>(
        model: _entities[0],
        toOneRelations: (User object) => [],
        toManyRelations: (User object) => {},
        getId: (User object) => object.uid,
        setId: (User object, int id) {
          object.uid = id;
        },
        objectToFB: (User object, fb.Builder fbb) {
          final fnameOffset =
              object.fname == null ? null : fbb.writeString(object.fname!);
          final lnameOffset =
              object.lname == null ? null : fbb.writeString(object.lname!);
          final emailOffset =
              object.email == null ? null : fbb.writeString(object.email!);
          final usernameOffset = object.username == null
              ? null
              : fbb.writeString(object.username!);
          final passwordOffset = object.password == null
              ? null
              : fbb.writeString(object.password!);
          final idOffset =
              object.id == null ? null : fbb.writeString(object.id!);
          final avatarOffset =
              object.avatar == null ? null : fbb.writeString(object.avatar!);
          final roleOffset =
              object.role == null ? null : fbb.writeString(object.role!);
          final statusOffset =
              object.status == null ? null : fbb.writeString(object.status!);
          fbb.startTable(21);
          fbb.addInt64(0, object.uid);
          fbb.addOffset(1, fnameOffset);
          fbb.addOffset(2, lnameOffset);
          fbb.addOffset(3, emailOffset);
          fbb.addOffset(4, usernameOffset);
          fbb.addOffset(5, passwordOffset);
          fbb.addOffset(6, idOffset);
          fbb.addOffset(7, avatarOffset);
          fbb.addBool(8, object.emailVerified);
          fbb.addInt64(9, object.postsCount);
          fbb.addInt64(10, object.storiesCount);
          fbb.addInt64(11, object.nodesCount);
          fbb.addOffset(12, roleOffset);
          fbb.addOffset(13, statusOffset);
          fbb.addBool(14, object.isVerified);
          fbb.addBool(15, object.showOnlineStatus);
          fbb.addInt64(16, object.lastSeen?.millisecondsSinceEpoch);
          fbb.addInt64(17, object.createdAt?.millisecondsSinceEpoch);
          fbb.addInt64(18, object.updatedAt?.millisecondsSinceEpoch);
          fbb.addInt64(19, object.usernameChangedAt?.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.uid;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final lastSeenValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 36);
          final createdAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 38);
          final updatedAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 40);
          final usernameChangedAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 42);
          final object = User(
              avatar: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 18),
              id: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 16),
              fname: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              lname: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              email: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              password: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 14),
              emailVerified: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 20),
              postsCount:
                  const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 22),
              storiesCount: const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 24),
              nodesCount: const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 26),
              role: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 28),
              status: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 30),
              isVerified: const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 32),
              showOnlineStatus: const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 34),
              lastSeen: lastSeenValue == null ? null : DateTime.fromMillisecondsSinceEpoch(lastSeenValue),
              username: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 12),
              createdAt: createdAtValue == null ? null : DateTime.fromMillisecondsSinceEpoch(createdAtValue),
              updatedAt: updatedAtValue == null ? null : DateTime.fromMillisecondsSinceEpoch(updatedAtValue),
              usernameChangedAt: usernameChangedAtValue == null ? null : DateTime.fromMillisecondsSinceEpoch(usernameChangedAtValue),
              uid: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));

          return object;
        }),
    Post: EntityDefinition<Post>(
        model: _entities[1],
        toOneRelations: (Post object) => [],
        toManyRelations: (Post object) => {},
        getId: (Post object) => object.pid,
        setId: (Post object, int id) {
          object.pid = id;
        },
        objectToFB: (Post object, fb.Builder fbb) {
          final idOffset =
              object.id == null ? null : fbb.writeString(object.id!);
          final typeOffset =
              object.type == null ? null : fbb.writeString(object.type!);
          final captionOffset =
              object.caption == null ? null : fbb.writeString(object.caption!);
          final statusOffset =
              object.status == null ? null : fbb.writeString(object.status!);
          final visibilityOffset = object.visibility == null
              ? null
              : fbb.writeString(object.visibility!);
          fbb.startTable(17);
          fbb.addInt64(0, object.pid);
          fbb.addOffset(1, idOffset);
          fbb.addOffset(2, typeOffset);
          fbb.addOffset(4, captionOffset);
          fbb.addBool(5, object.isMarkdown);
          fbb.addInt64(6, object.likesCount);
          fbb.addInt64(7, object.commentsCount);
          fbb.addInt64(8, object.sharesCount);
          fbb.addOffset(9, statusOffset);
          fbb.addOffset(10, visibilityOffset);
          fbb.addBool(11, object.commentable);
          fbb.addBool(12, object.likeable);
          fbb.addBool(13, object.shareable);
          fbb.addInt64(14, object.createdAt?.millisecondsSinceEpoch);
          fbb.addInt64(15, object.updatedAt?.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.pid;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final createdAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 32);
          final updatedAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 34);
          final object = Post(
              id: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              type: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              caption: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              isMarkdown: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              likesCount: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 16),
              commentsCount: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 18),
              sharesCount: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 20),
              status: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 22),
              visibility: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 24),
              commentable: const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 26),
              likeable: const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 28),
              shareable: const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 30),
              createdAt: createdAtValue == null ? null : DateTime.fromMillisecondsSinceEpoch(createdAtValue),
              updatedAt: updatedAtValue == null ? null : DateTime.fromMillisecondsSinceEpoch(updatedAtValue),
              pid: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));

          return object;
        }),
    MediaFile: EntityDefinition<MediaFile>(
        model: _entities[2],
        toOneRelations: (MediaFile object) => [],
        toManyRelations: (MediaFile object) => {},
        getId: (MediaFile object) => object.mediaId,
        setId: (MediaFile object, int id) {
          object.mediaId = id;
        },
        objectToFB: (MediaFile object, fb.Builder fbb) {
          final urlOffset =
              object.url == null ? null : fbb.writeString(object.url!);
          final typeOffset =
              object.type == null ? null : fbb.writeString(object.type!);
          final idOffset =
              object.id == null ? null : fbb.writeString(object.id!);
          fbb.startTable(5);
          fbb.addInt64(0, object.mediaId);
          fbb.addOffset(1, urlOffset);
          fbb.addOffset(2, typeOffset);
          fbb.addOffset(3, idOffset);
          fbb.finish(fbb.endTable());
          return object.mediaId;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = MediaFile(
              id: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              url: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              type: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              mediaId:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));

          return object;
        }),
    Story: EntityDefinition<Story>(
        model: _entities[3],
        toOneRelations: (Story object) => [],
        toManyRelations: (Story object) => {},
        getId: (Story object) => object.storyId,
        setId: (Story object, int id) {
          object.storyId = id;
        },
        objectToFB: (Story object, fb.Builder fbb) {
          final idOffset =
              object.id == null ? null : fbb.writeString(object.id!);
          final typeOffset =
              object.type == null ? null : fbb.writeString(object.type!);
          final headingOffset =
              object.heading == null ? null : fbb.writeString(object.heading!);
          final statusOffset =
              object.status == null ? null : fbb.writeString(object.status!);
          final visibilityOffset = object.visibility == null
              ? null
              : fbb.writeString(object.visibility!);
          final seenByOffset = object.seenBy == null
              ? null
              : fbb.writeList(
                  object.seenBy!.map(fbb.writeString).toList(growable: false));
          fbb.startTable(13);
          fbb.addInt64(0, object.storyId);
          fbb.addOffset(1, idOffset);
          fbb.addOffset(2, typeOffset);
          fbb.addOffset(3, headingOffset);
          fbb.addInt64(4, object.likesCount);
          fbb.addInt64(5, object.watchCount);
          fbb.addOffset(6, statusOffset);
          fbb.addOffset(7, visibilityOffset);
          fbb.addBool(8, object.likeable);
          fbb.addOffset(9, seenByOffset);
          fbb.addInt64(10, object.createdAt?.millisecondsSinceEpoch);
          fbb.addInt64(11, object.updatedAt?.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.storyId;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final createdAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 24);
          final updatedAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 26);
          final object = Story(
              id: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              type: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              heading: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              likesCount: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 12),
              watchCount: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              status: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 16),
              visibility: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 18),
              likeable: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 20),
              seenBy: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false).vTableGetNullable(buffer, rootOffset, 22),
              createdAt: createdAtValue == null ? null : DateTime.fromMillisecondsSinceEpoch(createdAtValue),
              updatedAt: updatedAtValue == null ? null : DateTime.fromMillisecondsSinceEpoch(updatedAtValue),
              storyId: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [User] entity fields to define ObjectBox queries.
class User_ {
  /// see [User.uid]
  static final uid = QueryIntegerProperty<User>(_entities[0].properties[0]);

  /// see [User.fname]
  static final fname = QueryStringProperty<User>(_entities[0].properties[1]);

  /// see [User.lname]
  static final lname = QueryStringProperty<User>(_entities[0].properties[2]);

  /// see [User.email]
  static final email = QueryStringProperty<User>(_entities[0].properties[3]);

  /// see [User.username]
  static final username = QueryStringProperty<User>(_entities[0].properties[4]);

  /// see [User.password]
  static final password = QueryStringProperty<User>(_entities[0].properties[5]);

  /// see [User.id]
  static final id = QueryStringProperty<User>(_entities[0].properties[6]);

  /// see [User.avatar]
  static final avatar = QueryStringProperty<User>(_entities[0].properties[7]);

  /// see [User.emailVerified]
  static final emailVerified =
      QueryBooleanProperty<User>(_entities[0].properties[8]);

  /// see [User.postsCount]
  static final postsCount =
      QueryIntegerProperty<User>(_entities[0].properties[9]);

  /// see [User.storiesCount]
  static final storiesCount =
      QueryIntegerProperty<User>(_entities[0].properties[10]);

  /// see [User.nodesCount]
  static final nodesCount =
      QueryIntegerProperty<User>(_entities[0].properties[11]);

  /// see [User.role]
  static final role = QueryStringProperty<User>(_entities[0].properties[12]);

  /// see [User.status]
  static final status = QueryStringProperty<User>(_entities[0].properties[13]);

  /// see [User.isVerified]
  static final isVerified =
      QueryBooleanProperty<User>(_entities[0].properties[14]);

  /// see [User.showOnlineStatus]
  static final showOnlineStatus =
      QueryBooleanProperty<User>(_entities[0].properties[15]);

  /// see [User.lastSeen]
  static final lastSeen =
      QueryIntegerProperty<User>(_entities[0].properties[16]);

  /// see [User.createdAt]
  static final createdAt =
      QueryIntegerProperty<User>(_entities[0].properties[17]);

  /// see [User.updatedAt]
  static final updatedAt =
      QueryIntegerProperty<User>(_entities[0].properties[18]);

  /// see [User.usernameChangedAt]
  static final usernameChangedAt =
      QueryIntegerProperty<User>(_entities[0].properties[19]);
}

/// [Post] entity fields to define ObjectBox queries.
class Post_ {
  /// see [Post.pid]
  static final pid = QueryIntegerProperty<Post>(_entities[1].properties[0]);

  /// see [Post.id]
  static final id = QueryStringProperty<Post>(_entities[1].properties[1]);

  /// see [Post.type]
  static final type = QueryStringProperty<Post>(_entities[1].properties[2]);

  /// see [Post.caption]
  static final caption = QueryStringProperty<Post>(_entities[1].properties[3]);

  /// see [Post.isMarkdown]
  static final isMarkdown =
      QueryBooleanProperty<Post>(_entities[1].properties[4]);

  /// see [Post.likesCount]
  static final likesCount =
      QueryIntegerProperty<Post>(_entities[1].properties[5]);

  /// see [Post.commentsCount]
  static final commentsCount =
      QueryIntegerProperty<Post>(_entities[1].properties[6]);

  /// see [Post.sharesCount]
  static final sharesCount =
      QueryIntegerProperty<Post>(_entities[1].properties[7]);

  /// see [Post.status]
  static final status = QueryStringProperty<Post>(_entities[1].properties[8]);

  /// see [Post.visibility]
  static final visibility =
      QueryStringProperty<Post>(_entities[1].properties[9]);

  /// see [Post.commentable]
  static final commentable =
      QueryBooleanProperty<Post>(_entities[1].properties[10]);

  /// see [Post.likeable]
  static final likeable =
      QueryBooleanProperty<Post>(_entities[1].properties[11]);

  /// see [Post.shareable]
  static final shareable =
      QueryBooleanProperty<Post>(_entities[1].properties[12]);

  /// see [Post.createdAt]
  static final createdAt =
      QueryIntegerProperty<Post>(_entities[1].properties[13]);

  /// see [Post.updatedAt]
  static final updatedAt =
      QueryIntegerProperty<Post>(_entities[1].properties[14]);
}

/// [MediaFile] entity fields to define ObjectBox queries.
class MediaFile_ {
  /// see [MediaFile.mediaId]
  static final mediaId =
      QueryIntegerProperty<MediaFile>(_entities[2].properties[0]);

  /// see [MediaFile.url]
  static final url = QueryStringProperty<MediaFile>(_entities[2].properties[1]);

  /// see [MediaFile.type]
  static final type =
      QueryStringProperty<MediaFile>(_entities[2].properties[2]);

  /// see [MediaFile.id]
  static final id = QueryStringProperty<MediaFile>(_entities[2].properties[3]);
}

/// [Story] entity fields to define ObjectBox queries.
class Story_ {
  /// see [Story.storyId]
  static final storyId =
      QueryIntegerProperty<Story>(_entities[3].properties[0]);

  /// see [Story.id]
  static final id = QueryStringProperty<Story>(_entities[3].properties[1]);

  /// see [Story.type]
  static final type = QueryStringProperty<Story>(_entities[3].properties[2]);

  /// see [Story.heading]
  static final heading = QueryStringProperty<Story>(_entities[3].properties[3]);

  /// see [Story.likesCount]
  static final likesCount =
      QueryIntegerProperty<Story>(_entities[3].properties[4]);

  /// see [Story.watchCount]
  static final watchCount =
      QueryIntegerProperty<Story>(_entities[3].properties[5]);

  /// see [Story.status]
  static final status = QueryStringProperty<Story>(_entities[3].properties[6]);

  /// see [Story.visibility]
  static final visibility =
      QueryStringProperty<Story>(_entities[3].properties[7]);

  /// see [Story.likeable]
  static final likeable =
      QueryBooleanProperty<Story>(_entities[3].properties[8]);

  /// see [Story.seenBy]
  static final seenBy =
      QueryStringVectorProperty<Story>(_entities[3].properties[9]);

  /// see [Story.createdAt]
  static final createdAt =
      QueryIntegerProperty<Story>(_entities[3].properties[10]);

  /// see [Story.updatedAt]
  static final updatedAt =
      QueryIntegerProperty<Story>(_entities[3].properties[11]);
}
