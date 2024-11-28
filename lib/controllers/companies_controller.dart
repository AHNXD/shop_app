import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constans.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/main.dart';

import '../models/company.dart';

class CompaniesController extends GetxController {
  final companiesList = <CompanyData>[].obs;
  bool companiesLoading = false;
  bool companiesError = false;

  Future<void> fetchCompanies() async {
    companiesError = false;
    companiesLoading = true;
    update();

    try {
      final response = await http.get(
        Uri.parse('${Constans.kBaseUrl}companies'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userInfo.getString('token')}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final companies =
            (data['data'] as List).map((e) => CompanyData.fromJson(e)).toList();

        companiesList.assignAll(companies);
        log('Fetched companies: ${companiesList.length}');
      } else {
        log('Error fetching companies: ${response.body}');
        companiesError = true;
        showErrorSnackBar('خطأ', 'فشل في تحميل الشركات');
      }
    } catch (e) {
      log('Exception: $e');
      companiesError = true;
      showErrorSnackBar('خطأ', 'خطأ غير معروف');
    } finally {
      companiesLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
  }
}
