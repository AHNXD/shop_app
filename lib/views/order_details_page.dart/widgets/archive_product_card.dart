import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/cart_page_controller.dart';
import 'package:shop_app/models/archive_product_model.dart';

class ArchiveProductCard extends StatelessWidget {
  ArchiveProductCard({
    super.key,
    required this.model,
    // required this.image,
    required this.companyName,
  });
  final ArchiveProductModel model;
  // final String image;
  final String companyName;
  final controller = Get.put(CartController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 120,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 2,
                    model.name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: Constans.kFontFamily),
                  ),
                  Text(
                    companyName,
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
                  Text(
                    'الكمية ${model.quantity}',
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
