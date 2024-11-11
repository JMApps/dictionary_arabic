import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../core/strings/app_constraints.dart';

class AppSettingsState extends ChangeNotifier {
  final Box _mainSettingsBox = Hive.box(AppConstraints.keyMainAppSettingsBox);

  AppSettingsState() {
    _isWordSearch = _mainSettingsBox.get(AppConstraints.keyOpenWithWordSearch, defaultValue: false);
    _dailyNotifications = _mainSettingsBox.get(AppConstraints.keyDailyNotification, defaultValue: false);
    _notificationHours = _mainSettingsBox.get(AppConstraints.keyNotificationHours, defaultValue: 17);
    _notificationMinutes = _mainSettingsBox.get(AppConstraints.keyNotificationMinutes, defaultValue: 0);
    _isAlwaysOnDisplay = _mainSettingsBox.get(AppConstraints.keyAlwaysOnDisplay, defaultValue: true);
    _isAlwaysOnDisplay ? WakelockPlus.enable() : WakelockPlus.disable();
  }

  late int _notificationHours;

  int get getNotificationHours => _notificationHours;

  late int _notificationMinutes;

  int get getNotificationMinutes => _notificationMinutes;

  late bool _isWordSearch;

  bool get getIsSearchWord => _isWordSearch;

  set changeIsSearchWord(bool isSearch) {
    _isWordSearch = isSearch;
    _mainSettingsBox.put(AppConstraints.keyOpenWithWordSearch, isSearch);
    notifyListeners();
  }

  late Duration _notificationTime = Duration(hours: _notificationHours, minutes: _notificationMinutes);

  Duration get getNotificationTime => _notificationTime;

  set changeNotificationTime(Duration time) {
    _notificationTime = time;
    _notificationHours = time.inHours % 24;
    _notificationMinutes = time.inMinutes % 60;
    _mainSettingsBox.put(AppConstraints.keyNotificationHours, _notificationHours);
    _mainSettingsBox.put(AppConstraints.keyNotificationMinutes, _notificationMinutes);
    notifyListeners();
  }

  late bool _dailyNotifications;

  bool get getDailyNotification => _dailyNotifications;

  set changeNotificationState(bool isNotification) {
    _dailyNotifications = isNotification;
    _mainSettingsBox.put(AppConstraints.keyDailyNotification, isNotification);
    notifyListeners();
  }

  late bool _isAlwaysOnDisplay;

  bool get getIsAlwaysOnDisplay => _isAlwaysOnDisplay;

  set changeOnDisplayState(bool isOnDisplay) {
    _isAlwaysOnDisplay = isOnDisplay;
    _mainSettingsBox.put(AppConstraints.keyAlwaysOnDisplay, isOnDisplay);
    isOnDisplay ? WakelockPlus.enable() : WakelockPlus.disable();
    notifyListeners();
  }
}
