import 'package:flutter/material.dart';
import 'package:tasty_bites/model/restaurant_model.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;

  const CategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: categories.map((category) {
            return _buildCategoryChip(context, category.name);
          }).toList(),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  Widget _buildCategoryChip(BuildContext context, String categoryName) {
    return Chip(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      label: Text(
        categoryName,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
              fontSize: 12.0,
            ),
      ),
    );
  }
}
