import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  Future<void> init() async {
    final AndroidNotificationChannel channel = getAndroidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: false,
      requestAlertPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: selectNotification, onDidReceiveBackgroundNotificationResponse: selectNotification);
  }

  Future<void> displayNotification(String title, String body,
      {String payload = ""}) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
        'mobylote_notifications', 'Mobylote Notifications',
        channelDescription: 'This channel is used for Mobylote notifications.',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    const DarwinNotificationDetails ios = DarwinNotificationDetails(
      presentSound: true,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: android, iOS: ios);

    await flutterLocalNotificationsPlugin
        .show(Random().nextInt(64000), title, body, notificationDetails,
            payload: payload);  
  }

  AndroidNotificationChannel getAndroidNotificationChannel() =>
      const AndroidNotificationChannel(
        'mobylote_notifications',
        'Mobylote Notifications',
        description: 'This channel is used for Mobylote notifications.',
        importance: Importance.max,
      );

  static Future selectNotification(NotificationResponse notificationResponse) async {
    final String payload = notificationResponse.payload ?? '';
    await launchUrl(Uri.parse(payload));
  }

  NotificationService._internal();
}
