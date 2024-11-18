import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/home_page_controller.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/main.dart';

class ProductsController extends GetxController {
  final scrollController = ScrollController();
  final controller = Get.put(HomePageController());
  bool hasMoreData = true;
  List productsList = [];
  int? selectedCategory;
  int pageNumberr = 1;
  String searchText = '';
  bool productsLoading = false;
  bool productsError = false;
  Future getAllProducts() async {
    productsError = false;
    try {
      if (pageNumberr == 1) {
        productsLoading = true;
        productsList.clear();
        update();
      }
      final response = await http.get(
          Uri.parse(
              '${Constans.kBaseUrl}products?category_id=${selectedCategory.toString()}&page=$pageNumberr&s=$searchText'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${userInfo.getString('token')}'
          });
      log('page $pageNumberr');
      var data = jsonDecode(response.body);
      log('${Constans.kBaseUrl}products?category_id=${controller.selectedCategoryId.toInt().toString()}&page=$pageNumberr&s=$searchText');
      log('products: ${data['data']}');
      if (pageNumberr == 1) {
        productsLoading = false;
        update();
      }
      if (response.statusCode == 200) {
        productsList += data['data']['products'];
        hasMoreData = data['data']['has_next'];
        return data['data']['products'];
      } else {
        debugPrint('products: $data');
        debugPrint('error when get all products');
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      productsLoading = false;
      productsError = true;
      update();
      showErrorSnackBar('حدث خطأ', "حدث خطأ الرجاء اعادة المحاولة");
    }
  }

  int page = 1;
  @override
  void onInit() {
    update();
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await getAllProducts(1);
      // update();
      scrollController.addListener(_scrollListener);
    });
  }

  bool isLoadingMoreData = false;
  Future<void> _scrollListener() async {
    if (isLoadingMoreData) return;
    if ((scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) &&
        (hasMoreData)) {
      isLoadingMoreData = true;
      update();
      page = page + 1;
      pageNumberr++;
      await getAllProducts();
      isLoadingMoreData = false;
      update();
      debugPrint("$pageNumberr ${controller.selectedCategoryId}");
    }
  }
}
