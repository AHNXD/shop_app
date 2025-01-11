import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/models/salesman/trip_order_model.dart';
import 'package:shop_app/views/auth_pages/login_page/widgets/custom_button.dart';
import 'package:shop_app/views/salesman_app/order_details.dart/widgets/submit_order_bottomsheet.dart';

class OrderDetailsFooter extends StatelessWidget {
  const OrderDetailsFooter({
    super.key,
    this.pendingOrders,
    this.orderIndex,
    required this.id,
    required this.tripId,
  });
  final List<TripOrderModel>? pendingOrders;
  final int? orderIndex;
  final int id;
  final int tripId;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            onTap: () {
              Get.bottomSheet(SubmitOrderBottomSheet(
                tripId: tripId,
                id: id,
                title: 'الرجاء ادخال المبلغ المدفوع من قبل الزبون',
                label: 'المبلغ',
                keyboardType: TextInputType.number,
                buttonText: 'تسليم الطلب',
                callDelivered: true,
              ));
            },
            width: MediaQuery.sizeOf(context).width / 2 - 10,
            padding: EdgeInsets.all(16),
            title: Text(
              'تسليم الطلب',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: Constans.kFontFamily),
            ),
            color: Constans.kMainColor,
          ),
          CustomButton(
            onTap: () {
              Get.bottomSheet(SubmitOrderBottomSheet(
                tripId: tripId,
                id: id,
                orderIndex: orderIndex,
                pendingOrders: pendingOrders,
                title: 'الرجاء ادخال سبب عدم تسليم الطلب',
                label: 'السبب',
                keyboardType: TextInputType.text,
                buttonText: 'تجاهل الطلب',
                callDelivered: false,
              ));
            },
            width: MediaQuery.sizeOf(context).width / 2 - 10,
            padding: EdgeInsets.all(16),
            title: Text(
              'تجاهل الطلب',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: Constans.kFontFamily),
            ),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
