import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/models/ads_model.dart';
import 'package:shop_app/models/home_category_model.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/views/auth_pages/login_page/login_page.dart';

class HomePageController extends GetxController {
  List<AdsModel> adsList = [];
  bool categoryLoading = false;
  bool adsLoading = false;
  int selectedCategoryId = 1;
  bool errorLoading = false;
  Future getAllAds() async {
    try {
      errorLoading = false;
      adsLoading = true;
      update();
      final response =
          await http.get(Uri.parse('${Constans.kBaseUrl}ads/list'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userInfo.getString('token')}'
      });
      var data = jsonDecode(response.body);
      debugPrint('data: ${data}');
      if (response.statusCode == 200) {
        adsList = [];
        for (var i = 0; i < data['data'].length; i++) {
          adsList.add(AdsModel.fromJson(data['data'][i]));
        }
        adsLoading = false;
        update();
        return adsList;
      } else if (response.statusCode == 401) {
        Get.offAll(() => LoginPage());
      } else {
        debugPrint('error when get all Ads');
        return;
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      adsLoading = false;
      errorLoading = true;
    }
  }

  List<HomeCategoryModel> categoryList = [];
  bool categoryLoadingError = false;
  Future getAllCategories() async {
    try {
      categoryLoadingError = false;
      categoryLoading = true;
      update();
      final response =
          await http.get(Uri.parse('${Constans.kBaseUrl}categories'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userInfo.getString('token')}'
      });
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        categoryList = [];
        for (var i = 0; i < data['data'].length; i++) {
          categoryList.add(HomeCategoryModel.fromJson(data['data'][i]));
        }
        categoryLoading = false;
        update();
        return categoryList;
      } else if (response.statusCode == 401) {
        Get.offAll(() => LoginPage());
      } else {
        debugPrint('error when get all category');
        return;
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      categoryLoading = false;
      categoryLoadingError = true;
    }
  }

  bool homePageLoading = false;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      homePageLoading = true;
      update();
      await getAllAds();
      await getAllCategories();
      homePageLoading = false;
      update();
    });
  }
}
