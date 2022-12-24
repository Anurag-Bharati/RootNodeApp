import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id(assignable: true)
  int uid;
  String fname;
  String lname;
  String email;
  String username;
  String password;

  User(this.fname, this.lname, this.username, this.email, this.password,
      {this.uid = 0});
}
