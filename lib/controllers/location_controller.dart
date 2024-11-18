import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:shop_app/constans.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/main.dart';
import 'package:shop_app/views/auth_pages/login_page/login_page.dart';

class LocationController extends GetxController {
  final Location _location = Location();
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    _checkLocationService();
  }

  Future updateLocation(locationDetails) async {
    try {
      final response = await http.put(
          Uri.parse("${Constans.kBaseUrl}salesmen/update-location"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${userInfo.getString('token')}',
          },
          body: locationDetails);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint('update location Successfully');
      } else if (response.statusCode == 401) {
        Get.offAll(() => LoginPage());
      }
    } catch (e) {
      debugPrint('e: ${e}');
    }
  }

  Future<void> _checkLocationService() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        _showPermissionDeniedDialog();
        return;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _showPermissionDeniedDialog();
        return;
      }
    }

    // بدء التحقق من الموقع كل 15 ثانية
    _startLocationUpdates();
  }

  void _startLocationUpdates() {
    _timer = Timer.periodic(Duration(minutes: 5), (timer) async {
      var locationDetails = await _checkLocationStatusAndGetLocation();
      await updateLocation(locationDetails);
    });
  }

  Future _checkLocationStatusAndGetLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    debugPrint('serviceEnabled: ${serviceEnabled}');
    if (!serviceEnabled) {
      _showServiceDisabledDialog();
      return;
    }
    debugPrint('from check');
    LocationData locationData = await _location.getLocation();
    var longitude = locationData.longitude.toString();
    var latitude = locationData.latitude.toString();
    return {'latitude': latitude, 'longitude': longitude};
  }

  void _showPermissionDeniedDialog() {
    Get.until(
        (route) => !Get.isDialogOpen!); // إغلاق أي حوارات أو تراكبات مفتوحة
    Get.defaultDialog(
      title: "تم رفض الإذن",
      titleStyle: TextStyle(
        fontFamily: Constans.kFontFamily,
      ),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "هذا التطبيق يحتاج إذن الموقع ليعمل بشكل صحيح. الرجاء تفعيل خدمات الموقع.",
              style: TextStyle(fontFamily: Constans.kFontFamily),
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(16),
      titlePadding: EdgeInsets.all(8),
      textConfirm: "إعادة المحاولة",
      buttonColor: Constans.kMainColor,
      textCancel: "إغلاق التطبيق",
      onConfirm: () {
        Get.back(); // إغلاق الحوار الحالي
        _checkLocationService(); // إعادة التحقق من الخدمة
      },
      onCancel: _closeApp,
      barrierDismissible: false, // منع إخفاء الحوار بالنقر على الشاشة
      confirmTextColor: Colors.white, // لون النص في زر التأكيد
      cancelTextColor: Colors.black, // لون النص في زر الإلغاء
    );
  }

  void _showServiceDisabledDialog() {
    Get.until(
        (route) => !Get.isDialogOpen!); // إغلاق أي حوارات أو تراكبات مفتوحة
    Get.defaultDialog(
      title: "الخدمة متوقفة",
      titleStyle: TextStyle(
        fontFamily: Constans.kFontFamily,
      ),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "هذا التطبيق يحتاج خدمة الموقع حتى يعمل. الرجاء اضغط على إعادة المحاولة وقم بتفعيل الخدمة.",
              style: TextStyle(fontFamily: Constans.kFontFamily),
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(16),
      titlePadding: EdgeInsets.all(8),
      buttonColor: Constans.kMainColor,
      textConfirm: "إعادة المحاولة",
      textCancel: "إغلاق التطبيق",
      onConfirm: () {
        Get.back(); // إغلاق الحوار الحالي
        _checkLocationService(); // إعادة التحقق من الخدمة
      },
      onCancel: _closeApp,
      barrierDismissible: false, // منع إخفاء الحوار بالنقر على الشاشة
      confirmTextColor: Colors.white, // لون النص في زر التأكيد
      cancelTextColor: Colors.black, // لون النص في زر الإلغاء
    );
  }

  void _closeApp() {
    exit(0);
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
