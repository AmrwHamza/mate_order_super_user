import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mate_order_super_user/Features/archive/presentation/model_view/cubit/get_archive_cubit.dart';
import 'package:mate_order_super_user/Features/archive/presentation/view/product_card_in_archive.dart';
import 'package:mate_order_super_user/constants.dart';

class ArchiveBody extends StatelessWidget {
  const ArchiveBody({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<GetArchiveCubit, GetArchiveState>(
      listener: (context, state) {
        if (state is GetArchiveError) {
          showCustomDialog(
              context: context, title: 'Error', content: state.message);
        }
      },
      builder: (context, state) {
        if (state is GetArchiveLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetArchiveSuccess) {
          return GridView.builder(
            // addAutomaticKeepAlives: true,
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  (screenWidth ~/ 200), 
              mainAxisSpacing: screenHeight * 0.01,
              crossAxisSpacing: screenWidth * 0.02,
              childAspectRatio: 3 / 3.7,
            ),

            itemCount: state.products.length + 5,
            itemBuilder: (context, index) {
              if (index >= state.products.length) {
                return const SizedBox(
                  height: 100,
                  width: 100,
                );
              } else {
                return ProductCardInArchive(product: state.products[index]);
              }
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
    
  }
}
