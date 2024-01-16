import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tasty_bites/model/restaurant_model.dart';

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showRandomRestaurantNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      List<Restaurant> restaurants) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "tasty bites channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    var titleNotification = "Top Picks Restaurant for You!";

    final Random random = Random();
    final randomIndex = random.nextInt(restaurants.length);
    final randomRestaurant = restaurants[randomIndex];

    var titleNews = randomRestaurant.name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleNews, platformChannelSpecifics);
  }
}
