import 'package:dio/dio.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_post.dart';
import 'package:rootnode/helper/http_service.dart';

class PostRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<PostResponse?> getPostFeed(
      {int page = 1, int refresh = 0, bool private = false}) async {
    try {
      Response res = await _httpServices.get(
        "${ApiConstants.baseUrl}${ApiConstants.post}${private ? '/feed' : ''}?page=$page&refresh=$refresh",
      );
      return res.statusCode == 200 ? PostResponse.fromJson(res.data) : null;
    } catch (e) {
      return null;
    }
  }
}
