import 'package:objectbox/objectbox.dart';
import 'package:rootnode/model/user.dart';

@Entity()
class Post {
  Post({required this.owner, required this.caption, this.pid = 0});

  @Id(assignable: true)
  int pid;

  String? id;
  String? type;
  late User owner;
  late String caption;
  bool? isMarkdown;
  List<dynamic>? mediaFiles;
  int? likesCount;
  int? commentsCount;
  int? sharesCount;
  String? status;
  String? visibility;
  bool? commentable;
  bool? likeable;
  bool? shareable;
  DateTime? createdAt;
  DateTime? updatedAt;
}
