import 'package:rootnode/helper/objectbox.dart';
import 'package:rootnode/model/user.dart';
import 'package:rootnode/state/objectbox_state.dart';

class UserDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;
  // ObjectBoxInstance  objectBoxInstance = ObjectBoxState.objectBoxInstance!;

  Future<List<User>> getAllUsers() async {
    try {
      return objectBoxInstance.getAllUser();
    } catch (e) {
      throw Exception("Error in getting all users");
    }
  }
}
