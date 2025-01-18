import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mate_order_super_user/Features/auth/logout/presentation/view_model/cubit/logout_cubit.dart';
import 'package:mate_order_super_user/constants.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // padding:  ,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: kPrimaryColor5,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              context.go('/home');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Archive'),
            onTap: () {
              context.go('/archive');
              Navigator.pop(context);
            },
          ),
          BlocConsumer<LogoutCubit, LogoutState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                context.go('/');
              }
            },
            builder: (context, state) {
              if (state is LogoutLoading) {
                const Center(child: CircularProgressIndicator());
              }
              return ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Log Out'),
                onTap: () {
                  context.read<LogoutCubit>().logout('auth/logout');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
