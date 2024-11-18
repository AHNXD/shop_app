// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/bill_controller.dart';
import 'package:shop_app/controllers/cart_page_controller.dart';

class BillInfoSection extends StatelessWidget {
  BillInfoSection({
    super.key,
  });
  final cartController = Get.put(CartController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 220,s
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.8),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: GetBuilder<BillController>(
          init: BillController(),
          builder: (controller) {
            return GetBuilder<CartController>(builder: (cartController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "السعر الكلي : ",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: Constans.kFontFamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      Text(
                        "${controller.cartSubTotal} ل.س",
                        style: const TextStyle(
                            fontFamily: Constans.kFontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  // const Expanded(child: SizedBox()),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: controller.editCart
                            ? cartController.updateCartLoading
                                ? null
                                : () async {
                                    cartController.cartOrderProducts.toString();
                                    debugPrint(
                                        'cartController.cartOrderProducts.toString(): ${cartController.cartOrderProducts.toString()}');
                                    await cartController.updateCart(context);
                                    controller.editCart = false;
                                    controller.getSubTotal();
                                    controller.update();
                                    cartController.getCartProducts(context);
                                    cartController.update();
                                  }
                            : () {
                                controller.editCart = !controller.editCart;
                                controller.update();
                              },
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: controller.editCart
                                  ? Colors.red
                                  : Constans.kMainColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                              child: cartController.updateCartLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      controller.editCart
                                          ? "حفظ التعديلات"
                                          : "تعديل الطلب",
                                      style: const TextStyle(
                                          fontFamily: Constans.kFontFamily,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18))),
                        ),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: cartController.submitOrderLoading
                              ? null
                              : cartController.cartProducts.isEmpty
                                  ? null
                                  : () async {
                                      var status = await cartController
                                          .submitOrder(context);
                                      if (status) {
                                        cartController.cartOrderProducts
                                            .clear();
                                        cartController.cartProducts.clear();
                                        controller.getSubTotal();
                                        controller.update();
                                        cartController.update();
                                      }
                                    },
                          child: Container(
                            height: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Constans.kMainColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                                child: cartController.submitOrderLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text("تأكيد الطلب",
                                        style: TextStyle(
                                            fontFamily: Constans.kFontFamily,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            });
          }),
    );
  }
}
