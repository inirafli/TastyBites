import 'dart:async';
import 'dart:isolate';
import 'dart:developer';
import 'dart:ui';
import 'package:tasty_bites/model/restaurant_model.dart';
import 'package:tasty_bites/utils/notification_helper.dart';

import '../data/api_services.dart';
import '../main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    log('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    final ApiServices apiService = ApiServices();
    List<Restaurant> restaurants;

    try {
      restaurants = await apiService.getRestaurants();

      if (restaurants.isNotEmpty) {
        await notificationHelper.showRandomRestaurantNotification(
            flutterLocalNotificationsPlugin, restaurants);
      }
    } catch (e) {
      log('Error fetching data: $e');
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
