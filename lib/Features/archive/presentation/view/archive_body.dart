import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mate_order_super_user/Features/archive/presentation/model_view/cubit/get_archive_cubit.dart';
import 'package:mate_order_super_user/Features/archive/presentation/view/product_card_in_archive.dart';
import 'package:mate_order_super_user/constants.dart';

class ArchiveBody extends StatelessWidget {
  const ArchiveBody({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GetArchiveCubit>().getArchive();
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

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, mainAxisSpacing: 10, crossAxisSpacing: 10),
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
    ;
  }
}
