import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view_model/get_all_products/get_all_products_cubit.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view_model/refresh/refresh_cubit.dart';
import 'package:mate_order_super_user/constants.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RefreshCubit, RefreshState>(
      listener: (context, state) {
        if (state is RefreshError) {
          showCustomDialog(
              context: context, title: 'Error', content: state.message);
        }
      },
      builder: (context, state) {
        if (state is RefreshLoading) {
          return const CircularProgressIndicator();
        } else if (state is RefreshSuccess) {
          context.read<GetAllProductsCubit>().getProducts();
        }
        return SizedBox(
          width: 100,
          child: FloatingActionButton(
            onPressed: () {
              context.read<RefreshCubit>().refresh();
            },
            isExtended: true,
            mini: false,
            child: const Text('Refresh'),
          ),
        );
      },
    );
  }
}
