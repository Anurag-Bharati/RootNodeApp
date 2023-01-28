import 'package:dio/dio.dart' show MultipartFile;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeago/timeago.dart' as timeago;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class Utils {
  static String getTimeAgo(DateTime dt) {
    Duration diff = DateTime.now().difference(dt);
    int min = diff.inMinutes;
    return timeago.format(DateTime.now().subtract(Duration(minutes: min)),
        locale: 'en_short');
  }

  static double getHeight(
          {required BuildContext context, double fraction = 1}) =>
      MediaQuery.of(context).size.height * fraction;
  static double getWidth(
          {required BuildContext context, double fraction = 1}) =>
      MediaQuery.of(context).size.width * fraction;

  static LinearGradient getViewShadow() {
    return const LinearGradient(colors: [
      Color(0xFF111111),
      Color(0x55111111),
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      Color(0xAA111111),
      Color(0xFF111111),
    ], begin: Alignment.bottomCenter, end: Alignment.topCenter);
  }
}

class FileConverter {
  static final allowedVideo = ["mp4", 'mkv'];
  static final allowedImage = ["jpeg", 'png', 'jpg', 'gif', 'webp'];

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
