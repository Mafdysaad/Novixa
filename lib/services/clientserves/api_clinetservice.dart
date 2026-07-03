import 'package:dio/dio.dart';

class ApiClientService {
  ApiClientService({required this.baseUrl, this.defaultHeaders}) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl, headers: defaultHeaders));
  }

  final String baseUrl;
  final Map<String, dynamic>? defaultHeaders;

  late final Dio _dio;

  void setAuthorizationToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void removeAuthorizationToken() {
    _dio.options.headers.remove('Authorization');
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
