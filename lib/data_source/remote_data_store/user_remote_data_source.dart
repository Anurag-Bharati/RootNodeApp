import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/helper/http_service.dart';
import 'package:rootnode/helper/simple_storage.dart';
import 'package:rootnode/model/user.dart';

class UserRemoteDataSource {
  final Dio _httpServices = HttpServices.getDioInstance();

  Future<int> register(User user) async {
    try {
      Response response = await _httpServices.post(
        ApiConstants.baseUrl + ApiConstants.register,
        data: user.toJson(),
      );
      return response.statusCode == 201 ? 1 : 0;
    } catch (e) {
      debugPrint(e.toString());
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
        String token = res.data["data"]["accessToken"];
        SimpleStorage.saveStringData("token", token);
        HttpServices.addHeader(key: "authorization", value: "Bearer $token");
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
      Response res =
          await _httpServices.get(ApiConstants.baseUrl + ApiConstants.whoAmI);

      return res.data["user"] == null ? null : User.fromJson(res.data["user"]);
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
}
