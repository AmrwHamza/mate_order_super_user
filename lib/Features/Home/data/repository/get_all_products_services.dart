import 'package:dartz/dartz.dart';
import 'package:mate_order_super_user/Features/Home/data/models/get_all_products.dart';
import 'package:mate_order_super_user/core/utils/api_services.dart';
import 'package:mate_order_super_user/core/utils/error/failure.dart';

class GetAllProductsServices {
  Future<Either<Failure, GetAllProductsModul>> getProducts() async {
    final result = await Api().get(endPoint: 'getAllProductInStore');

    
    return result.fold(
      (l) { 
        
        
        return Left(l);},
      (r) => Right(GetAllProductsModul.fromJson(r)),
    );
  }
}
