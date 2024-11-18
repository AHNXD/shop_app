import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/salesman/trip_controller.dart';
import 'package:shop_app/models/salesman/trip_model.dart';
import 'package:shop_app/views/salesman_app/trip_orders_page/trip_orders_page.dart';

class TripsCard extends StatelessWidget {
  const TripsCard({
    super.key,
    required this.model,
  });
  final TripModel model;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripPageController>(
        init: TripPageController(),
        builder: (controller) {
                    return GestureDetector(
            onTap: controller.showTripLoading
                ? null
                : () async {
                    Get.to(() => TripOrdersPage(tripModel: model));
                    await controller.showTrip(model.id.toString(),context);
                  },
            child: Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.addressName,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: Constans.kFontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'عدد الطلبات:',
                          style: TextStyle(
                            fontFamily: Constans.kFontFamily,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '${model.ordersNumber}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // SizedBox(width: 4),
                      ],
                    ),
                    SizedBox(height: 20, child: VerticalDivider()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'رقم الرحلة: ${model.id}',
                          style: TextStyle(
                            fontFamily: Constans.kFontFamily,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'تاريخ الرحلة:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${model.date} ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
