import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_story.dart';
import 'package:rootnode/helper/http_service.dart';

class StoryRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<StoryResponse?> getStoryFeed(
      {int page = 1, int refresh = 0, bool private = false}) async {
    try {
      Response res = await _httpServices.get(
        "${ApiConstants.baseUrl}${ApiConstants.story}${private ? '/feed' : ''}?page=$page&refresh=$refresh",
      );
      return res.statusCode == 200 ? StoryResponse.fromJson(res.data) : null;
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
