import 'package:flutter/material.dart';
import 'package:tasty_bites/model/restaurant_model.dart';

import 'menu_section.dart';

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
          Hero(
            tag: restaurant.name,
            child: ClipRRect(
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
                MenusSection(
                  items: restaurant.menus.foods,
                  icon: Icons.restaurant,
                  title: 'Foods',
                ),
                MenusSection(
                  items: restaurant.menus.drinks,
                  icon: Icons.local_drink_rounded,
                  title: 'Drinks',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
