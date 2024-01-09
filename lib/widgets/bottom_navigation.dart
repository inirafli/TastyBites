import 'package:flutter/material.dart';

import '../screens/favorite_screen.dart';
import '../screens/home_screen.dart';
import '../screens/setting_screen.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, HomePage.routeName);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, FavoritesPage.routeName);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, SettingsPage.routeName);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        onTap(index);
        _navigateToPage(context, index);
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      selectedItemColor: Theme.of(context).colorScheme.secondary,
      unselectedItemColor:
          Theme.of(context).colorScheme.secondary.withOpacity(0.5),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
