import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_conn.dart';
import 'package:rootnode/helper/http_service.dart';

class ConnRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<ConnOverviewResponse?> getOldRecentConns() async {
    try {
      Response res = await _httpServices.get(
        "${ApiConstants.baseUrl}${ApiConstants.connOverview}",
      );
      return res.statusCode == 200
          ? ConnOverviewResponse.fromJson(res.data)
          : null;
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
