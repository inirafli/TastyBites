import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasty_bites/common/config.dart';
import 'package:tasty_bites/model/restaurant_model.dart';
import 'package:tasty_bites/widgets/restaurant_reviews.dart';

import '../provider/restaurant_provider.dart';
import 'restaurant_category.dart';
import 'restaurant_menus.dart';

class RestaurantInfo extends StatelessWidget {
  final RestaurantDetail restaurantDetail;

  const RestaurantInfo({
    super.key,
    required this.restaurantDetail,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Hero(
                tag: 'restaurant_image_${restaurantDetail.id}',
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                  child: Image.network(
                    '${Config.mediumImageUrl}${restaurantDetail.pictureId}',
                    width: double.infinity,
                    height: 240.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Consumer<RestaurantProvider>(
                builder: (context, provider, child) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FloatingActionButton(
                      heroTag: 'Favorite Button',
                      onPressed: () {
                        provider.toggleFavoriteStatus(restaurantDetail.id);
                      },
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Icon(
                        restaurantDetail.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurantDetail.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 6.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      restaurantDetail.city,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4.0),
                Text(
                  restaurantDetail.description,
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Address',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4.0),
                Text(
                  restaurantDetail.address,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24.0),
                CategoryList(categories: restaurantDetail.categories),
                Text(
                  'Rating',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8.0),
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
                      '${restaurantDetail.rating}/5.0',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 34.0),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                MenusSection(
                  items: restaurantDetail.menus.foods,
                  icon: Icons.restaurant,
                  title: 'Foods',
                ),
                const SizedBox(height: 24.0),
                MenusSection(
                  items: restaurantDetail.menus.drinks,
                  icon: Icons.local_drink_rounded,
                  title: 'Drinks',
                ),
                const SizedBox(height: 24.0),
                CustomerReviewList(
                    customerReviews: restaurantDetail.customerReviews),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
