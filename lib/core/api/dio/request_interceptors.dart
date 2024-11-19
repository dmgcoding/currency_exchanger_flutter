import 'package:dio/dio.dart';

class RequestInterceptors extends InterceptorsWrapper {
  RequestInterceptors();
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    //
    super.onRequest(options, handler);
  }
}
