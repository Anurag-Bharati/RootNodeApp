import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_story.dart';
import 'package:rootnode/helper/http_service.dart';
import 'package:rootnode/helper/simple_storage.dart';
import 'package:rootnode/model/story.dart';
import 'package:http_parser/http_parser.dart';

class StoryRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();
  final allowedVideo = ["mp4", 'mkv'];
  final allowedImage = ["jpeg", 'png', 'jpg', 'gif'];

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

  Future<Story?> getStoryById({required String id}) async {
    try {
      Response res = await _httpServices
          .get("${ApiConstants.baseUrl}${ApiConstants.story}/$id");
      return res.statusCode == 200 ? Story.fromJson(res.data) : null;
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<bool> storyWatched({required String id}) async {
    try {
      String? token = await SimpleStorage.getStringData("token");
      _httpServices.options.headers["authorization"] = "Bearer $token";
      Response res = await _httpServices
          .post("${ApiConstants.baseUrl}${ApiConstants.story}/$id");
      return res.statusCode == 200;
    } catch (_) {
      debugPrint(_.toString());
      return false;
    }
  }

  Future<bool> createStory({required Story story, PlatformFile? file}) async {
    try {
      MultipartFile? media;
      String? token = await SimpleStorage.getStringData("token");
      _httpServices.options.headers["authorization"] = "Bearer $token";
      if (file != null) {
        String type = "unknown";
        if (allowedImage.contains(file.extension.toString())) type = 'image';
        if (allowedVideo.contains(file.extension.toString())) type = 'video';
        media = await MultipartFile.fromFile(
          file.path!,
          filename: file.name,
          contentType: MediaType(type, file.extension.toString()),
        );
      }
      Map<String, dynamic> storyMap = story.toJson();
      storyMap['media'] = media;
      FormData formData = FormData.fromMap(storyMap);
      Response res = await _httpServices
          .post("${ApiConstants.baseUrl}${ApiConstants.story}", data: formData);

      return res.statusCode == 201;
    } catch (_) {
      debugPrint(_.toString());
      return false;
    }
  }
}
