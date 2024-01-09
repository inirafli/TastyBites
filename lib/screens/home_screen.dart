import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasty_bites/widgets/restaurant_list.dart';
import 'package:tasty_bites/widgets/search_bar.dart';

import '../provider/restaurant_provider.dart';
import '../widgets/bottom_navigation.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantProvider>(context, listen: false)
          .fetchRestaurants();
    });
  }

  void _filterRestaurants(String query) {
    Provider.of<RestaurantProvider>(context, listen: false)
        .searchRestaurants(query);
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        title: AppSearchBar(
          searchController: _searchController,
          filterRestaurants: _filterRestaurants,
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
                        style: Theme.of(context).textTheme.headlineSmall),
                  ],
                ),
                const SizedBox(height: 24.0),
                Consumer<RestaurantProvider>(
                  builder: (context, provider, child) {
                    if (provider.state == ResultState.loading) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      );
                    } else if (provider.state == ResultState.error) {
                      return _buildErrorWidget(provider.message);
                    } else {
                      return const RestaurantList();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildErrorWidget(String errorMessage) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
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
            Center(
              child: Text(
                'Error loading restaurants. $errorMessage',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
