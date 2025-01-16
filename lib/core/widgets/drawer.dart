import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mate_order_super_user/Features/auth/login/presentation/views/widgets/login_view_body.dart';
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
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              context.go('/home');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Archive'),
            onTap: () {
              context.go('/archive');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
