// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mate_order_super_user/Features/Home/data/models/add_product_model.dart';
import 'package:mate_order_super_user/Features/Home/data/models/dropped_file.dart';
import 'package:mate_order_super_user/Features/Home/data/repository/add_product_service.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this.addProductService) : super(AddProductInitial());

  final AddProductService addProductService;

  Future<void> addProduct({
    required String name,
    required int amount,
    required double price,
    required String category,
    required DroppedFile file,
  }) async {
    emit(AddProductLoading());

  
    final result = await addProductService.addProduct(
      name: name,
      amount: amount,
      price: price,
      category: category,
      file: file,
    );

    result.fold(
      (l) => emit(AddProductError(l.message)),
      (r) => emit(AddProductSuccess(r)),
    );
  }
}
