import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view/home_view_body.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view/widgets/custom_add_product_dialog.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view/widgets/refresh_button.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view_model/refresh/refresh_cubit.dart';
import 'package:mate_order_super_user/constants.dart';
import 'package:mate_order_super_user/core/widgets/app_bar_style.dart';
import 'package:mate_order_super_user/core/widgets/drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Home'),
      drawer: MainDrawer(),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: HomeViewBody(),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const RefreshButton(),
          const SizedBox(
            width: 50,
          ),
          SizedBox(
            width: 100,
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAddProductDialog();
                  },
                );
              },
              child: Text('Add Product'),
              isExtended: true,
              mini: false,
            ),
          ),
        ],
      ),
    );
  }
}
