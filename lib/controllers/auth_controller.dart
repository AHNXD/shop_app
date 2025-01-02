// ignore_for_file: prefer_interpolation_to_compose_strings

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
import 'package:shop_app/views/profile_page/profile.dart';
import 'package:shop_app/views/salesman_app/trip_page/trips_page.dart';

class AuthController extends GetxController {
  bool isgetLocation = false;
  Future<bool> locationService() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    isgetLocation = true;
    update();
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        isgetLocation = false;
        update();
        return false;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        isgetLocation = false;
        update();
        return false;
      }
    }

    locationData = await location.getLocation();
    longitude = locationData.longitude.toString();
    debugPrint('longitude: ${longitude}');
    latitude = locationData.latitude.toString();
    debugPrint('latitude: ${latitude}');
    CacheHelper.setString(key: 'longitude', value: longitude);
    CacheHelper.setString(key: 'latitude', value: latitude);
    print("Location Saved!");
    isgetLocation = false;
    update();
    return true;
  }

  List<CityModel> cities = [];
  bool citiesLoading = false;
  bool citiesError = false;
  Future<List<CityModel>> getAllCities(context) async {
    try {
      citiesError = false;
      citiesLoading = true;
      cities.clear();
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
        'end_time': endTime,
        'device_token': CacheHelper.getData(key: "fcm_token")
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

  Future loginUser(context) async {
    try {
      var headers = {'Accept': 'application/json'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('${Constans.kBaseUrl}auth/login'));
      request.fields.addAll({
        'contact': phoneNumber,
        'password': password,
        'device_token': CacheHelper.getData(key: "fcm_token")
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
      http.StreamedResponse response, data, context) async {
    try {
      if (response.statusCode == 200) {
        if (data['success']) {
          String role = data['data']['user']['role'];
          CacheHelper.setString(key: 'role', value: role);
          debugPrint('userInfo.getString: ${role}');
          await saveUserInfo(data);
          if (role == "customer") {
            if (data['data']['user']['longitude'] == null &&
                data['data']['user']['latitude'] == null) {
              // showInfoSnackBar(
              //   'الرجاء الإنتظار يتم تحديث الموقع',
              //   data['message'],
              // ).show(context);
              Get.showSnackbar(GetSnackBar(
                backgroundColor: Colors.green,
                borderRadius: 8,
                forwardAnimationCurve: Curves.bounceIn,
                messageText: Text(
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                    'الرجاءالتاكد من المعلومات الشخصية,  ثم قم بحفظ التغيرات'),
                duration: Duration(seconds: 3),
              ));
              Get.offAll(() => ProfilePage());
              // bool result = await locationService();
              // if (result) {
              //   data['data']['user']['longitude'] = longitude;
              //   data['data']['user']['latitude'] = latitude;
              //   getUserInfo();
              //   await updateUserProfile(context: context, isFromLogin: true);
              // } else {
              //   saveUserInfo(data);
              //   Get.offAll(() => TripsPage());
              // }
            } else {
              Get.offAll(() => const MainPage());
            }
          } else {
            Get.offAll(() => TripsPage());
          }
        } else {
          showInfoSnackBar(
            'حدث خطأ',
            data['message'],
          ).show(context);
          return;
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
        Uri.parse('${Constans.kBaseUrl}/auth/logout'),
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

  bool isUpdateProfile = false;
  Future<void> updateUserProfile(
      {required BuildContext context, bool? isFromLogin}) async {
    try {
      isUpdateProfile = true;
      update();
      final response = await http.put(
        Uri.parse('${Constans.kBaseUrl}customers'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
        },
        body: {
          'name': userName,
          'location_details':
              locationDetails == "" ? "حدد الموقع" : locationDetails,
          'longitude': longitude,
          'latitude': latitude,
          'start_time': startTime,
          'end_time': endTime,
          'address_id': addressId
        },
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        CacheHelper.setString(key: 'role', value: data['data']['role']);
        isFromLogin ??
            showSuccesSnackBar('تم تعديل المعلومات بنجاح', data['message'])
                .show(context);
        isUpdateProfile = false;
        update();
        Get.offAll(() => MainPage());
        updateUserInfo(data);
      } else {
        showErrorSnackBar('خطأ', data['message']).show(context);
        isUpdateProfile = false;
        update();
      }
    } catch (e) {
      debugPrint('Error updating profile: $e');
      showErrorSnackBar(
              'خطأ', 'حدث خطأ اثناء تعديل الملف الشخصي الرجاء المحاولة لاحقا')
          .show(context);
      isUpdateProfile = false;
      update();
    }
  }

  void getUserInfo() {
    userName = CacheHelper.getData(key: 'name');
    longitude = CacheHelper.getData(key: 'longitude');
    latitude = CacheHelper.getData(key: 'latitude');
    locationDetails = CacheHelper.getData(key: 'location_details');
    addressId = CacheHelper.getData(key: 'address_id');
    startTime = CacheHelper.getData(key: 'start_time');
    endTime = CacheHelper.getData(key: 'end_time');
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getAllCities(Get.context);
    });
  }

  updateUserInfo(data) {
    CacheHelper.setString(key: 'id', value: data['data']['id'].toString());
    CacheHelper.setString(key: 'name', value: data['data']['name']);
    CacheHelper.setString(key: 'contact', value: data['data']['contact']);
    CacheHelper.setString(
        key: 'longitude', value: data['data']['longitude'].toString());
    CacheHelper.setString(
        key: 'latitude', value: data['data']['latitude'].toString());
    if (CacheHelper.getData(key: 'role') == 'customer') {
      CacheHelper.setString(
          key: 'location_details',
          value: data['data']['location_details'].toString());
      CacheHelper.setString(
          key: 'address_id', value: data['data']['address']['id'].toString());
      CacheHelper.setString(
          key: 'address_name', value: data['data']['address']['name']);
      CacheHelper.setString(
          key: 'city_id',
          value: data['data']['address']['city']['id'].toString());
      CacheHelper.setString(
          key: 'city_name', value: data['data']['address']['city']['name']);
      CacheHelper.setString(
          key: 'start_time', value: data['data']['start_time']);
      CacheHelper.setString(key: 'end_time', value: data['data']['end_time']);
    }
  }

  saveUserInfo(data) {
    CacheHelper.setString(
        key: 'id', value: data['data']['user']['id'].toString());
    CacheHelper.setString(key: 'name', value: data['data']['user']['name']);
    CacheHelper.setString(
        key: 'contact', value: data['data']['user']['contact']);
    if (data['data']['user']['longitude'] != null) {
      CacheHelper.setString(
          key: 'longitude',
          value: data['data']['user']['longitude'].toString());
    }
    if (data['data']['user']['latitude'] != null) {
      CacheHelper.setString(
          key: 'latitude', value: data['data']['user']['latitude'].toString());
    }
    if (CacheHelper.getData(key: 'role') == 'customer') {
      CacheHelper.setString(
          key: 'location_details',
          value: data['data']['user']['location_details'].toString());
      CacheHelper.setString(key: 'token', value: data['data']['access_token']);
      CacheHelper.setString(
          key: 'address_id',
          value: data['data']['user']['address']['id'].toString());
      CacheHelper.setString(
          key: 'address_name', value: data['data']['user']['address']['name']);
      CacheHelper.setString(
          key: 'city_id',
          value: data['data']['user']['address']['city']['id'].toString());
      CacheHelper.setString(
          key: 'city_name',
          value: data['data']['user']['address']['city']['name']);
      if (data['data']['user']['start_time'] != null) {
        CacheHelper.setString(
            key: 'start_time', value: data['data']['user']['start_time']);
      }
      if (data['data']['user']['end_time'] != null) {
        CacheHelper.setString(
            key: 'end_time', value: data['data']['user']['end_time']);
      }
    } else {
      CacheHelper.setString(key: 'token', value: data['data']['access_token']);
    }
  }
}
