// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mate_order_super_user/Features/Home/data/models/refresh_model.dart';
import 'package:mate_order_super_user/Features/Home/data/repository/refresh_service.dart';

part 'refresh_state.dart';

class RefreshCubit extends Cubit<RefreshState> {
  RefreshCubit() : super(RefreshInitial());

  Future<void> refresh() async {
    emit(RefreshLoading());
    final result = await RefreshService().refresh();
    result.fold(
      (l) => emit(RefreshError(message: l.message)),
      (r) => emit(RefreshSuccess(r: r)),
    );
  }
}
