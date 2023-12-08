import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) filterRestaurants;

  const AppSearchBar({
    super.key,
    required this.searchController,
    required this.filterRestaurants,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: TextField(
        controller: searchController,
        onChanged: filterRestaurants,
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
              searchController.clear();
              filterRestaurants('');
            },
          ),
        ),
      ),
    );
  }
}
