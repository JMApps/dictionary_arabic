import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNoticeService {
  static final LocalNoticeService _localNoticeService = LocalNoticeService._internal();

  factory LocalNoticeService() {
    return _localNoticeService;
  }

  LocalNoticeService._internal();

  static const dailyNotificationID = 004;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _androidDailyNotificationDetails =
  AndroidNotificationDetails(
    'Daily notification channel ID',
    'Notifications',
    channelDescription: 'Daily notifications',
    importance: Importance.max,
    priority: Priority.max,
  );

  static const DarwinNotificationDetails _iOSDailyNotificationDetails =
  DarwinNotificationDetails();

  Future<void> setupNotification() async {
    if (Platform.isAndroid) {
      _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    }

    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@drawable/ic_notification');

    const DarwinInitializationSettings iOSInitializationSettings = DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  Future<void> dailyZonedScheduleNotification(DateTime date, String title, String body, int id) async {
    var tzDateNotification = tz.TZDateTime.from(date, tz.local);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzDateNotification,
      const NotificationDetails(
        android: _androidDailyNotificationDetails,
        iOS: _iOSDailyNotificationDetails,
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotificationWithId(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}
