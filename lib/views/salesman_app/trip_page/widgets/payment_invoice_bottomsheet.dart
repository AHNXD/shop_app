
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/salesman/invoice_controller.dart';
import 'package:shop_app/models/salesman/user_invoice_info.dart';
import 'package:shop_app/views/auth_pages/login_page/widgets/custom_button.dart';
import 'package:shop_app/widgets/custom_text_field.dart';

class PaymentAmountBottomSheet extends StatefulWidget {
  const PaymentAmountBottomSheet({
    super.key,
    required this.model,
  });
  final UserInvoiceInfo model;
  @override
  State<PaymentAmountBottomSheet> createState() => _InvoiceBottomSheetState2();
}

class _InvoiceBottomSheetState2 extends State<PaymentAmountBottomSheet> {
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
    return GetBuilder<InvoiceController>(
      builder: (controller) {
        return Form(
          key: formKey,
          autovalidateMode: controller.autovalidateMode,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'الرجاء ادخال بيانات  الفاتورة',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: Constans.kFontFamily),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "اسم الزبون : ${widget.model.name}",
                    style: TextStyle(fontFamily: Constans.kFontFamily),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "رقم الزبون : ${widget.model.contact}",
                    style: TextStyle(fontFamily: Constans.kFontFamily),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "اجمالي المشتريات : ${widget.model.totalPurchases}",
                    style: TextStyle(fontFamily: Constans.kFontFamily),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "اجمالي الدفعات : ${widget.model.totalPayments}",
                    style: TextStyle(fontFamily: Constans.kFontFamily),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "الدفعات المتبقية : ${widget.model.remaining}",
                    style: TextStyle(fontFamily: Constans.kFontFamily),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      isPrice: true,
                      onChanged: (p0) {
                        amount = p0;
                      },
                      textStyle: TextStyle(fontFamily: Constans.kFontFamily),
                      cursorColor: Constans.kMainColor,
                      label: 'قيمة الفاتورة',
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
                        if (controller.createInvoiceLoading) {
                        } else {
                          await controller.createInvoice(
                              amount, widget.model.id.toString(), context);
                        }
                      } else {
                        controller.autovalidateMode = AutovalidateMode.always;
                        controller.update();
                      }
                    },
                    title: controller.createInvoiceLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "تأكيد الفاتورة",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: Constans.kFontFamily),
                          ),
                    color: Constans.kMainColor,
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
