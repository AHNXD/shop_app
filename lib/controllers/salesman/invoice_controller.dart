import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constans.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/models/salesman/user_invoice_info.dart';

class InvoiceController extends GetxController {
  bool getUserLoading = false;
  Future getUser(contact, context) async {
    try {
      getUserLoading = true;
      update();
      final response = await http.get(
          Uri.parse('${Constans.kBaseUrl}payments/user?contact=$contact'),
          headers: {
            "Accept": 'application/json',
            'Authorization': 'Bearer ${userInfo.getString('token')}'
          });
      getUserLoading = false;
      update();
      var data = jsonDecode(response.body);
      debugPrint('get user info : ${data}');
      if (response.statusCode == 200) {
        debugPrint(data.toString());
        debugPrint('get user success');
        return UserInvoiceInfo.fromJson(data['data']);
      } else if (data['message'] != null) {
        showErrorSnackBar('حدث خطأ', data['message']).show(context);
        return false;
      } else {
        showErrorSnackBar('حدث خطأ', 'الرجاء اعادة المحاولة لاحقا')
            .show(context);
        return false;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      getUserLoading = false;
      update();
      showErrorSnackBar('حدث خطأ', 'الرجاء اعادة المحاولة لاحقا').show(context);

      return false;
    }
  }

  bool createInvoiceLoading = false;
  bool createInvoiceLoadingError = false;
  Future createInvoice(amount, customerId, context) async {
    debugPrint('amount: ${amount}');
    try {
      createInvoiceLoading = true;
      createInvoiceLoadingError = false;
      update();
      final response =
          await http.post(Uri.parse("${Constans.kBaseUrl}payments"), headers: {
        "Accept": 'application/json',
        'Authorization': 'Bearer ${userInfo.getString('token')}'
      }, body: {
        'amount': amount,
        'customer_id': customerId
      });
      createInvoiceLoading = false;
      update();
      var data = jsonDecode(response.body);
      debugPrint('crate invoice info : ${data}');
      if (response.statusCode == 200) {
        debugPrint('crate invoice success');
        showSuccesSnackBar('تم بنجاح', 'تم اضافة الفاتورة بنجاح').show(context);
        return true;
      } else if (data['message'] != null) {
        showErrorSnackBar('حدث خطأ', data['message']).show(context);
        return false;
      } else {
        showErrorSnackBar('حدث خطأ', 'الرجاء اعادة المحاولة لاحقا')
            .show(context);
      }
    } catch (e) {
      debugPrint(e.toString());
      createInvoiceLoading = false;
      createInvoiceLoadingError = true;
      update();
      showErrorSnackBar('حدث خطأ', 'الرجاء اعادة المحاولة لاحقا').show(context);

      return false;
    }
  }

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
}
