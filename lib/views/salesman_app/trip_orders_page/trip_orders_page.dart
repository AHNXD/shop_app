import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/salesman/trip_controller.dart';
import 'package:shop_app/models/salesman/trip_model.dart';
import 'package:shop_app/views/salesman_app/trip_orders_page/widgets/trip_order_tap_body.dart';
import 'package:shop_app/views/salesman_app/trip_orders_page/widgets/trip_order_taps.dart';

class TripOrdersPage extends StatelessWidget {
  const TripOrdersPage({super.key, required this.tripModel});
  final TripModel tripModel;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripPageController>(
        init: TripPageController(),
        builder: (controller) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  backgroundColor: const Color(0xFFF3F4F6),
                  appBar: AppBar(
                    title: const Text(
                      "الطلبات",
                      style: TextStyle(
                          fontFamily: Constans.kFontFamily,
                          fontWeight: FontWeight.bold),
                    ),
                    centerTitle: true,
                    backgroundColor: const Color(0xFFF3F4F6),
                  ),
                  body: Column(
                    children: [
                      TripOrdersTaps(),
                      SizedBox(
                        height: 20,
                      ),
                      controller.showTripLoading
                          ? Expanded(
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Constans.kMainColor,
                              )),
                            )
                          : Expanded(
                              child: TabBarView(
                                children: [
                                  TripsOrderTapBody(
                                    tripModel: tripModel,
                                    orders: controller.model!.pendingOrders,
                                    isArchive: false,
                                  ),
                                  TripsOrderTapBody(
                                    tripModel: tripModel,
                                    orders: controller.model!.archivesOrders,
                                    isArchive: true,
                                  ),
                                  // TripsOrderTapBody(),
                                ],
                              ),
                            )
                    ],
                  ),
                )),
          );
        });
  }
}
