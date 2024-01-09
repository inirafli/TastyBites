import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasty_bites/provider/restaurant_provider.dart';
import 'package:tasty_bites/screens/detail_screen.dart';
import 'package:tasty_bites/common/styles.dart';
import 'package:flutter/services.dart';
import 'package:tasty_bites/screens/favorite_screen.dart';
import 'package:tasty_bites/screens/setting_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RestaurantProvider(),
      child: const MyApp(),
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
          final restaurantId = ModalRoute.of(context)?.settings.arguments as String;
          return RestaurantDetailPage(restaurantId: restaurantId);
        },
        FavoritesPage.routeName: (context) => const FavoritesPage(),
        SettingsPage.routeName: (context) => const SettingsPage(),
      },
    );
  }
}

class FavoriteScreen {
  const FavoriteScreen();
}
