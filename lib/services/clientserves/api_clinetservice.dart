import 'package:dio/dio.dart';

class ApiClientService {
  ApiClientService({required this.dio, this.defaultHeaders});

  final Map<String, dynamic>? defaultHeaders;

  final Dio dio;

  void setAuthorizationToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void removeAuthorizationToken() {
    dio.options.headers.remove('Authorization');
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
