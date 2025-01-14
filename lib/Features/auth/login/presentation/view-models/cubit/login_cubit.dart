// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mate_order_super_user/Features/auth/login/data/models/login_user_model.dart';
import 'package:mate_order_super_user/Features/auth/login/data/repository/login_service.dart';
import 'package:mate_order_super_user/core/helpers/shared_pref.dart';

import '../../../../../../core/utils/api_services.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  bool isLoading = false;
  String? phone;
  String? password;
 bool isObsecure = true;
  IconData eyeIcon = Icons.visibility_off_outlined;

  Future<void> onTapLoginButton() async {
    isLoading = true;
    emit(LoginLoading());

    final result =
        await LoginService(Api()).login(phone: phone, password: password);

    result.fold(
      (l) {
        return emit(LoginFailure(error: l.message));
      },
      (r) async {
        await saveToken(r.accessToken!);

        return emit(LoginSuccess(loginUserModel: r));
      },
    );
  }

 Future<void> saveToken(String token) async {
  try {
    await SecureStorage.setItem('userToken', token);
    // debugPrint('Token has been saved successfully: $token');
  } catch (e) {
    // debugPrint('Error saving token: $e');
  }
}

  void isobsecure() {
    isObsecure = !isObsecure;
    if (eyeIcon == Icons.visibility_off_outlined) {
      eyeIcon = Icons.visibility_outlined;
    } else if (eyeIcon == Icons.visibility_outlined) {
      eyeIcon = Icons.visibility_off_outlined;
    }
    emit(LoginObsecure(eyeIcon: eyeIcon, isObsecure: isObsecure));
  }

}
