import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mate_order_super_user/Features/Home/data/models/get_all_products.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view_model/delete_cubit/delete_cubit_cubit.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view_model/get_all_products/get_all_products_cubit.dart';

import '../../../../../../constants.dart';
import '../../../../../../core/utils/assets.dart';

class ProductCardInArchive extends StatelessWidget {
  int numberOfproducts = 1;
  final Product product;

  ProductCardInArchive({
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
      child: Container(
        // margin: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: const [BoxShadow(blurRadius: 3, color: kPrimaryColor4)]),
        // height: 160,
        // width: 155,
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
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      // image:AssetImage() ,
                      // image: AssetImage(AssetsData.product),
                      // image: NetworkImage(
                      //     "https://c862-130-180-148-76.ngrok-free.app/storage/project/products/11/Screenshot (7).png"
                      //     "https://a8bc-146-70-202-35.ngrok-free.app/storage/project/products/4/Tile_Border_Travertine.bmp"), //products/5/PSX_20200918_165328.jpg
                      image: image(product),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Text(
                product.name ?? 'No Name',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${product.price} ",
                  ),
                  const Text('SYP')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider image(Product product) {
    if (product.imagePath != null) {
      try {
        // return CachedNetworkImageProvider(
        //   "$baseurlImg"
        //   "${product.imagePath!}",
        // );
        return NetworkImage("$baseurlImg"
            "${product.imagePath!}");
      } catch (e) {
        return const AssetImage(AssetsData.product);
      }
    } else {
      return const AssetImage(AssetsData.product);
    }
  }
}
