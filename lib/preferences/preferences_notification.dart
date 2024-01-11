import 'package:shared_preferences/shared_preferences.dart';

class PreferencesNotification {
  static const String _keyNotificationEnabled = 'notification_enabled';

  static Future<bool> isNotificationEnabled() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyNotificationEnabled) ?? false;
  }

  static Future<void> setNotificationEnabled(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyNotificationEnabled, value);
  }
}
