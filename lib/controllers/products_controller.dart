import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/home_page_controller.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';

class ProductsController extends GetxController {
  final scrollController = ScrollController();
  final controller = Get.put(HomePageController());
  bool hasMoreData = true;
  List productsList = [];
  int? selectedCategory;
  int? companyId;
  int pageNumber = 1;
  String searchText = '';
  bool productsLoading = false;
  bool productsError = false;
  Future getAllProducts() async {
    String url = "";
    if (companyId != null) {
      url =
          "${Constans.kBaseUrl}products/customers/index?category_id=$selectedCategory&company_id=$companyId&page=$pageNumber&s=$searchText";
    } else {
      url =
          "${Constans.kBaseUrl}products/customers/index?category_id=$selectedCategory&page=$pageNumber&s=$searchText";
    }

    productsError = false;
    try {
      if (pageNumber == 1) {
        productsLoading = true;
        productsList.clear();
        update();
      }
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
      };
      log("The token is: ${CacheHelper.getData(key: 'token')}");
      log("The headers is: ${headers}");
      final response = await http.get(Uri.parse(url), headers: headers);
      log('page $pageNumber');
      log(response.body);
      var data = jsonDecode(response.body);
      log(url);
      log('products: ${data['data']}');
      if (pageNumber == 1) {
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

  @override
  void onClose() {
    super.onClose();
    log("CompaniesController deleted");
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
      pageNumber++;
      await getAllProducts();
      isLoadingMoreData = false;
      update();
      debugPrint("$pageNumber ${controller.selectedCategoryId}");
    }
  }
}
