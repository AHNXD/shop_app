import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/salesman/trip_controller.dart';
import 'package:shop_app/models/salesman/trip_model.dart';
import 'package:shop_app/models/salesman/trip_order_model.dart';
import 'package:shop_app/views/salesman_app/trip_orders_page/widgets/trip_order_card.dart';
import 'package:shop_app/views/shimmer/shimmer_container.dart';

class TripsOrderTapBody extends StatelessWidget {
  const TripsOrderTapBody({
    super.key,
    this.orders,
    required this.isArchive,
    required this.tripModel,
  });
  final List<TripOrderModel>? orders;
  final bool isArchive;
  final TripModel tripModel;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripPageController>(
        init: TripPageController(),
        builder: (controller) {
          return controller.showTripLoading
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Constans.kMainColor,
                    ),
                  ),
                )
              : controller.showTripLoadingError && !controller.showTripLoading
                  ? Center(
                      child: Text(
                        "حدث خطأ اثناء تحميل الطلبات ",
                        style: TextStyle(fontFamily: Constans.kFontFamily),
                      ),
                    )
                  : (orders!.isEmpty)
                      ? Center(
                          child: Text(
                            "لا يوجد لديك اي طلبات",
                            style: TextStyle(fontFamily: Constans.kFontFamily),
                          ),
                        )
                      : ListView.builder(
                          itemCount: orders!.length,
                          itemBuilder: (context, index) {
                            return controller.showTripLoading
                                ? ShimmerContainer(
                                    width: MediaQuery.sizeOf(context).width,
                                    height: 200,
                                    circularRadius: 16,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                  )
                                : TripOrderCard(
                                    tripModel: tripModel,
                                    pendingOrder: orders!,
                                    orderIndex: index,
                                    model: orders![index],
                                    isArchive: isArchive);
                          });
        });
  }
}
