
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/order_page_controller.dart';
import 'package:shop_app/views/order_page/widgets/order_card.dart';
import 'package:shop_app/views/shimmer/shimmer_container.dart';

class TabBarBody extends StatelessWidget {
  const TabBarBody({
    super.key,
    required this.id,
  });
  final int id;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderPageController>(
        init: OrderPageController(),
        builder: (controller) {
          List orders = [];
          orders = id == 1
              ? controller.pendingOrders
              : id == 2
                  ? controller.acceptedOrders
                  : id == 3
                      ? controller.missingOrders
                      : controller.cancelledOrders;
          return (id == 1 && controller.pendingOrdersError) ||
                  (id == 2 && controller.cancelledOrdersError) ||
                  (id == 3 && controller.acceptedOrdersError) ||
                  (id == 4 && controller.missingOrdersError)
              ? Center(
                  child: Text(
                    'حدث خطأ اثناء تحميل الطبات',
                    style: TextStyle(fontFamily: Constans.kFontFamily),
                  ),
                )
              : orders.isEmpty &&
                      ((id == 1 && !controller.pendingOrdersLoading) ||
                          (id == 2 && !controller.cancelledOrdersLoading) ||
                          (id == 3 && !controller.acceptedOrdersLoading) ||
                          (id == 4 && !controller.missingOrdersLoading))
                  ? Center(
                      child: Text(
                        'لا يوجد طلبات لعرضها',
                        style: TextStyle(fontFamily: Constans.kFontFamily),
                      ),
                    )
                  : Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: MediaQuery.sizeOf(context).width,
                          child: ListView.builder(
                              itemCount: (id == 1 &&
                                          controller.pendingOrdersLoading) ||
                                      (id == 2 &&
                                          controller.cancelledOrdersLoading) ||
                                      (id == 3 &&
                                          controller.acceptedOrdersLoading) ||
                                      (id == 4 &&
                                          controller.missingOrdersLoading)
                                  ? 4
                                  : orders.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: (id == 1 &&
                                              controller
                                                  .pendingOrdersLoading) ||
                                          (id == 2 &&
                                              controller
                                                  .cancelledOrdersLoading) ||
                                          (id == 3 &&
                                              controller
                                                  .acceptedOrdersLoading) ||
                                          (id == 4 &&
                                              controller.missingOrdersLoading)
                                      ? ShimmerContainer(
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          height: 150,
                                          circularRadius: 16,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 16),
                                        )
                                      : OrderCard(
                                          model: orders[index],
                                          id: id,
                                          isArchived: false,
                                        ),
                                );
                              }),
                        ),
                      ],
                    );
        });
  }
}
