import 'package:dio/dio.dart' show MultipartFile;
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:http_parser/http_parser.dart';

class Utils {
  static String getTimeAgo(DateTime dt) {
    Duration diff = DateTime.now().difference(dt);
    int min = diff.inMinutes;
    return timeago.format(DateTime.now().subtract(Duration(minutes: min)),
        locale: 'en_short');
  }
}

class FileConverter {
  static final allowedVideo = ["mp4", 'mkv'];
  static final allowedImage = ["jpeg", 'png', 'jpg', 'gif'];

  static Future<MultipartFile?> toMultipartFile({required XFile file}) async {
    try {
      String ext = file.name.split('.')[1];
      String type = '';
      if (allowedImage.contains(ext)) type = "image";
      if (allowedVideo.contains(ext)) type = "video";
      return await MultipartFile.fromFile(
        file.path,
        filename: file.name,
        contentType: MediaType(type, ext),
      );
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  static Future<List<MultipartFile>> toManyMultipartFile(
      {required List<XFile> files}) async {
    List<MultipartFile> mediaFiles = [];
    try {
      if (files.isNotEmpty) {
        for (XFile file in files) {
          MultipartFile? mf = await toMultipartFile(file: file);
          mediaFiles.add(mf!);
        }
      }
      return mediaFiles;
    } catch (_) {
      debugPrint(_.toString());
      return [];
    }
  }
}
