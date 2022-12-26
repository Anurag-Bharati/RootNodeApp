import 'package:rootnode/data_source/local_data_store/student_data_source.dart';
import 'package:rootnode/model/user.dart';

abstract class UserRepo {
  Future<int> registerUser(User user);
  Future<User?> loginUser(String username, String password);
  Future<List<User>> getUsers();
}

class UserRepoImpl extends UserRepo {
  @override
  Future<int> registerUser(User user) async {
    // TODO
    // FIX_THIS => NOT VALIDATED
    return UserDataSource().registerUser(user);
  }

  @override
  Future<List<User>> getUsers() {
    return UserDataSource().getAllUsers();
  }

  @override
  Future<User?> loginUser(String username, String password) {
    return UserDataSource().loginUser(username, password);
  }
}
