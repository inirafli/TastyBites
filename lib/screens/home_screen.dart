import 'package:flutter/material.dart';

import '../model/restaurant_model.dart';
import '../model/restaurant_service.dart';
import '../widgets/restaurant_card.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TastyBites,',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 2.0),
                    Text('Explore a Culinary Journey',
                        style: Theme.of(context).textTheme.headlineMedium),
                  ],
                ),
                const SizedBox(height: 24.0),
                FutureBuilder<List<Restaurant>>(
                  future: RestaurantService().getRestaurants(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 6.0),
                            itemBuilder: (context, index) {
                              final restaurant = snapshot.data![index];
                              return RestaurantCard(restaurant: restaurant);
                            },
                          )
                        : const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}