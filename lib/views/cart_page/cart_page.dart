import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/cart_page_controller.dart';
import 'package:shop_app/views/cart_page/widgets/bill_info_section.dart';
import 'package:shop_app/views/cart_page/widgets/product_listview.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final controller = Get.put(CartController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F6),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: const Color(0xFFF3F4F6),
          title: const Text(
            "السلة",
            style: TextStyle(
                fontFamily: Constans.kFontFamily, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<CartController>(
          builder: (controller) {
            return Container(
              height: MediaQuery.sizeOf(context).height - 80,
              child: Column(
                children: [
                  controller.cartOrderProducts.isNotEmpty
                      ? BillInfoSection()
                      : SizedBox(),
                  Expanded(
                    flex: 3,
                    // height: MediaQuery.sizeOf(context).height / 3 * 2 - 40,
                    child: ProductListView(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
