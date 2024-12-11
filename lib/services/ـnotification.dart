import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void listenToNotifications() {
  // Request iOS permissions
  FirebaseMessaging.instance.requestPermission();

  // Foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
          showInfoSnackBar(message.notification?.title, message.notification?.body);
      // flutterLocalNotificationsPlugin.show(
      //   notification.hashCode,
      //   notification.title,
      //   notification.body,
      //   NotificationDetails(
      //     iOS: DarwinNotificationDetails(),
      //     android: AndroidNotificationDetails(
      //       channel.id,
      //       channel.name,
      //       channelDescription: channel.description,
      //       icon: '@mipmap/ic_launcher',
      //     ),
      //   ),
      // );
    }
  });

  // Background messages
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Messages when the app is opened from a notification
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    showInfoSnackBar(message.notification?.title, message.notification?.body);
  });
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background messages
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null) {
    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        iOS: DarwinNotificationDetails(),
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );
  }
}

Future<void> _requestNotifPermissions() async {
  try {
    // Request notification permissions
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Check for missing required permissions
    if (Platform.isAndroid) {
      await _checkRequiredAndroidPermissions();
    } else if (Platform.isIOS) {
      await _requestIOSPermissions();
    }
  } on PlatformException catch (e) {
    showErrorSnackBar('خطأ', e.message);
    print('Failed to request permissions: ${e.code} ${e.message}');
  }
}

Future<void> _requestIOSPermissions() async {
  // Request permissions for iOS
  var iOSSettings = DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  // Initialize FlutterLocalNotificationsPlugin
  await flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
      iOS: iOSSettings,
      android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
  );

  // Request permissions explicitly
  await FirebaseMessaging.instance.requestPermission();
}


Future<void> _checkRequiredAndroidPermissions() async {
  // Check for missing required permissions
  if (!await _hasNecessaryPermissions()) {
    // Request missing permissions
    if (!await _hasNecessaryPermissions()) {
      // Request missing permissions
      await Permission.notification.request();
    }
  }
}

Future<bool> _hasNecessaryPermissions() async {
  // Check if notification permission is granted
  PermissionStatus notificationStatus = await Permission.notification.status;
  return notificationStatus.isGranted;
}
