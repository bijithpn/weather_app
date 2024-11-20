import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;
  ApiClient(this._dio) {
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }
  Future<Response<T>> request<T>(RequestOptions options,
      {ResponseType? responseType}) async {
    try {
      Future<Response<T>> response = _dio.request<T>(options.path,
          data: options.data,
          queryParameters: options.queryParameters,
          options: Options(
            method: options.method,
            responseType: responseType,
          ));

      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}
