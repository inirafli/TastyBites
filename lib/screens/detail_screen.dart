import 'package:flutter/material.dart';
import 'package:tasty_bites/model/restaurant_model.dart';

import '../widgets/restaurant_info.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      body: SafeArea(
        child: RestaurantInfo(restaurant: restaurant),
      ),
    );
  }
}
