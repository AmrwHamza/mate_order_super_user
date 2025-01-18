import 'package:dartz/dartz.dart';
import 'package:mate_order_super_user/Features/auth/logout/data/model/logout_model.dart';
import 'package:mate_order_super_user/core/utils/api_services.dart';
import 'package:mate_order_super_user/core/utils/error/failure.dart';

class LogoutService {
  late Api api;

  LogoutService(this.api);

  Future<Either<Failure, LogoutModel>> logout(
      {required String endPoint}) async {
    final response = await api.post(endPoint: endPoint, data: {});

    return response.fold((failure) => Left(failure),
        (json) => Right(LogoutModel.fromJson(json)));
  }
}
