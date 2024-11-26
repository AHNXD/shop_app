// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/bill_controller.dart';
import 'package:shop_app/controllers/cart_page_controller.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';

class BillInfoSection extends StatelessWidget {
  const BillInfoSection({
    super.key,
  });
  //final cartController = Get.put(CartController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 220,s
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.8),
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      // borderRadius: const BorderRadius.only(
      //     bottomLeft: Radius.circular(40),
      //     bottomRight: Radius.circular(40))),
      child: GetBuilder<BillController>(
          init: BillController(),
          builder: (billController) {
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
                        "${billController.cartSubTotal} ل.س",
                        style: const TextStyle(
                            fontFamily: Constans.kFontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: billController.editCart
                              ? cartController.updateCartLoading
                                  ? null
                                  : () async {
                                      cartController.cartOrderProducts
                                          .toString();
                                      debugPrint(
                                          'cartController.cartOrderProducts.toString(): ${cartController.cartOrderProducts.toString()}');
                                      await cartController.updateCart(context);
                                      billController.editCart = false;
                                      billController.getSubTotal();
                                      billController.update();
                                      cartController.getCartProducts(context);
                                      cartController.update();
                                    }
                              : () {
                                  billController.editCart =
                                      !billController.editCart;
                                  billController.update();
                                },
                          child: Container(
                            height: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: billController.editCart
                                    ? Colors.red
                                    : Constans.kMainColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                                child: cartController.updateCartLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        billController.editCart
                                            ? "حفظ التعديلات"
                                            : "تعديل الطلب",
                                        style: const TextStyle(
                                            fontFamily: Constans.kFontFamily,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15))),
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
                                        if (billController.editCart) {
                                          showErrorSnackBar("تعديل طلبك",
                                              "الرجاء اتمام عملية التعديل قبل تاكيد الطلب");
                                        } else {
                                          var status = await cartController
                                              .submitOrder(context);
                                          if (status) {
                                            cartController.cartOrderProducts
                                                .clear();
                                            cartController.cartProducts.clear();
                                            billController.getSubTotal();
                                            billController.update();
                                            cartController.update();
                                          }
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
                                              fontSize: 15))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 100,
                  // ),
                  // const Expanded(child: SizedBox()),
                ],
              );
            });
          }),
    );
  }
}
