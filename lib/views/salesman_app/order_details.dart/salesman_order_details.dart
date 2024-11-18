import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/salesman/order_controller.dart';
import 'package:shop_app/models/salesman/order_details_model.dart';
import 'package:shop_app/models/salesman/trip_model.dart';
import 'package:shop_app/models/salesman/trip_order_model.dart';
import 'package:shop_app/views/salesman_app/order_details.dart/widgets/details_order_prodicts_list.dart';
import 'package:shop_app/views/salesman_app/order_details.dart/widgets/order_details_footer.dart';

class SalesmanOrderDetails extends StatelessWidget {
  SalesmanOrderDetails(
      {super.key,
      required this.orderModel,
      required this.isArchive,
      this.pendingOrders,
      this.orderIndex,
      required this.tripModel});
  final OrderDetailsModel orderModel;
  final bool isArchive;
  final List<TripOrderModel>? pendingOrders;
  final int? orderIndex;
  final TripModel tripModel;
  final controller = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F6),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: const Color(0xFFF3F4F6),
          title: Text(
            "تفاصيل الطلب",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: Constans.kFontFamily),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: DetailsOrderProductsList(
                  isArchive: isArchive, orderModel: orderModel),
            ),
            isArchive || orderModel.status != "accepted"||tripModel.date!=DateTime.now().toString().substring(0,10)
                ? Container()
                : OrderDetailsFooter(
                    tripId: tripModel.id.toInt(),
                    id: orderModel.id!.toInt(),
                    pendingOrders: pendingOrders,
                    orderIndex: orderIndex)
          ],
        ),
      ),
    );
  }
}
