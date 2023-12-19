import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasty_bites/widgets/restaurant_card.dart';
import '../model/restaurant_model.dart';
import '../provider/restaurant_provider.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, provider, child) {
        if (provider.restaurants.isNotEmpty) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.restaurants.length,
            separatorBuilder: (context, index) => const SizedBox(height: 6.0),
            itemBuilder: (context, index) {
              final restaurant = provider.restaurants[index];
              return RestaurantCard(restaurant: restaurant);
            },
          );
        } else {
          return _buildNoRestaurantsFoundWidget(context);
        }
      },
    );
  }

  Widget _buildNoRestaurantsFoundWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 62.0,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 12.0),
            Text(
              'No restaurants found.',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}