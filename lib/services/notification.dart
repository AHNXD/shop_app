import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shop_app/helper/cache_helper.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'Highly Important Notifications',
    description: 'This Cahnnel is used for important nots',
    importance: Importance.max,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();
  void handleMessage(RemoteMessage? message) {
    // what to do
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    const settings = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(settings);
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@mipmap/ic_launcher',
            autoCancel: true,
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> saveToken() async {
    final bool? hasToken = await CacheHelper.getData(key: "hasFCMToken");
    log("hasFCMToken: ${hasToken.toString()}");
    final fCMToken = await _firebaseMessaging.getToken();
    log("fCMToken: ${fCMToken.toString()}");
    final String? token = await CacheHelper.getData(key: "token");
    log("token: ${token.toString()}");
    if (token != null) {
      if (hasToken == null || !hasToken) {
        //here we have to send the fcm token
        await CacheHelper.setBool(key: "hasFCMToken", value: true);
        await CacheHelper.setString(key: "FCMtoken", value: fCMToken ?? "");
      }
    }
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    // String? userType = CacheHelper.getData(key: "userType");
    // if (userType != null) {
    //   await _firebaseMessaging.subscribeToTopic(userType);
    // }
    await saveToken();
    await initPushNotifications();
    await initLocalNotifications();
  }
}
