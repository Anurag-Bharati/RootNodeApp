import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/helper/http_service.dart';
import 'package:rootnode/helper/simple_storage.dart';
import 'package:rootnode/model/user.dart';

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
}
