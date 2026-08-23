import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  factory ServerFailure.fromDioException(DioException e) {
    print("===== DIO ERROR =====");
    print("TYPE: ${e.type}");
    print("MESSAGE: ${e.message}");
    print("STATUS: ${e.response?.statusCode}");
    print("DATA: ${e.response?.data}");
    print("=====================");

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('Connection Timeout');

      case DioExceptionType.sendTimeout:
        return const ServerFailure('Send Timeout');

      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Receive Timeout');

      case DioExceptionType.badCertificate:
        return const ServerFailure('Bad Certificate');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response?.statusCode,
          e.response?.data,
        );

      case DioExceptionType.cancel:
        return const ServerFailure('Request was cancelled');

      case DioExceptionType.connectionError:
        return ServerFailure('Connection Error:"No internet"');

      case DioExceptionType.unknown:
        return ServerFailure("Something went wrong");
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    print("===== RESPONSE ERROR =====");
    print("STATUS CODE: $statusCode");
    print("RESPONSE: $response");
    print("==========================");

    switch (statusCode) {
      case 400:
        return ServerFailure('Bad request');

      case 401:
        return ServerFailure('Unauthorized (check API key)');

      case 403:
        return ServerFailure('Forbidden (API blocked)');

      // case 404:
      //   return const ServerFailure('City name is incorrect.');

      case 429:
        return const ServerFailure('API limit reached');

      case 500:
        return const ServerFailure('Internal server error');

      default:
        return ServerFailure('Unexpected error: $statusCode | $response');
    }
  }
}

// class NoInternetFailure extends Failure {
//   const NoInternetFailure() : super('No internet connection');
// }

// class CacheFailure extends Failure {
//   const CacheFailure() : super('No cached data available');
// }
