import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/products_controller.dart';
import 'package:shop_app/models/home_category_model.dart';

class HomeCard extends StatelessWidget {
  HomeCard({
    super.key,
    required this.model,
  });
  final HomeCategoryModel model;
  final controller = Get.put(ProductsController());
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CachedNetworkImage(
          width: 64,
          height: 64,
          imageUrl: "${Constans.kImageBaseUrl}${model.image}",
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => const CircularProgressIndicator(
            color: Colors.white,
          ),
          errorWidget: (context, url, error) =>
              const Icon(Icons.wifi_tethering_error_rounded_sharp),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(model.name,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: Constans.kFontFamily))
      ],
    );
  }
}
