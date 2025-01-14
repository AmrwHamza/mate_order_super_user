import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mate_order_super_user/Features/Home/home_view.dart';
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
      ],
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        // routerDelegate: router.routerDelegate, // Connect GoRouter to GetMaterialApp
        //  routeInformationParser: router.routeInformationParser, // Route info parser

        routerConfig: router,
      ),
    );
  }
}

Future<bool> checkIfLoggedInUser() async {
  final token = await SecureStorage.getItem('userToken');

  if (token != null && token.isNotEmpty) {
    debugPrint('User token found: $token');
    return true;
  } else {
    debugPrint('No token found. User needs to log in.');
    return false;
  }
}
