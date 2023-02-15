import 'package:objectbox/objectbox.dart';
import 'package:rootnode/model/user.dart';

@Entity()
class Connection {
  Connection(
      {this.id,
      this.rootnode,
      this.node,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.cid = 0});

  @Id(assignable: true)
  int cid;
  @Unique()
  String? id;
  User? rootnode;
  User? node;
  String? status;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;
}
