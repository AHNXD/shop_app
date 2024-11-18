import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/cart_page_controller.dart';

class BillController extends GetxController {
  final controller = Get.put(CartController());
  double cartSubTotal = 0;
  void getSubTotal() {
    double subTotal = 0;
    for (var i = 0; i < controller.cartProducts.length; i++) {
      debugPrint(
          "${controller.cartProducts[i].price}  ${controller.cartOrderProducts[i]['quantity']}");
      subTotal += ((double.parse(controller.cartProducts[i].price.toString())) *
          (double.parse(
              controller.cartOrderProducts[i]['quantity'].toString())));
    }
    cartSubTotal = subTotal;
    update();

    debugPrint('subTotal: $subTotal');
  }

  bool editCart = false;
}
