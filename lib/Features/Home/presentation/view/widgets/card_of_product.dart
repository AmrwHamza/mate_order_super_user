import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mate_order_super_user/Features/Home/data/models/get_all_products.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view_model/delete_cubit/delete_cubit_cubit.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view_model/get_all_products/get_all_products_cubit.dart';

import '../../../../../../constants.dart';
import '../../../../../../core/utils/assets.dart';
import 'dart:html' as html;
// import 'dart:ui';

class CardOfProduct extends StatelessWidget {
  final Product product;

  const CardOfProduct({
    super.key,
    required this.product,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(
        //     () => ProductDetails(
        //           product: product,
        //         ),
        //     duration: const Duration(milliseconds: 500));
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double containerWidth = constraints.maxWidth * 0.9;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(blurRadius: 3, color: kPrimaryColor4)
                ]),
            // height: 160,
            width: containerWidth,
            // height: MediaQuery.of(context).size.height * 0.9,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AssetsData.logoWithoutTitle,
                        // height: 35,
                        // width: 35,

                        height: MediaQuery.of(context).size.height * .04,
                        width: MediaQuery.of(context).size.width * .04,
                      ),
                    ],
                  ),
                  AspectRatio(
                    aspectRatio: 3.4 / 2,
                    child: buildImg("$baseurlImg${product.imagePath!}"),

                   
                  ),
                  Text(
                    product.name ?? 'No Name',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "${product.price} ",
                      ),
                      const Text('SYP')
                    ],
                  ),
                  Text(
                    "Amount: ${product.amount}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: BlocProvider(
                      create: (context) => DeleteCubitCubit(),
                      child: BlocConsumer<DeleteCubitCubit, DeleteCubitState>(
                        listener: (context, state) {
                          if (state is DeleteCubitError) {
                            showCustomDialog(
                                context: context,
                                title: 'Error',
                                content: state.message);
                          } else if (state is DeleteCubitSuccess) {
                            context.read<GetAllProductsCubit>().getProducts();
                          }
                        },
                        builder: (context, state) {
                          if (state is DeleteCubitLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return ElevatedButton(
                            onPressed: () {
                              context
                                  .read<DeleteCubitCubit>()
                                  .delete(id: product.id!);
                            },
                            style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.redAccent)),
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildImg(String imageUrl) {
    final String imageUrlWithBypass = '$imageUrl?ngrok-skip-browser-warning';
    final String imageElementId = 'image-${imageUrlWithBypass.hashCode}';
    ui.platformViewRegistry.registerViewFactory(imageElementId, (int viewId) {
      final img = html.ImageElement()
        ..src = imageUrlWithBypass
        ..style.width = '100%'
        ..style.height = '100%'
        ..alt = 'Image not loaded';
      return img;
    });

    return HtmlElementView(viewType: imageElementId);
  }
}
