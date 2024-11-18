import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/salesman/invoice_controller.dart';
import 'package:shop_app/views/auth_pages/login_page/widgets/custom_button.dart';
import 'package:shop_app/views/salesman_app/trip_page/widgets/payment_invoice_bottomsheet.dart';
import 'package:shop_app/widgets/custom_text_field.dart';

class UserContactBottomSheet extends StatefulWidget {
  const UserContactBottomSheet({
    super.key,
  });

  @override
  State<UserContactBottomSheet> createState() => _UserContactBottomSheetState();
}

class _UserContactBottomSheetState extends State<UserContactBottomSheet> {
  final controller = Get.put(InvoiceController());
  String contact = '';
  String amount = '0';
  late GlobalKey<FormState> formKey;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(GetBuilder<InvoiceController>(builder: (controller) {
          return Form(
            key: formKey,
            autovalidateMode: controller.autovalidateMode,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'الرجاء ادخال بيانات  الفاتورة',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: Constans.kFontFamily),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        isPhoneNumber: true,
                        onChanged: (p0) {
                          contact = p0;
                        },
                        textStyle: TextStyle(fontFamily: Constans.kFontFamily),
                        cursorColor: Constans.kMainColor,
                        label: 'رقم الزبون',
                        labelStyle: TextStyle(
                            fontFamily: Constans.kFontFamily,
                            color: Colors.black),
                        filled: true,
                        fillColor: const Color(0xFFF3F4F6),
                        focusedBorderColor: Constans.kMainColor,
                        enabledBorderColor: Colors.transparent,
                        keyboardType: TextInputType.number),
                    SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          if (controller.getUserLoading) {
                          } else {
                            var model =
                                await controller.getUser(contact, context);
                            if (model != false) {
                              Get.back();
                              Get.bottomSheet(
                                  PaymentAmountBottomSheet(model: model));
                            }
                          }
                        } else {
                          controller.autovalidateMode = AutovalidateMode.always;
                          controller.update();
                        }
                      },
                      title: controller.getUserLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "متابعة",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: Constans.kFontFamily),
                            ),
                      color: Constans.kMainColor,
                      height: 60,
                    )
                  ],
                ),
              ),
            ),
          );
        }));
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Constans.kMainColor,
            borderRadius: BorderRadius.circular(16)),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
