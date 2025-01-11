import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/models/archive_order_model.dart';
import 'package:shop_app/views/order_details_page.dart/widgets/archive_product_card.dart';

class ArchiveOrderDetailsPage extends StatelessWidget {
  const ArchiveOrderDetailsPage({super.key, required this.model});
  final ArchiveOrderModel model;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
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
                  child: Container(
                    padding: const EdgeInsets.all(16),
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
                          'تاريخ الطلب: ${model.date.toString()}',
                          style: style(),
                        ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        Text(
                          'حالة الطلب :  "تم التسليم',
                          style: style(),
                        ),
                        model.date != null
                            ? Text(
                                'تاريخ التسليم: ${model.date.toString()}',
                                style: style(),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: model.products!.length,
                          itemBuilder: (context, index) {
                            return IntrinsicHeight(
                              child: ArchiveProductCard(
                                  model: model.products![index],
                                  companyName: model.companyName!),
                            );
                          }),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  TextStyle style() {
    return const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontFamily: Constans.kFontFamily,
        fontWeight: FontWeight.bold);
  }
}
