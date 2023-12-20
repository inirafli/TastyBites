import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/restaurant_provider.dart';
import '../widgets/restaurant_info.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final String restaurantId;

  const RestaurantDetailPage({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    Provider.of<RestaurantProvider>(context, listen: false)
        .fetchRestaurantDetail(restaurantId);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      body: SafeArea(
        child: Consumer<RestaurantProvider>(
          builder: (context, provider, child) {
            if (provider.state == ResultState.loading) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.secondary,
                  ),
                ),
              );
            } else if (provider.state == ResultState.error) {
              return _buildErrorWidget(context, provider.message);
            } else if (provider.restaurantDetail != null) {
              return RestaurantInfo(restaurantDetail: provider.restaurantDetail!);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 62.0,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 12.0),
          Center(
            child: Text(
              'Error loading restaurant details. $errorMessage',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
