import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/firebase_options.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/services/notification.dart';

Future<void> initApp() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    // FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  userInfo = await SharedPreferences.getInstance();
  debugPrint('token ${userInfo.getString('token')} ');
    FirebaseMessaging.instance.getToken().then(((value) {
    debugPrint(value.toString());
    userInfo.setString('fcm_token', value.toString());
  }));
    listenToNotification();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}