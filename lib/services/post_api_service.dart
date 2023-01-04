import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:rootnode/constant/api_constant.dart';
import 'package:rootnode/model/post_model.dart';

class PostApiService {
  static Future<PostModel?> getPost({int page = 1}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseURL}/post?page=$page");
      var response = await http.get(url);
      // log(response.body);
      if (response.statusCode == 200) {
        PostModel model = postModelFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
