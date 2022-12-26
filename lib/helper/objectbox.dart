import 'package:path_provider/path_provider.dart';
import 'package:rootnode/model/user.dart';
import 'package:rootnode/objectbox.g.dart';

class ObjectBoxInstance {
  late final Store _store;
  late final Box<User> _userBox;

  ObjectBoxInstance(this._store) {
    _userBox = Box<User>(_store);
  }

  // Init of ObjectBox
  static Future<ObjectBoxInstance> init() async {
    var dir = await getApplicationDocumentsDirectory();
    final store = Store(
      getObjectBoxModel(),
      directory: '${dir.path}/user_data',
    );
    return ObjectBoxInstance(store);
  }

  // Queries Starts Here
  // User

  List<User> getAllUser() {
    return _userBox.getAll();
  }
}
