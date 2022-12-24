import 'package:rootnode/model/user.dart';

abstract class UserRepo {
  Future<int> registerUser(User user);
  Future<User?> loginUser(String username, String password);
  Future<List<User>> getUsers();
}

class UserRepoImpl extends UserRepo {
  @override
  Future<List<User>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }

  @override
  Future<User?> loginUser(String username, String password) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<int> registerUser(User user) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }
}
