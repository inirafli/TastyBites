import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:tasty_bites/provider/restaurant_provider.dart';
import 'package:tasty_bites/provider/scheduling_provider.dart';
import 'package:tasty_bites/ui/detail_screen.dart';
import 'package:tasty_bites/common/styles.dart';
import 'package:flutter/services.dart';
import 'package:tasty_bites/ui/favorite_screen.dart';
import 'package:tasty_bites/ui/setting_screen.dart';
import 'package:tasty_bites/utils/background_services.dart';
import 'package:tasty_bites/utils/notification_helper.dart';
import 'ui/home_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  final SchedulingProvider schedulingProvider = SchedulingProvider();

  service.initializeIsolate();

  await AndroidAlarmManager.initialize();
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  await schedulingProvider.loadNotificationStatus();

  runApp(
    ChangeNotifierProvider(
      create: (context) => schedulingProvider,
      child: ChangeNotifierProvider(
        create: (context) => RestaurantProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasty Bites',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: onPrimaryColor,
              secondary: secondaryColor,
              onSecondary: onSecondaryColor,
            ),
        textTheme: appTextTheme,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark),
        ),
        snackBarTheme: SnackBarThemeData(
          contentTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
        ),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        RestaurantDetailPage.routeName: (context) {
          final restaurantId =
              ModalRoute.of(context)?.settings.arguments as String;
          return RestaurantDetailPage(restaurantId: restaurantId);
        },
        FavoritesPage.routeName: (context) => const FavoritesPage(),
        SettingsPage.routeName: (context) => const SettingsPage(),
      },
    );
  }
}
