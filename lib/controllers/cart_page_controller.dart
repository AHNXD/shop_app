import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/bill_controller.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/models/cart_product_model.dart';

class CartController extends GetxController {
  List<Map<String, String>> cartOrderProducts = [];
  Future addToCart(String id, context) async {
    try {
      final response = await http.post(
        Uri.parse('${Constans.kBaseUrl}carts/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
        },
      );
      var data = jsonDecode(response.body);
      debugPrint('addToCart: $data');
      if (response.statusCode == 200) {
        showSuccesSnackBar('', data['message']).show(context);
        return true;
      } else if (response.statusCode == 400) {
        showErrorSnackBar('', data['message']).show(context);
        return false;
      } else {
        showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
        return false;
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  bool cartLoading = false;
  bool cartLoadingError = false;
  double cartSubTotal = 0;
  List<CartProductModel> cartProducts = [];
  Future getCartProducts(context) async {
    try {
      cartProducts = [];
      cartLoading = true;
      cartLoadingError = false;
      update();
      final response = await http.get(
        Uri.parse('${Constans.kBaseUrl}carts'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
        },
      );
      final controller = Get.put(BillController());
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        cartOrderProducts = [];
        cartLoading = false;
        update();
        for (var i = 0; i < data['data'].length; i++) {
          var productData = {
            'id': data['data'][i]['id'].toString(),
            'quantity': data['data'][i]['quantity'].toString()
          };
          cartProducts.add(CartProductModel.fromJson(data['data'][i]));
          if (!cartOrderProducts.contains(productData)) {
            cartOrderProducts.add(productData);
          }
        }
        debugPrint('cartProducts: $cartProducts');
        controller.getSubTotal();
        return data['data'];
      } else {
        debugPrint('error when get cart products');
        return [];
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      cartLoading = false;
      cartLoadingError = true;
      update();
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  bool editCart = false;
  bool updateCartLoading = false;
  Future updateCart(context) async {
    try {
      updateCartLoading = true;
      update();
      debugPrint('products $cartOrderProducts');
      final response = await http.post(Uri.parse('${Constans.kBaseUrl}carts'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
          },
          body: jsonEncode({'_method': "PUT", 'products': cartOrderProducts}));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        debugPrint('update $data');
        showSuccesSnackBar('تم بنجاح', data['message']).show(context);
      } else {
        debugPrint('update $data');
        showErrorSnackBar('حدث خطأ', data['message'].toString()).show(context);
      }
      updateCartLoading = false;
      update();
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      updateCartLoading = false;
      update();
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  bool submitOrderLoading = false;
  Future submitOrder(context) async {
    try {
      submitOrderLoading = true;
      update();
      final response = await http.post(
        Uri.parse('${Constans.kBaseUrl}carts'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
        },
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        debugPrint('submit order $data');
        showSuccesSnackBar('تم بنجاح', data['message']).show(context);
        submitOrderLoading = false;
        update();
        return true;
      } else {
        debugPrint('submit order $data');
        showErrorSnackBar('حدث خطأ', data['message'].toString()).show(context);
        submitOrderLoading = false;
        update();
        return false;
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      submitOrderLoading = false;
      update();
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }
}
