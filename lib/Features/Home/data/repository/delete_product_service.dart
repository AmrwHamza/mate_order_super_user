import 'package:dartz/dartz.dart';
import 'package:mate_order_super_user/Features/Home/data/models/delete_product_model.dart';
import 'package:mate_order_super_user/core/utils/api_services.dart';
import 'package:mate_order_super_user/core/utils/error/failure.dart';

class DeleteProductService {
  Future<Either<Failure, DeleteProductModul>> delete({required int id}) async {
    final result =
        await Api().delete(endPoint: 'deleteProductInStore/$id', data: {});

    return result.fold(
      (l) => Left(l),
      (r) => Right(DeleteProductModul.fromJson(r)),
    );
  }
}
