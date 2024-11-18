import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/models/order_model.dart';
import 'package:shop_app/views/order_details_page.dart/widgets/order_details_info.dart';
import 'package:shop_app/views/order_details_page.dart/widgets/order_details_product.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, required this.model});
  final OrderModel model;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          backgroundColor: Constans.kMainColor,
          centerTitle: true,
          title: Text(
            "تفاصيل الطلب #${model.id}",
            style: style(),
          ),
        ),
        backgroundColor: Constans.kMainColor,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    flex: 2,
                    child: OrderDetailsInfo(
                      model: model,
                    )),
                Expanded(flex: 3, child: OrderDetailsProducts(model: model))
              ],
            )
          ],
        ),
      ),
    );
  }
}
