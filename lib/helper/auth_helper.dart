  import 'package:flutter/material.dart';
import 'package:location/location.dart';

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
    var longitude = locationData.longitude.toString();
    debugPrint('longitude: ${longitude}');
    var latitude = locationData.latitude.toString();
    debugPrint('latitude: ${latitude}');
    return true;
  }
