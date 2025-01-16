import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mate_order_super_user/Features/Home/data/repository/add_product_service.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view/home_view.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view_model/add_product/add_product_cubit.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view_model/delete_cubit/delete_cubit_cubit.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view_model/get_all_products/get_all_products_cubit.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view_model/refresh/refresh_cubit.dart';
import 'package:mate_order_super_user/Features/archive/presentation/model_view/cubit/get_archive_cubit.dart';
import 'package:mate_order_super_user/Features/archive/presentation/view/archive_view.dart';
import 'package:mate_order_super_user/Features/auth/login/presentation/view-models/cubit/login_cubit.dart';
import 'package:mate_order_super_user/Features/auth/login/presentation/views/login_view.dart';
import 'package:mate_order_super_user/core/bloc_helper/observer.dart';

import 'core/helpers/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool isLoggedIn = await checkIfLoggedInUser();
  Bloc.observer = const CounterObserver();
  runApp(
    MateOrderApp(
      isLoggedIn: isLoggedIn,
    ),
  );
}

class MateOrderApp extends StatelessWidget {
  const MateOrderApp({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: isLoggedIn ? '/home' : '/',
      // initialLocation: '/home',
      routes: [
        GoRoute(
          path: '/', // مسار الصفحة الرئيسية
          builder: (context, state) => const LoginView(),
          routes: [
            // GoRoute(
            //   path: 'about', // مسار صفحة "About"
            //   // builder: (context, state) => AboutPage(),
            // ),
          ],
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeView(),
        ),
        GoRoute(
          path: '/archive',
          builder: (context, state) => const ArchiveView(),
        ),
      ],
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => GetAllProductsCubit()),
        BlocProvider(create: (context) => AddProductCubit(AddProductService())),
        BlocProvider(create: (context) => RefreshCubit()),
        BlocProvider(create: (context) => GetArchiveCubit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        routerConfig: router,
      ),
    );
  }
}

Future<bool> checkIfLoggedInUser() async {
  final token = await SecureStorage.getItem('userToken');

  if (token != null && token.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}
