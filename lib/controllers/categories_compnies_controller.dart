import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constans.dart';
import '../main.dart';
import '../models/home_category_model.dart';
import 'package:http/http.dart' as http;

import '../views/auth_pages/login_page/login_page.dart';

class CategoriesCompniesController extends GetxController {
  List<HomeCategoryModel> categoryList = [];
  bool categoryLoadingError = false;
  bool categoryLoading = false;
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
}
