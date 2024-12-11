import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/models/salesman/order_details_model.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  bool showOrderLoading = false;
  Future showOrder(id, context) async {
    try {
      showOrderLoading = true;
      update();
      final response = await http.get(
        Uri.parse('${Constans.kBaseUrl}orders/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
        },
      );
      showOrderLoading = false;
      update();
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return OrderDetailsModel.fromJson(data['data']);
      } else {
        debugPrint('erro when show Order');
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  Future showArchiveOrder(id, context) async {
    try {
      showOrderLoading = true;
      update();
      final response = await http.get(
        Uri.parse('${Constans.kBaseUrl}orders/archived/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
        },
      );
      showOrderLoading = false;
      update();
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return OrderDetailsModel.fromJson(data['data']);
      } else {
        debugPrint('erro when show Order');
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  Future markOrderAsDelivered(id, payment, context) async {
    try {
      final response = await http
          .put(Uri.parse('${Constans.kBaseUrl}orders/$id/delivered'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
      }, body: {
        'payment': payment.toString()
      });
      var data = jsonDecode(response.body);
      debugPrint('data: ${data}');
      if (response.statusCode == 200) {
        return data['message'];
      }
      return data['message'];
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  Future markOrderAsMissing(id, explaination, context) async {
    try {
      final response = await http
          .put(Uri.parse('${Constans.kBaseUrl}orders/$id/missing'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
      }, body: {
        'reason': explaination.toString()
      });
      var data = jsonDecode(response.body);
      debugPrint('data: ${data}');
      if (response.statusCode == 200) {
        return data['message'];
      }
      return data['message'];
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }
}
