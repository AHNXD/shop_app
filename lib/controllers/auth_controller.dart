import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constans.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/main.dart';
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
        userInfo.setString('role', data['data']['user']['role']);
        debugPrint('userInfo.getString: ${userInfo.getString('role')}');
        if (data['success'] == true) {
          userInfo.getString('role') == "customer"
              ? Get.offAll(() => const MainPage())
              : Get.offAll(() => TripsPage());
          userInfo.setString('id', data['data']['user']['id'].toString());
          userInfo.setString('name', data['data']['user']['name']);
          userInfo.setString('contact', data['data']['user']['contact']);
          userInfo.setString(
              'longitude', data['data']['user']['longitude'].toString());
          userInfo.setString(
              'latitude', data['data']['user']['latitude'].toString());
          if (userInfo.getString('role') == 'customer') {
            userInfo.setString('location_details',
                data['data']['user']['location_details'].toString());
            userInfo.setString('token', data['data']['access_token']);
            userInfo.setString(
                'address_id', data['data']['user']['address']['id'].toString());
            userInfo.setString(
                'address_name', data['data']['user']['address']['name']);
            userInfo.setString('city_id',
                data['data']['user']['address']['city']['id'].toString());
            userInfo.setString(
                'city_name', data['data']['user']['address']['city']['name']);
          } else {
            userInfo.setString('token', data['data']['access_token']);
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
          'Authorization': 'Bearer ${userInfo.getString('token')}'
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
