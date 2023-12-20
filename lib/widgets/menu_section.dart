import 'package:flutter/material.dart';

import '../model/restaurant_model.dart';

class MenusSection extends StatelessWidget {
  final List<MenuItem> items;
  final IconData icon;
  final String title;

  const MenusSection({
    super.key,
    required this.items,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 6.0),
        SizedBox(
          height: 120.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildMenuCard(context, item.name, icon, 'Rp. 15,000');
            },
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  Widget _buildMenuCard(
      BuildContext context, String name, IconData icon, String price) {
    return SizedBox(
      width: 180.0,
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        margin: const EdgeInsets.only(right: 12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32.0,
              ),
              const SizedBox(height: 12.0),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 14.0
                ),
              ),
              const SizedBox(height: 2.0),
              Text(price, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
