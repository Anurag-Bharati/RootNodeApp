import 'package:path_provider/path_provider.dart';
import 'package:rootnode/model/user/user.dart';
import 'package:rootnode/objectbox.g.dart';

class ObjectBoxInstance {
  late final Store _store;
  late final Box<User> _userBox;

  ObjectBoxInstance(this._store) {
    _userBox = Box<User>(_store);
  }

  // Init ObjectBox
  static Future<ObjectBoxInstance> init() async {
    var dir = await getApplicationDocumentsDirectory();
    final store = Store(
      getObjectBoxModel(),
      directory: '${dir.path}/user_data',
    );
    return ObjectBoxInstance(store);
  }

  int saveUser(User user) => _userBox.put(user);
  bool loginUser(String email, String password) {
    Query<User> query = _userBox
        .query(User_.email.equals(email).and(User_.password.equals(password)))
        .build();
    User? status = query.findUnique();
    return status != null;
  }

  List<User> getAllUser() => _userBox.getAll();
  User? getUserById(String id) {
    Query<User> query = _userBox.query(User_.id.equals(id)).build();
    return query.findUnique();
  }
}
