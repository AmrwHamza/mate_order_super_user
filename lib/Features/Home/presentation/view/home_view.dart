import 'package:flutter/material.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view/home_view_body.dart';
import 'package:mate_order_super_user/core/widgets/app_bar_style.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Home'),
      body:const HomeViewBody(),
    );
  }
}