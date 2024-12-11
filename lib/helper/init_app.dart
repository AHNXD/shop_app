import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/firebase_options.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/services/notification.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Firebase initialization error: $e");
  }

  await CacheHelper.init();
  await FirebaseApi().initNotifications();
}
