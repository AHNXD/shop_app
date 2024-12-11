import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/views/auth_pages/login_page/login_page.dart';

class OrderPageController extends GetxController {
  List<OrderModel> pendingOrders = [];
  List<OrderModel> acceptedOrders = [];
  List<OrderModel> cancelledOrders = [];
  List<OrderModel> missingOrders = [];
  List<OrderModel> archivesOrders = [];
  bool pendingOrdersLoading = false;
  bool cancelledOrdersLoading = false;
  bool acceptedOrdersLoading = false;
  bool missingOrdersLoading = false;
  bool archivesOrdersLoading = false;
  bool pendingOrdersError = false;
  bool cancelledOrdersError = false;
  bool acceptedOrdersError = false;
  bool missingOrdersError = false;
  bool archivesOrdersError = false;
  Future getAllPendingOrders(context) async {
    try {
      pendingOrdersLoading = true;
      pendingOrdersError = false;
      update();
      final response = await http
          .get(Uri.parse('${Constans.kBaseUrl}orders/pending'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${CacheHelper.getData(key:'token')}'
      });
      var data = jsonDecode(response.body);
      debugPrint('data: $data');
      if (response.statusCode == 200) {
        pendingOrders = [];
        for (var i = 0; i < data['data'].length; i++) {
          pendingOrders.add(OrderModel.fromJson(data['data'][i]));
        }
        pendingOrdersLoading = false;
        update();
        debugPrint('pendingOrders: $pendingOrders');
        return pendingOrders;
      } else if (response.statusCode == 401) {
        Get.offAll(() => LoginPage());
      } else {
        debugPrint('error when get all category');
        return [];
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      pendingOrdersLoading = false;
      pendingOrdersError = true;
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  Future getAllCancelledOrders(context) async {
    try {
      cancelledOrdersLoading = true;
      cancelledOrdersError = false;
      update();
      final response = await http
          .get(Uri.parse('${Constans.kBaseUrl}orders/cancelled'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${CacheHelper.getData(key:'token')}'
      });
      var data = jsonDecode(response.body);
      debugPrint('data: $data');
      if (response.statusCode == 200) {
        cancelledOrders = [];
        for (var i = 0; i < data['data'].length; i++) {
          cancelledOrders.add(OrderModel.fromJson(data['data'][i]));
        }
        cancelledOrdersLoading = false;
        update();
        debugPrint('cancelledOrders: $cancelledOrders');
        return cancelledOrders;
      } else {
        debugPrint('error when get all category');
        return [];
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      cancelOrderLoading = false;
      cancelledOrdersError = true;
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  Future getAllAcceptedOrders(context) async {
    try {
      acceptedOrdersLoading = true;
      acceptedOrdersError = false;
      update();
      final response = await http
          .get(Uri.parse('${Constans.kBaseUrl}orders/accepted'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${CacheHelper.getData(key:'token')}'
      });
      var data = jsonDecode(response.body);
      debugPrint('data: $data');
      if (response.statusCode == 200) {
        acceptedOrders = [];
        for (var i = 0; i < data['data'].length; i++) {
          acceptedOrders.add(OrderModel.fromJson(data['data'][i]));
        }
        acceptedOrdersLoading = false;
        update();
        debugPrint('acceptedOrders: $acceptedOrders');
        return acceptedOrders;
      } else {
        debugPrint('error when get all category');
        return [];
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      acceptedOrdersLoading = false;
      acceptedOrdersError = true;

      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  Future getAllMissingOrders(context) async {
    try {
      missingOrdersLoading = true;
      missingOrdersError = false;
      update();
      final response = await http
          .get(Uri.parse('${Constans.kBaseUrl}orders/missing'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${CacheHelper.getData(key:'token')}'
      });
      var data = jsonDecode(response.body);
      debugPrint('data: $data');
      if (response.statusCode == 200) {
        missingOrders = [];
        for (var i = 0; i < data['data'].length; i++) {
          missingOrders.add(OrderModel.fromJson(data['data'][i]));
        }
        missingOrdersLoading = false;
        update();
        debugPrint('missingOrders: $missingOrders');
        return missingOrders;
      } else {
        debugPrint('error when get all category');
        return [];
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      missingOrdersLoading = false;
      missingOrdersError = true;

      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  Future getAllArchivesOrders(context) async {
    try {
      archivesOrdersLoading = true;
      archivesOrdersError = false;
      update();
      final response = await http
          .get(Uri.parse('${Constans.kBaseUrl}orders/archived'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${CacheHelper.getData(key:'token')}'
      });
      var data = jsonDecode(response.body);
      debugPrint('data: $data');
      if (response.statusCode == 200) {
        archivesOrders = [];
        for (var i = 0; i < data['data'].length; i++) {
          archivesOrders.add(OrderModel.fromJson(data['data'][i]));
        }
        archivesOrdersLoading = false;
        update();
        debugPrint('archivedOrders: $archivesOrders');
        return archivesOrders;
      } else {
        debugPrint('error when get archived Orders');
        return [];
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      archivesOrdersLoading = false;
      archivesOrdersError = true;

      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  Future getAllOrder(context) async {
    await getAllPendingOrders(context);
    await getAllAcceptedOrders(context);
    await getAllMissingOrders(context);
    await getAllCancelledOrders(context);
    update();
  }

  Future showOrder(id, context) async {
    try {
      final response =
          await http.get(Uri.parse('${Constans.kBaseUrl}orders/$id'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${CacheHelper.getData(key:'token')}'
      });
      var data = jsonDecode(response.body);
      debugPrint('data: $data');
      if (response.statusCode == 200) {
        debugPrint('show order success');
        return data['data'];
      } else {
        debugPrint('error when get show order $data');
        return false;
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  Future showArchiveOrder(id, context) async {
    try {
      final response = await http
          .get(Uri.parse('${Constans.kBaseUrl}orders/archived/$id'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${CacheHelper.getData(key:'token')}'
      });
      var data = jsonDecode(response.body);
      debugPrint('data: $data');
      if (response.statusCode == 200) {
        debugPrint('show order success');
        return data['data'];
      } else {
        debugPrint('error when get show order $data');
        return false;
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  bool cancelOrderLoading = false;
  Future cancelOrder(id, context) async {
    try {
      cancelOrderLoading = true;
      update();
      final response = await http.delete(
          Uri.parse('${Constans.kBaseUrl}orders/${id.toString()}'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${CacheHelper.getData(key:'token')}'
          });
      cancelOrderLoading = false;
      update();
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSuccesSnackBar('تم بنجاح', data['message'].toString())
            .show(context);
        return true;
      } else {
        showErrorSnackBar('حدث خطأ', data['message'].toString()).show(context);
        return false;
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      cancelOrderLoading = false;
      update();
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await getAllPendingOrders();
    });
  }
}
