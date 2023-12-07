import 'package:flutter/material.dart';

import '../model/restaurant_model.dart';
import '../model/restaurant_service.dart';
import '../widgets/restaurant_card.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Restaurant> _allRestaurants;
  late List<Restaurant> _filteredRestaurants;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _allRestaurants = [];
    _filteredRestaurants = [];
    _loadRestaurants();
  }

  Future<void> _loadRestaurants() async {
    final restaurants = await RestaurantService().getRestaurants();
    setState(() {
      _allRestaurants = restaurants;
      _filteredRestaurants = _allRestaurants;
    });
  }

  void _filterRestaurants(String query) {
    setState(() {
      _filteredRestaurants = _allRestaurants
          .where((restaurant) =>
              restaurant.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        title: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _filterRestaurants,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.secondary),
            decoration: InputDecoration(
              hintText: 'Search restaurants...',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.secondary,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  _searchController.clear();
                  _filterRestaurants('');
                },
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
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
                _filteredRestaurants.isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _filteredRestaurants.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 6.0),
                        itemBuilder: (context, index) {
                          final restaurant = _filteredRestaurants[index];
                          return RestaurantCard(restaurant: restaurant);
                        },
                      )
                    : SizedBox(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
