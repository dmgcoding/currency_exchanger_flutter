import 'package:dio/dio.dart';

import 'error_interceptors.dart';
import 'request_interceptors.dart';
import 'response_interceptors.dart';

String baseUrl = 'https://v6.exchangerate-api.com/v6';

class DioClient {
  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    _dio = Dio();

    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.contentType = Headers.jsonContentType;

    _dio.options.headers = <String, dynamic>{
      'Accept': Headers.jsonContentType,
    };
    _dio.interceptors.addAll([
      LogInterceptor(),
      RequestInterceptors(),
      ResponseInterceptors(),
      ErrorInterceptors()
    ]);
  }
  late Dio _dio;

  static final DioClient _instance = DioClient._internal();

  Dio get dio => _dio;
}
