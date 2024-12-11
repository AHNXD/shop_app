import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constans.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/models/company_model.dart';
import 'package:shop_app/models/invoices_model.dart';

class InvoicesController extends GetxController {
  bool showFilter = false;
  List<InvoicesModel> invoicesList = [];
  bool invoicesLoading = false;
  bool invoicesError = false;
  Future getAllInvoices(
      String companyId, String startDate, String endDate, context) async {
    try {
      invoicesList = [];
      invoicesLoading = true;
      invoicesError = false;
      update();
      final response = await http.get(
        Uri.parse(
            '${Constans.kBaseUrl}payments?company_id=$companyId&$startDate=&end_date=$endDate'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${CacheHelper.getData(key:'token')}'
        },
      );
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var i = 0; i < data['data'].length; i++) {
          invoicesList.add(InvoicesModel.fromJson(data['data'][i]));
        }
        debugPrint('invoicesList: $invoicesList');
        invoicesLoading = false;
        update();
      } else {
        debugPrint('error when get invoices ${jsonDecode(response.body)}');
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      invoicesLoading = false;
      invoicesError = true;
      update();
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  List<CompanyModel> companies = [];
  Future getAllCompanies(context) async {
    try {
      companies = [];
      final response = await http.get(
        Uri.parse('${Constans.kBaseUrl}companies'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${CacheHelper.getData(key:'token')}'
        },
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < data['data'].length; i++) {
          companies.add(CompanyModel.fromJson(data['data'][i]));
        }
        debugPrint('companies: $companies');
      } else {
        debugPrint('error when get companies');
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  Future invoices(context) async {
    await getAllInvoices('', '', '', context);
    await getAllCompanies(context);
  }


}
