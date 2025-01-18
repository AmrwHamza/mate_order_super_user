import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view/home_view_body.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view/widgets/custom_add_product_dialog.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view/widgets/refresh_button.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view_model/get_all_products/get_all_products_cubit.dart';
import 'package:mate_order_super_user/constants.dart';
import 'package:mate_order_super_user/core/widgets/app_bar_style.dart';
import 'package:mate_order_super_user/core/widgets/drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GetAllProductsCubit>().getProducts();

    return Scaffold(
      appBar: mainAppBar('Home'),
      drawer: const MainDrawer(),
      body: const HomeViewBody(),
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
              backgroundColor: kPrimaryColor7,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const CustomAddProductDialog();
                  },
                );
              },
              isExtended: true,
              mini: false,
              child: const Text('Add Product'),
            ),
          ),
        ],
      ),
    );
  }
}
