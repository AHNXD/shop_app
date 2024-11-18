import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void listenToNotification() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');
    

    if (message.notification != null) {
      debugPrint('Message also contained a notification: ${message.notification}');
      debugPrint('${message.notification!.title} ${message.notification!.body}');
    }
  });
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
}
