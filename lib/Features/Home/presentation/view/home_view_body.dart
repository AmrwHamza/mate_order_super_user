import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view/widgets/card_of_product.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view_model/get_all_products/get_all_products_cubit.dart';
import 'package:mate_order_super_user/constants.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (screenWidth ~/ 200),
              mainAxisSpacing: screenHeight * 0.01,
              crossAxisSpacing: screenWidth * 0.02,
              childAspectRatio: 3 / 4.2,
            ),

            itemCount: state.products.length + 5,
            itemBuilder: (context, index) {
              if (index >= state.products.length) {
                return const SizedBox(
                  height: 100,
                  width: 100,
                );
              } else {
                return CardOfProduct(product: state.products[index]);
              }
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
