import 'package:flutter/material.dart';
import 'package:tasty_bites/model/restaurant_model.dart';

class RestaurantInfo extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantInfo({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
            child: Image.network(
              restaurant.pictureId,
              width: double.infinity,
              height: 240.0,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 6.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 18.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      restaurant.city,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4.0),
                Text(
                  restaurant.description,
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Restaurant Rating',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 42.0,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      '${restaurant.rating}/5.0',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 34.0),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Foods',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6.0),
                SizedBox(
                  height: 118.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurant.menus.foods.length,
                    itemBuilder: (context, index) {
                      final food = restaurant.menus.foods[index];
                      return _buildMenuCard(
                          context, food.name, Icons.restaurant, 'Rp. 15,000');
                    },
                  ),
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Drinks',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6.0),
                SizedBox(
                  height: 118.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurant.menus.drinks.length,
                    itemBuilder: (context, index) {
                      final drink = restaurant.menus.drinks[index];
                      return _buildMenuCard(
                          context, drink.name, Icons.local_drink_rounded, 'Rp. 15,000');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
      BuildContext context, String name, IconData icon, String price) {
    return SizedBox(
      width: 180.0,
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        margin: const EdgeInsets.only(right: 12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32.0,
              ),
              const SizedBox(height: 12.0),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 2.0),
              Text(price, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
