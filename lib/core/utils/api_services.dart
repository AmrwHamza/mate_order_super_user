import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mate_order_super_user/constants.dart';
import 'package:mate_order_super_user/core/helpers/shared_pref.dart';
import 'package:mate_order_super_user/core/utils/error/failure.dart';

class Api {
  late Dio dio;

  Api() {
    final BaseOptions options = BaseOptions(
      baseUrl: baseurl,
      receiveDataWhenStatusError: true,
      headers: {'ngrok-skip-browser-warning': 'true'},
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );

    dio = Dio(options);

    // Add interceptors to handle tokens
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorage.getItem('userToken');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          // print('Request Headers: ${options.headers}');

          handler.next(options);
        },
      ),
    );
  }

  Future<Either<Failure, Map<String, dynamic>>> post({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.post(
        endPoint,
        data: data,
        options: Options(headers: headers),
      );
      return Right(response.data);
    } on DioException catch (dioException) {
      return Left(handleDioError(dioException));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> put({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.put(
        endPoint,
        data: data,
        options: Options(headers: headers),
      );
      return Right(response.data);
    } on DioException catch (dioException) {
      return Left(handleDioError(dioException));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.get(
        endPoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      print("==============================$response");
      return Right(response.data);
    } on DioException catch (dioException) {
      print('we are left ===============');
      return Left(handleDioError(dioException));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> delete({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.delete(
        endPoint,
        data: data,
        options: Options(headers: headers),
      );
      return Right(response.data);
    } on DioException catch (dioException) {
      return Left(handleDioError(dioException));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  Failure handleDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return const TimeoutFailure();
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure('Server response timeout');

      case DioExceptionType.sendTimeout:
        return const TimeoutFailure('Request timeout');
      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode;
        final errorMessage = getErrorMessage(dioError.response?.data);
        return ServerFailure('Error $statusCode,$errorMessage');
      case DioExceptionType.cancel:
        return const UnknownFailure('Request was canceled');
      case DioExceptionType.unknown:
        return const UnknownFailure('no internet connection');
      case DioExceptionType.badCertificate:
        return const ValidationFailure('bad Certificate');
      case DioExceptionType.connectionError:
        return const NetworkFailure('connectio error');
      default:
        return UnknownFailure(dioError.message ?? 'Unexpected error');
    }
  }

  String getErrorMessage(data) {
    if (data is String) {
      return data;
    }
    if (data is Map && data.containsKey('message')) {
      final message = data['message'];
      if (message is String) {
        return message;
      }
      if (message is Map) {
        final List<String> errors = [];
        for (var entry in message.entries) {
          final key = entry.key;
          final value = entry.value;
          if (value is List) {
            errors.add('$key: ${value.join(", ")}');
          } else {
            errors.add('$key: $value');
          }
        }
        return errors.join('\n');
      }
    }
    if (data is List) return data.join(', ');

    return 'Unknown error occurred';
  }
}
