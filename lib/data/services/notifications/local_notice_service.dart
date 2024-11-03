import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNoticeService {
  static const dailyNotificationID = 004;
  static const String _logoName = 'ic_app_notification';

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _androidDailyNotificationDetails =
  AndroidNotificationDetails(
    'Daily notification channel ID',
    'Notifications',
    channelDescription: 'Daily notifications',
    icon: _logoName,
    importance: Importance.max,
    priority: Priority.max,
  );

  static const DarwinNotificationDetails _iOSDailyNotificationDetails =
  DarwinNotificationDetails();

  Future<void> setupNotification() async {
    if (Platform.isAndroid) {
      _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    }

    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings(_logoName);

    const DarwinInitializationSettings iOSInitializationSettings = DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  Future<void> dailyZonedScheduleNotification(DateTime date, String title, String body) async {
    var tzDateNotification = tz.TZDateTime.from(date, tz.local);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      dailyNotificationID,
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
