import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mate_order_super_user/Features/auth/login/presentation/view-models/cubit/login_cubit.dart';
import 'package:mate_order_super_user/Features/auth/login/presentation/views/widgets/custom_register_button.dart';
import 'package:mate_order_super_user/Features/auth/login/presentation/views/widgets/custom_text_form_field.dart';
import 'package:mate_order_super_user/Features/auth/login/presentation/views/widgets/logo.dart';
import 'package:mate_order_super_user/Features/auth/login/presentation/views/widgets/register_text.dart';
import 'package:mate_order_super_user/constants.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});
  final keyForm1 = GlobalKey<FormState>();

  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          BlocProvider.of<LoginCubit>(context).isLoading = false;

          // Get.snackbar('error', state.error,
          //     snackPosition: SnackPosition.BOTTOM);
          showCustomDialog(
              context: context, title: 'Error', content: state.error);
          // showDialog(
          //   context: context,
          //   builder: (context) => AlertDialog(
          //     title: const Text('Error'),
          //     content: Text(state.error),
          //     actions: [
          //       TextButton(
          //         onPressed: () {
          //           Navigator.of(context).pop();
          //         },
          //         child: const Text('Close'),
          //       ),
          //     ],
          //   ),
          // );
        }
        if (state is LoginLoading) {
          BlocProvider.of<LoginCubit>(context).isLoading = true;
        }
        if (state is LoginSuccess) {
          BlocProvider.of<LoginCubit>(context).isLoading = false;
          context.go('/home');
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: context.watch<LoginCubit>().isLoading,
          child: SingleChildScrollView(
            child: Form(
              key: keyForm1,
              child: Column(
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  const Logo(),
                  const RegisterOrLogInText(
                    data: 'Login',
                  ),
                  const Divider(
                    color: kPrimaryColor1,
                    indent: 27,
                    endIndent: 27,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    onChanged: (p0) {
                      BlocProvider.of<LoginCubit>(context).phone =
                          '+963$p0'; ///////////////////////////edit+
                    },
                    label: const Text(
                      'Phone Number',
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required field";
                      }
                      else if (!value.startsWith('9') || value.length != 9) {
                        return "wrong number it must be like 9xxxxxxxx";
                      }
                      return null;
                    },
                    prefixText: '+963',
                    hintText: '9xxxxxxxx',
                    suffixIcon: const Icon(Icons.phone_android_outlined),
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextFormField(
                    onChanged: (p0) {
                      BlocProvider.of<LoginCubit>(context).password = p0;
                    },
                    label: const Text('Password',
                        style: TextStyle(color: Colors.blueGrey)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required field";
                      } else if (value.length < 8) {
                        return "at least 8 characters";
                      }
                      return null;
                    },
                    suffixIcon: GestureDetector(
                      child: Icon(context.watch<LoginCubit>().eyeIcon),
                      // child: const Icon(Icons.remove_red_eye_outlined),

                      onTap: () {
                        BlocProvider.of<LoginCubit>(context).isobsecure();
                      },
                    ),
                    obscureText: context.watch<LoginCubit>().isObsecure,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomRegisterButton(
                    onPressed: () {
                      if (keyForm1.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        BlocProvider.of<LoginCubit>(context).onTapLoginButton();
                      }
                    },
                    data: 'Login',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
