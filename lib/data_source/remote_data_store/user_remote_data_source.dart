import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/helper/http_service.dart';
import 'package:rootnode/helper/simple_storage.dart';
import 'package:rootnode/helper/utils.dart';
import 'package:rootnode/model/user/user.dart';

class UserRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> register(User user) async {
    try {
      Response response = await _httpServices.post(
        ApiConstants.baseUrl + ApiConstants.register,
        data: user.toJson(),
      );
      return response.statusCode == 201 ? 1 : 0;
    } catch (e) {
      return 0;
    }
  }

  Future<bool> login(
      {String? identifier, String? password, bool isEmail = true}) async {
    try {
      var data = {'password': password};
      data[isEmail ? "email" : "username"] = identifier;

      Response res = await _httpServices.post(
        ApiConstants.baseUrl + ApiConstants.login,
        data: data,
      );
      if (res.statusCode == 200) {
        SimpleStorage.saveStringData("token", res.data["data"]["accessToken"]);
        return true;
      } else {
        return false;
      }
    } catch (_) {
      debugPrint(_.toString());
      return false;
    }
  }

  Future<User?> getUserFromToken() async {
    try {
      String? token = await SimpleStorage.getStringData("token");
      _httpServices.options.headers["authorization"] = "Bearer $token";
      Response res =
          await _httpServices.get(ApiConstants.baseUrl + ApiConstants.whoAmI);
      return res.data["isAnonymous"] ? null : User.fromJson(res.data["user"]);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<User?> getUserById({required String id}) async {
    try {
      Response res = await _httpServices
          .get('${ApiConstants.baseUrl}${ApiConstants.user}/$id');
      return User.fromJson(res.data["user"]);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<User?> updateUser({
    required User user,
    XFile? avatar,
  }) async {
    try {
      var data = user.toJson();
      if (avatar != null) {
        MultipartFile? file = await FileConverter.toMultipartFile(file: avatar);
        data['profile'] = file;
      }
      final formData = FormData.fromMap(data);
      Response res = await _httpServices
          .put('${ApiConstants.baseUrl}${ApiConstants.user}', data: formData);
      return User.fromJson(res.data["user"]);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<bool> checkIfUsernameAvailable({required String username}) async {
    try {
      Response res = await _httpServices.get(
          "${ApiConstants.baseUrl}${ApiConstants.isUsernameUnique}?username=$username");
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
