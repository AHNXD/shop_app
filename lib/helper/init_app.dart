import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/firebase_options.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/services/notification.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        //name: 'BrokerApp',
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    log("Firebase initialization error: $e");
  }
  await CacheHelper.init();
  await FirebaseApi().initNotifications();
}
