import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constans.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/main_page.dart';
import 'package:shop_app/models/city_model.dart';
import 'package:shop_app/views/auth_pages/login_page/login_page.dart';
import 'package:shop_app/views/salesman_app/trip_page/trips_page.dart';

class AuthController extends GetxController {
  Future<bool> locationService() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    locationData = await location.getLocation();
    longitude = locationData.longitude.toString();
    debugPrint('longitude: ${longitude}');
    latitude = locationData.latitude.toString();
    debugPrint('latitude: ${latitude}');
    return true;
  }

  List<CityModel> cities = [];
  bool citiesLoading = false;
  bool citiesError = false;
  Future<List<CityModel>> getAllCities(context) async {
    try {
      citiesError = false;
      citiesLoading = true;
      cities = [];
      update();
      final response = await http.get(
          Uri.parse(
            '${Constans.kBaseUrl}cities/list',
          ),
          headers: {'Accept': 'application/json'});
      citiesLoading = false;
      update();
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        debugPrint('jfhh');
        for (var i = 0; i < data['data'].length; i++) {
          final CityModel model = CityModel.fromJson(data['data'][i]);
          cities.add(model);
        }
        debugPrint('cities: ${cities.length}');
      } else {
        debugPrint('error when get cities');
      }
      return [];
    } on Exception catch (e) {
      citiesLoading = false;
      citiesError = true;
      update();
      debugPrint('e: ${e}');
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
      return [];
    }
  }

  String userName = '';
  String phoneNumber = '';
  String password = '';
  String addressId = '';
  String locationDetails = '';
  String longitude = '';
  String latitude = '';
  String startTime = "";
  String endTime = "";
  Future registerUser(context) async {
    try {
      if (addressId == '') {
        addressId = cities[0].addresses[0].id.toString();
        debugPrint('addressId: $addressId');
      }
      var headers = {'Accept': 'application/json'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('${Constans.kBaseUrl}auth/register'));
      request.fields.addAll({
        'name': userName,
        'contact': phoneNumber,
        'password': password,
        'address_id': addressId,
        'location_details': locationDetails,
        'longitude': longitude,
        'latitude': latitude,
        'start_time': startTime,
        'end_time': endTime
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var data = jsonDecode(await response.stream.bytesToString());
      debugPrint('register: ${data}');
      if (response.statusCode == 200) {
        showSuccesSnackBar('تم انشاء الحساب', data['message']).show(context);
        Get.offAll(() => const LoginPage());
        debugPrint('data $data');
      } else {
        if (data['message'] != null) {
          showErrorSnackBar(
                  'حدث خطأ', data['message'][0] ?? "اعد المحاولة لاحقا")
              .show(context);
          debugPrint('data $data');
        } else {
          showErrorSnackBar('حدث خطأ', 'تاكد من بياناتك واعد المحاولة')
              .show(context);
          debugPrint('data $data');
        }
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  // Future loginUser(String phone, pass) async {
  //   final response = await http.post(
  //       Uri.parse('${Constans.kBaseUrl}auth/login'),
  //       headers: {'Accept': 'application/json'},
  //       body: jsonEncode({'contact': phone, 'password': pass}));
  //   var data = jsonDecode(response.body);
  //   debugPrint('login: ${data}');
  // }
  Future loginUser(context) async {
    try {
      var headers = {'Accept': 'application/json'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('${Constans.kBaseUrl}auth/login'));
      request.fields.addAll({
        'contact': phoneNumber,
        'password': password,
        'device_token': CacheHelper.getData(key: "FCMtoken")
        //'device_token': userInfo.getString('fcm_token')!
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var data = jsonDecode(await response.stream.bytesToString());
      handleLoginResponseStatus(response, data, context);
      debugPrint('login data$data');
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  void handleLoginResponseStatus(
      http.StreamedResponse response, data, context) {
    try {
      if (response.statusCode == 200) {
        CacheHelper.setString(key: 'role', value: data['data']['user']['role']);
        debugPrint('userInfo.getString: ${CacheHelper.getData(key: 'role')}');
        if (data['success'] == true) {
          CacheHelper.getData(key: 'role') == "customer"
              ? Get.offAll(() => const MainPage())
              : Get.offAll(() => TripsPage());
          CacheHelper.setString(
              key: 'id', value: data['data']['user']['id'].toString());
          CacheHelper.setString(
              key: 'name', value: data['data']['user']['name']);
          CacheHelper.setString(
              key: 'contact', value: data['data']['user']['contact']);
          CacheHelper.setString(
              key: 'longitude',
              value: data['data']['user']['longitude'].toString());
          CacheHelper.setString(
              key: 'latitude',
              value: data['data']['user']['latitude'].toString());
          if (CacheHelper.getData(key: 'role') == 'customer') {
            CacheHelper.setString(
                key: 'location_details',
                value: data['data']['user']['location_details'].toString());
            CacheHelper.setString(
                key: 'token', value: data['data']['access_token']);
            CacheHelper.setString(
                key: 'address_id',
                value: data['data']['user']['address']['id'].toString());
            CacheHelper.setString(
                key: 'address_name',
                value: data['data']['user']['address']['name']);
            CacheHelper.setString(
                key: 'city_id',
                value:
                    data['data']['user']['address']['city']['id'].toString());
            CacheHelper.setString(
                key: 'city_name',
                value: data['data']['user']['address']['city']['name']);
          } else {
            CacheHelper.setString(
                key: 'token', value: data['data']['access_token']);
          }
        }
      } else {
        if (data['message'] is String) {
          showInfoSnackBar(
            'حدث خطأ',
            data['message'],
          ).show(context);
          return;
        } else if ((data['message'] is Map<String, dynamic>)) {
          if (data['message'].containsKey('contact')) {
            showErrorSnackBar(
              'حدث خطأ',
              data['message']['contact'][0],
            ).show(context);
          } else {
            showErrorSnackBar(
              'حدث خطأ',
              'حاول مرة اخرى',
            ).show(context);
          }
        } else {
          showErrorSnackBar(
            'حدث خطأ',
            'حاول مرة اخرى',
          ).show(context);
        }
      }
    } on Exception catch (e) {
      debugPrint('e: ${e}');
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
    }
  }

  Future logout(context) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://62.72.13.145:8090/preview/alwasit.com/api/auth/logout'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
        },
      );
      debugPrint('data: ${response.statusCode}}');
      if (response.statusCode >= 200 || response.statusCode < 300) {
        return true;
      }
      return false;
    } on Exception catch (e) {
      debugPrint('e: ${e.toString()}');
      showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا").show(context);
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getAllCities(Get.context);
    });
  }
}
