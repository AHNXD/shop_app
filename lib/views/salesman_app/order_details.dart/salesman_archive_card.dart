import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/cart_page_controller.dart';
import 'package:shop_app/models/product_model.dart';

class SalesmanArchiveCard extends StatelessWidget {
  SalesmanArchiveCard({
    super.key,
    required this.model,
    // required this.image,
  });
  final ProductModel model;
  // final String image;
  final controller = Get.put(CartController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 100,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 2,
                    model.name!,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: Constans.kFontFamily),
                  ),
                  Text(
                    '',
                    style: const TextStyle(
                        color: Colors.black26,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: Constans.kFontFamily),
                  ),
                  Text(
                    '${model.price} ل.س ',
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: Constans.kFontFamily),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
