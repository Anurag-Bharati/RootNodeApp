import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_cmnt.dart';
import 'package:rootnode/helper/http_service.dart';

class CmntRemoteDataSource {
  final Dio _httpServices = HttpServices.getDioInstance();

  Future<CommentResponse?> getPostComments(
      {required String id, required int page}) async {
    try {
      Response res = await _httpServices
          .get("${ApiConstants.baseUrl}${ApiConstants.post}/$id/comment");
      return res.statusCode == 200 ? CommentResponse.fromJson(res.data) : null;
    } catch (_) {
      debugPrint(_.toString());
      return Future.value(null);
    }
  }
}
