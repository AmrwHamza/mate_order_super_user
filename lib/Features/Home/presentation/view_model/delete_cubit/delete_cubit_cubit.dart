import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mate_order_super_user/Features/Home/data/repository/delete_product_service.dart';

part 'delete_cubit_state.dart';

class DeleteCubitCubit extends Cubit<DeleteCubitState> {
  DeleteCubitCubit() : super(DeleteCubitInitial());

  Future<void> delete({required int id}) async {
    emit(DeleteCubitLoading());
    final result = await DeleteProductService().delete(id: id);

    result.fold(
      (l) => emit(
        DeleteCubitError(message: l.message),
      ),
      (r) => emit(DeleteCubitSuccess(message: r.message ?? 'Done')),
    );
  }
}
