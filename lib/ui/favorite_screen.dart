import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/restaurant_provider.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/restaurant_card.dart';

class FavoritesPage extends StatefulWidget {
  static const routeName = '/favorite_page';

  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2.0),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text('Your Favorites Restaurants is Right Here!',
                      style: Theme.of(context).textTheme.headlineSmall),
                ),
                const SizedBox(height: 24.0),
                if (restaurantProvider.favoriteRestaurants.isEmpty)
                  _buildErrorWidget('No favorite restaurants added.')
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: restaurantProvider.favoriteRestaurants.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 6.0),
                    itemBuilder: (context, index) {
                      final restaurant =
                          restaurantProvider.favoriteRestaurants[index];
                      return RestaurantCard(restaurant: restaurant);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildErrorWidget(String errorMessage) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.no_food,
              size: 62.0,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 18.0),
            Center(
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
