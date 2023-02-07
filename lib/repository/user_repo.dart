import 'package:image_picker/image_picker.dart';
import 'package:rootnode/data_source/local_data_store/user_data_source.dart';
import 'package:rootnode/data_source/remote_data_store/user_remote_data_source.dart';
import 'package:rootnode/helper/network_connectivity.dart';
import 'package:rootnode/model/user/user.dart';

abstract class UserRepo {
  Future<int> saveUser(User user);
  Future<bool> loginUser(
      {String? identifier, String? password, bool isEmail = true});
  Future<List<User>> getUsers();
  Future<User?> getUserById(String id);
  Future<User?> getUserFromToken();
  Future<User?> updateUser({XFile? avatar, required User user});
  Future<bool> checkIfUsernameAvailable({required String username});
}

class UserRepoImpl extends UserRepo {
  @override
  Future<int> saveUser(User user) async {
    return await UserDataSource().saveUser(user);
  }

  @override
  Future<List<User>> getUsers() {
    return UserDataSource().getAllUsers();
  }

  @override
  Future<bool> loginUser(
      {String? identifier, String? password, bool isEmail = true}) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return await UserRemoteDataSource()
          .login(identifier: identifier, password: password, isEmail: isEmail);
    }
    return UserDataSource().loginUser(identifier!, password!);
  }

  @override
  Future<User?> getUserById(String id) {
    return UserRemoteDataSource().getUserById(id: id);
  }

  @override
  Future<User?> getUserFromToken() async {
    bool status = await NetworkConnectivity.isOnline();
    return status ? UserRemoteDataSource().getUserFromToken() : null;
  }

  @override
  Future<User?> updateUser({XFile? avatar, required User user}) {
    return UserRemoteDataSource().updateUser(user: user, avatar: avatar);
  }

  @override
  Future<bool> checkIfUsernameAvailable({required String username}) {
    return UserRemoteDataSource().checkIfUsernameAvailable(username: username);
  }
}
