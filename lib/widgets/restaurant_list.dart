import 'package:flutter/material.dart';
import 'package:tasty_bites/widgets/restaurant_card.dart';
import '../model/restaurant_model.dart';

class RestaurantList extends StatelessWidget {
  final List<Restaurant> filteredRestaurants;

  const RestaurantList({super.key, required this.filteredRestaurants});

  @override
  Widget build(BuildContext context) {
    return filteredRestaurants.isNotEmpty
        ? ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredRestaurants.length,
            separatorBuilder: (context, index) => const SizedBox(height: 6.0),
            itemBuilder: (context, index) {
              final restaurant = filteredRestaurants[index];
              return RestaurantCard(restaurant: restaurant);
            },
          )
        : _buildNoRestaurantsFoundWidget(context);
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
