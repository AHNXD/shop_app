import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constans.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/models/salesman/trip_details_model.dart';
import 'package:shop_app/models/salesman/trip_model.dart';
import 'package:shop_app/views/auth_pages/login_page/login_page.dart';

class TripPageController extends GetxController {
  bool showFilter = false;
  String? tripDate = DateTime.now().toString().substring(0, 11);

  List<TripModel> allTrips = [];
  bool tripsLoading = false;
  bool tripsLoadingError = false;
  Future getAllTrips(context) async {
    try {
      allTrips = [];
      tripsLoading = true;
      tripsLoadingError = false;
      update();
      final response = await http.get(
        Uri.parse("${Constans.kBaseUrl}salesman/trips?date=$tripDate"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userInfo.getString('token')}'
        },
      );
      tripsLoading = false;
      update();
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < data['data'].length; i++) {
          allTrips.add(TripModel.fromJson(data['data'][i]));
        }
      } else if (response.statusCode == 401) {
        Get.offAll(() => LoginPage());
      }
      debugPrint('data trips: ${data}');
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      tripsLoading = false;
      tripsLoadingError = true;
      update();
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  bool showTripLoading = false;
  bool showTripLoadingError = false;
  TripDetailsModel? model;
  Future showTrip(id, context) async {
    try {
      showTripLoading = true;
      showTripLoadingError = false;
      update();
      final response = await http.get(
        Uri.parse("${Constans.kBaseUrl}salesman/trips/$id"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userInfo.getString('token')}'
        },
      );
      showTripLoading = false;
      update();
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        model = TripDetailsModel.fromJson(data['data']);
      }
      debugPrint('data: ${data}');
      debugPrint('model: ${model.toString()}');
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      showTripLoading = false;
      showTripLoadingError = true;
      update();
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getAllTrips(Get.context);
    });
  }
}
