// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:mate_order_super_user/Features/auth/logout/data/repo/logout_service.dart';
import 'package:mate_order_super_user/constants.dart';
import 'package:mate_order_super_user/core/helpers/shared_pref.dart';
import 'package:mate_order_super_user/core/utils/api_services.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  bool isLoading = false;

  Future<void> logout(String endPoint) async {
    emit(LogoutLoading());
    isLoading = true;
    try {
      final result = await LogoutService(Api()).logout(endPoint: endPoint);
      result.fold(
        (failure) => emit(LogoutFailure(error: failure.message)),
        (response) async {
          await SharedPrefHelper.removeData(SharedPrefKeys.userToken);

          emit(LogoutSuccess(message: response.message));
        },
      );
    } on Exception catch (error) {
      emit(LogoutFailure(error: error.toString()));
    }
  }
}
