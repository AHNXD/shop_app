// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/order_page_controller.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/models/order_model.dart';

class OrderDetailsInfo extends StatelessWidget {
  const OrderDetailsInfo({super.key, required this.model});
  final OrderModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      width: MediaQuery.sizeOf(context).width,
      color: Constans.kMainColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'رقم الطلب : ${model.orderNumber}',
            style: style(),
          ),
          Text(
            'السعر الكلي : ${model.totalPrice.toString()} ل.س',
            style: style(),
          ),
          Text(
            'تاريخ الطلب: ${model.orderDate.toString()}',
            style: style(),
          ),
          Text(
            'حالة الطلب : ${model.orderStatus == 'pending' ? 'قيد المعالجة' : model.orderStatus == 'accepted' ? "مقبولة" : (model.orderStatus == 'missing') ? "مفقودة" : (model.orderStatus == 'cancelled') ? 'مرفوضة' : "تم التسليم"}',
            style: style(),
          ),
          model.explaination != null
              ? Text(
                  'سبب الرفض : ${model.explaination.toString()}',
                  style: style(),
                )
              : Container(),
          model.date != null
              ? Text(
                  'تاريخ التسليم: ${model.date.toString()}',
                  style: style(),
                )
              : Container(),
          model.canCancel != null
              ? model.canCancel!
                  ? GetBuilder<OrderPageController>(builder: (controller) {
                      return GestureDetector(
                        onTap: () async {
                          try {
                            bool status =
                                await controller.cancelOrder(model.id, context);
                            if (status) {
                              Get.back();
                              controller.getAllOrder(context);
                            }
                          } on Exception catch (e) {
                            debugPrint('e: ${e}');
                            showErrorSnackBar(
                                    'حدث خطأ', 'الرجاء اعادة المحاولة لاحقا')
                                .show(context);
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 180,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32)),
                          child: controller.cancelOrderLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: Constans.kMainColor,
                                ))
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'الغاء الطلب',
                                      style: style()
                                          .copyWith(color: Constans.kMainColor),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.cancel,
                                        color: Constans.kMainColor,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    })
                  : Container()
              : Container()
        ],
      ),
    );
  }
}

TextStyle style() {
  return const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: Constans.kFontFamily,
      fontWeight: FontWeight.bold);
}
