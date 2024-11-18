import 'package:flutter/material.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/models/cart_product_model.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.model,
  });
  final CartProductModel model;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.name,
          style: const TextStyle(
              fontFamily: Constans.kFontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "السعر : ${model.price}ل.س",
          style: TextStyle(
              color: Colors.black.withOpacity(.5),
              fontFamily: Constans.kFontFamily,
              fontSize: 13),
        ),
      ],
    );
  }
}
