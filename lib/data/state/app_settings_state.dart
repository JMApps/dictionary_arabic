import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../core/strings/app_constraints.dart';

class AppSettingsState extends ChangeNotifier {
  final Box _mainSettingsBox = Hive.box(AppConstraints.keyMainAppSettingsBox);

  AppSettingsState() {
    _isWordSearch = _mainSettingsBox.get(AppConstraints.keyOpenWithWordSearch, defaultValue: false);
    _notificationTime = _mainSettingsBox.get(AppConstraints.keyNotificationTimeDuration, defaultValue: const Duration(hours: 17, minutes: 0));
    _dailyNotifications = _mainSettingsBox.get(AppConstraints.keyDailyNotification, defaultValue: true);
    _isAlwaysOnDisplay = _mainSettingsBox.get(AppConstraints.keyAlwaysOnDisplay, defaultValue: true);
    _isAlwaysOnDisplay ? WakelockPlus.enable() : WakelockPlus.disable();
  }

  late bool _isWordSearch;

  bool get getIsSearchWord => _isWordSearch;

  set changeIsSearchWord(bool isSearch) {
    _isWordSearch = isSearch;
    _mainSettingsBox.put(AppConstraints.keyOpenWithWordSearch, isSearch);
    notifyListeners();
  }

  late Duration _notificationTime;

  Duration get getNotificationTime => _notificationTime;

  set changeNotificationTime(Duration time) {
    _notificationTime = time;
    _mainSettingsBox.put(AppConstraints.keyNotificationTimeDuration, time);
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
