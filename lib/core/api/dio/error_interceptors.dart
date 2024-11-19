import 'package:dio/dio.dart';

class ErrorInterceptors extends InterceptorsWrapper {
  ErrorInterceptors();

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      //
    }
    super.onError(err, handler);
  }
}
