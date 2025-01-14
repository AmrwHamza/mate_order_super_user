import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view/widgets/card_of_product.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view_model/get_all_products/get_all_products_cubit.dart';
import 'package:mate_order_super_user/constants.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GetAllProductsCubit>().getProducts();
    return BlocConsumer<GetAllProductsCubit, GetAllProductsState>(
      listener: (context, state) {
        if (state is GetAllProductsError) {
          showCustomDialog(
              context: context, title: 'Error', content: state.error);
        }
      },
      builder: (context, state) {
        if (state is GetAllProductsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetAllProductsSuccess) {
          return GridView.builder(
            // addAutomaticKeepAlives: true,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return CardOfProduct(product: state.products[index]);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
