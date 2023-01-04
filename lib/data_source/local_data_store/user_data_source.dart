import 'package:rootnode/helper/objectbox.dart';
import 'package:rootnode/model/user.dart';
import 'package:rootnode/state/objectbox_state.dart';

class UserDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;
  Future<int> registerUser(User user) async {
    try {
      return objectBoxInstance.registerUser(user);
    } catch (e) {
      return 0;
    }
  }

  Future<User?> loginUser(String email, String password) async {
    try {
      return objectBoxInstance.loginUser(email, password);
    } catch (e) {
      return null;
    }
  }

  Future<List<User>> getAllUsers() async {
    try {
      return objectBoxInstance.getAllUser();
    } catch (e) {
      throw Exception("Error in getting all users");
    }
  }
}
