import 'package:dio/dio.dart';
import 'package:rootnode/app/constant/api.dart';

class HttpServices {
  static Dio? _dio;
  static const int _timeout = 60 * 1000;

  static Map<String, String> headers = {
    'content-type': 'application/json',
    'accept': 'application/json',
    'language': 'en',
  };

  static addHeader({required String key, required String value}) {
    getDioInstance().options.headers[key] = value;
  }

  static removeHeader({required String key}) {
    getDioInstance().options.headers[key] = null;
  }

  static Dio getDioInstance() {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
        headers: headers,
      ),
    );

    return _dio!;
  }
}
