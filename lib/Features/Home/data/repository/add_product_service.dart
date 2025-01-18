import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mate_order_super_user/Features/Home/data/models/add_product_model.dart';
import 'package:mate_order_super_user/Features/Home/data/models/dropped_file.dart';
import 'package:mate_order_super_user/constants.dart';
import 'package:mate_order_super_user/core/helpers/shared_pref.dart';
import 'package:mate_order_super_user/core/utils/error/failure.dart';

class AddProductService {
  late Dio dio;
  AddProductService() {
    final BaseOptions options = BaseOptions(
      // baseUrl: baseurl,
      receiveDataWhenStatusError: true,
      headers: {
        'ngrok-skip-browser-warning': 'true',
        'Content-Type': 'multipart/form-data',
      },
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
  Future<Either<Failure, AddProductModul>> addProduct(
      {required String name,
      required int amount,
      required double price,
      required String category,
      required DroppedFile file}) async {
    try {
      

      final Uint8List fileBytes = await XFile(file.url).readAsBytes();

      final formData = FormData.fromMap({
        'name': name,
        'amount': amount,
        'price': price,
        'category': category,
        'image': MultipartFile.fromBytes(fileBytes, filename: file.name),
      });

      final response = await dio.post(
        '${baseurl}createProduct',
        data: formData,
      );
      return Right(AddProductModul.fromJson(response.data));
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
