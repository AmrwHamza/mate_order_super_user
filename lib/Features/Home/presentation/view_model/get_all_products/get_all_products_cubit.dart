import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mate_order_super_user/Features/Home/data/models/get_all_products.dart';
import 'package:mate_order_super_user/Features/Home/data/repository/get_all_products_services.dart';

part 'get_all_products_state.dart';

class GetAllProductsCubit extends Cubit<GetAllProductsState> {
  GetAllProductsCubit() : super(GetAllProductsInitial());

  Future<void> getProducts() async {
    emit(GetAllProductsLoading());
    final result = await GetAllProductsServices().getProducts();

    result.fold(
      (l) => emit(GetAllProductsError(error: l.message)),
      (r) {
        emit(GetAllProductsSuccess(products: r.products!));
       
      },
    );
  }
}
