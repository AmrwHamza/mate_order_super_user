import 'package:dartz/dartz.dart';
import 'package:mate_order_super_user/Features/Home/data/models/refresh_model.dart';
import 'package:mate_order_super_user/core/utils/api_services.dart';
import 'package:mate_order_super_user/core/utils/error/failure.dart';

class RefreshService {
  Future<Either<Failure, RefreshModul>> refresh() async {
    final result = await Api().put(endPoint: 'refreshData', data: {});

    return result.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(RefreshModul.fromJson(r));
      },
    );
  }
}
