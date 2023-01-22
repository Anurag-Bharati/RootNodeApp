import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_post.dart';
import 'package:rootnode/helper/http_service.dart';
import 'package:rootnode/helper/simple_storage.dart';
import 'package:rootnode/model/post.dart';
import 'package:http_parser/http_parser.dart';

class PostRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();
  final allowedVideo = ["mp4", 'mkv'];
  final allowedImage = ["jpeg", 'png', 'jpg', 'gif'];

  Future<PostResponse?> getPostFeed(
      {int page = 1, int refresh = 0, bool private = false}) async {
    try {
      Response res = await _httpServices.get(
        "${ApiConstants.baseUrl}${ApiConstants.post}${private ? '/feed' : ''}?page=$page&refresh=$refresh",
      );
      return res.statusCode == 200 ? PostResponse.fromJson(res.data) : null;
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<bool> togglePostLike({required String id}) async {
    try {
      String? token = await SimpleStorage.getStringData("token");
      _httpServices.options.headers["authorization"] = "Bearer $token";
      Response res = await _httpServices.post(
        "${ApiConstants.baseUrl}${ApiConstants.post}/$id/like-unlike",
      );
      return res.data['data']['liked'];
    } catch (_) {
      debugPrint(_.toString());
      return false;
    }
  }

  Future<bool> createPost(Post post, List<PlatformFile>? files) async {
    try {
      String? token = await SimpleStorage.getStringData("token");
      _httpServices.options.headers["authorization"] = "Bearer $token";
      List<MultipartFile> mediaFiles = [];
      if (files != null && files.isNotEmpty) {
        for (PlatformFile file in files) {
          String type = "unknown";
          if (allowedImage.contains(file.extension.toString())) type = 'image';
          if (allowedVideo.contains(file.extension.toString())) type = 'video';
          mediaFiles.add(await MultipartFile.fromFile(
            file.path!,
            filename: file.name,
            contentType: MediaType(type, file.extension.toString()),
          ));
        }
      }
      Map<String, dynamic> postMap = post.toJson();
      print(postMap);
      postMap['mediaFiles'] = mediaFiles;
      FormData formData = FormData.fromMap(postMap);
      Response res = await _httpServices
          .post("${ApiConstants.baseUrl}${ApiConstants.post}", data: formData);

      return res.statusCode == 201;
    } catch (_) {
      debugPrint(_.toString());
      return false;
    }
  }
}
