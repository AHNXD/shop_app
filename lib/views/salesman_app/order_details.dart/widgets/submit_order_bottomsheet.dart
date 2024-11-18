// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/salesman/order_controller.dart';
import 'package:shop_app/controllers/salesman/trip_controller.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/models/salesman/trip_order_model.dart';
import 'package:shop_app/views/auth_pages/login_page/widgets/custom_button.dart';
import 'package:shop_app/widgets/custom_text_field.dart';

class SubmitOrderBottomSheet extends StatefulWidget {
  const SubmitOrderBottomSheet(
      {super.key,
      required this.title,
      required this.label,
      required this.keyboardType,
      required this.buttonText,
      required this.callDelivered,
      this.pendingOrders,
      this.orderIndex,
      required this.id,
      required this.tripId});
  final String title;
  final String label;
  final TextInputType keyboardType;
  final String buttonText;
  final bool callDelivered;
  final List<TripOrderModel>? pendingOrders;
  final int? orderIndex;
  final int id;
  final int tripId;

  @override
  State<SubmitOrderBottomSheet> createState() => _SubmitOrderBottomSheetState();
}

class _SubmitOrderBottomSheetState extends State<SubmitOrderBottomSheet> {
  var details = "";
  bool isLoading = false;
  final OrderController orderController = Get.put(OrderController());
  late GlobalKey<FormState> formKey;
  late AutovalidateMode autoValidateMode;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey();
    autoValidateMode = AutovalidateMode.disabled;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripPageController>(
      init: TripPageController(),
      builder: (tripController) => Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: formKey,
          autovalidateMode: autoValidateMode,
          child: Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: Constans.kFontFamily),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    isExplaination: widget.callDelivered ? false : true,
                    isPrice: widget.callDelivered ? true : false,
                    onChanged: (p0) {
                      details = p0;
                    },
                    textStyle: TextStyle(fontFamily: Constans.kFontFamily),
                    cursorColor: Constans.kMainColor,
                    label: widget.label,
                    labelStyle: TextStyle(
                        fontFamily: Constans.kFontFamily, color: Colors.black),
                    filled: true,
                    fillColor: const Color(0xFFF3F4F6),
                    focusedBorderColor: Constans.kMainColor,
                    enabledBorderColor: Colors.transparent,
                    keyboardType: widget.keyboardType),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (isLoading != true) {
                          if (widget.callDelivered) {
                            debugPrint('called delivered order');
                            {
                              if (!(details == '')) {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  await orderController.markOrderAsDelivered(
                                      widget.id, details, context);
                                  await tripController.showTrip(
                                      widget.tripId, context);
                                } on Exception catch (e) {
                                  debugPrint('e: ${e}');
                                  showErrorSnackBar('حدث خطأ',
                                          'الرجاء اعادة المحاولة لاحقا')
                                      .show(context);

                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                                setState(() {
                                  isLoading = false;
                                });
                                tripController.update();
                                orderController.update();
                                Get.back();
                                Get.back();
                              }
                            }
                          } else {
                            debugPrint('called missing order');
                            {
                              if (!(details == '')) {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  await orderController.markOrderAsMissing(
                                      widget.id, details, context);
                                  await tripController.showTrip(
                                      widget.tripId, context);
                                } on Exception catch (e) {
                                  debugPrint('e: ${e}');
                                  showErrorSnackBar('حدث خطأ',
                                          'الرجاء اعادة المحاولة لاحقا')
                                      .show(context);
                                }
                                setState(() {
                                  isLoading = false;
                                });
                                tripController.update();
                                orderController.update();
                                Get.back();
                                Get.back();
                              }
                            }
                          }
                        }
                      }
                    },
                    height: 60,
                    color: Constans.kMainColor,
                    title: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            widget.buttonText,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: Constans.kFontFamily),
                          ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
