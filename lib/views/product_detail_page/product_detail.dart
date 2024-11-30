import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/cart_page_controller.dart';

import '../../constans.dart';
import '../../models/product_model.dart';
import 'widgets/product_deltails_image.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final cartController = Get.put(CartController(), permanent: true);
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFFF3F4F6),
        title: const Text(
          "تفاصيل المنتج",
          style: TextStyle(
              fontFamily: Constans.kFontFamily, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProductDeltailsImage(
                  pageController: pageController, product: product),
              const SizedBox(height: 16),
              Text(
                product.name ?? "اسم المنتج غير متوفر",
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: Constans.kFontFamily),
              ),
              const SizedBox(height: 8),
              Text(
                product.company ?? "اسم الشركة غير متوفر",
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black45,
                    fontFamily: Constans.kFontFamily),
              ),
              const SizedBox(height: 16),
              Text(
                '${product.price} ل.س',
                style: const TextStyle(
                    fontSize: 18,
                    color: Constans.kMainColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: Constans.kFontFamily),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    var status = await cartController.addToCart(
                      product.id.toString(),
                      context,
                    );
                    if (status) {
                      cartController.cartOrderProducts.add({
                        'id': product.id.toString(),
                        'quantity': "1",
                      });
                      cartController.update();
                    }
                  },
                  icon: const Icon(Icons.shopping_cart_outlined,
                      size: 25, color: Colors.white),
                  label: const Text(
                    "إضافة إلى السلة",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: Constans.kFontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constans.kMainColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 75, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
