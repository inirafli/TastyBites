import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:tasty_bites/utils/date_time_helper.dart';

import '../preferences/preferences_notification.dart';
import '../utils/background_services.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isNotificationEnabled = false;

  bool get isNotificationEnabled => _isNotificationEnabled;

  Future<void> loadNotificationStatus() async {
    _isNotificationEnabled = await PreferencesNotification.isNotificationEnabled();
    notifyListeners();

    if (_isNotificationEnabled) {
      _scheduleNotification();
    }
  }

  void toggleNotification(bool value) {
    _isNotificationEnabled = value;
    notifyListeners();
    PreferencesNotification.setNotificationEnabled(value);

    if (_isNotificationEnabled) {
      _scheduleNotification();
    } else {
      _cancelNotification();
    }
  }

  Future<void> _scheduleNotification() async {
    await AndroidAlarmManager.periodic(
      const Duration(hours: 24),
      1,
      BackgroundService.callback,
      startAt: DateTimeHelper.format(),
      exact: true,
      wakeup: true,
    );
  }

  Future<void> _cancelNotification() async {
    await AndroidAlarmManager.cancel(1);
  }
}
