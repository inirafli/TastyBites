import 'package:flutter/material.dart';
import 'package:tasty_bites/widgets/restaurant_list.dart';
import 'package:tasty_bites/widgets/search_bar.dart';

import '../model/restaurant_model.dart';
import '../model/restaurant_service.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Restaurant> _allRestaurants;
  late List<Restaurant> _filteredRestaurants;
  late bool _hasError;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _allRestaurants = [];
    _filteredRestaurants = [];
    _loadRestaurants();
    _hasError = false;
  }

  Future<void> _loadRestaurants() async {
    try {
      final restaurants = await RestaurantService().getRestaurants();
      setState(() {
        _allRestaurants = restaurants;
        _filteredRestaurants = _allRestaurants;
        _hasError = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
      });
    }
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
          title: AppSearchBar(
            searchController: _searchController,
            filterRestaurants: _filterRestaurants,
          )),
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
                _hasError
                    ? _buildErrorWidget()
                    : RestaurantList(filteredRestaurants: _filteredRestaurants),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 62.0,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 12.0),
            Text(
              'Error loading restaurants.',
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
