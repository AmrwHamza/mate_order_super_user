import 'package:flutter/material.dart';

import 'package:mate_order_super_user/Features/Home/data/models/get_all_products.dart';
import 'dart:ui_web' as ui;
import 'dart:html' as html;

import '../../../../../../constants.dart';
import '../../../../../../core/utils/assets.dart';

class ProductCardInArchive extends StatelessWidget {
  final Product product;

  const ProductCardInArchive({
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
                child: buildImg("$baseurlImg${product.imagePath!}"),
              ),
              Text(
                "Name: ${product.name}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price: ${product.price} ",
                  ),
                  const Text('SYP')
                ],
              ),
              Text(
                "Amount: ${product.amount}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
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
