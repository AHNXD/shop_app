import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
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
    if (message == null) return;
    log("Notification clicked with data: ${message.data}");
    // Handle navigation or action based on message data
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

  Future<void> initPushNotifications() async {
    // Request permissions for iOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      log("User declined or has not granted permissions for notifications");
      return;
    }

    // Display notification in foreground
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      final android = message.notification?.android;
      if (notification != null && android != null) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_launcher',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
          payload: jsonEncode(message.data),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(message);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Save the FCM token
    await saveToken();
  }
  // Future initPushNotifications() async {
  //   await FirebaseMessaging.instance
  //       .setForegroundNotificationPresentationOptions(
  //           alert: true, badge: true, sound: true);

  //   FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  //   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  //   FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  //   FirebaseMessaging.onMessage.listen((message) {
  //     final notification = message.notification;
  //     if (notification == null) return;
  //     _localNotifications.show(
  //       notification.hashCode,
  //       notification.title,
  //       notification.body,
  //       NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           _androidChannel.id,
  //           _androidChannel.name,
  //           channelDescription: _androidChannel.description,
  //           icon: '@mipmap/ic_launcher',
  //           autoCancel: true,
  //         ),
  //       ),
  //       payload: jsonEncode(message.toMap()),
  //     );
  //   });
  // }

  Future<void> saveToken() async {
    final bool? hasToken = await CacheHelper.getData(key: "hasFCMToken");
    log("hasFCMToken: ${hasToken.toString()}");
    final fCMToken = Platform.isAndroid
        ? await _firebaseMessaging.getToken()
        : await _firebaseMessaging.getAPNSToken();
    log("fCMToken: ${fCMToken.toString()}");
    final String? token = await CacheHelper.getData(key: "token");
    log("token: ${token.toString()}");

    if (hasToken == null || !hasToken) {
      //here we have to send the fcm token
      await CacheHelper.setBool(key: "hasFCMToken", value: true);
      await CacheHelper.setString(key: "fcm_token", value: fCMToken!);
    }
  }

  Future<void> requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      log("Notification permission denied");
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log("Notification permission granted");
    } else {
      log("Notification permission granted provisionally");
    }
  }

  Future<void> initNotifications() async {
    //await _firebaseMessaging.requestPermission();
    // String? userType = CacheHelper.getData(key: "userType");
    // if (userType != null) {
    //   await _firebaseMessaging.subscribeToTopic(userType);
    // }
    //await saveToken();
    await requestNotificationPermission();
    await initPushNotifications();
    await initLocalNotifications();
  }
}
