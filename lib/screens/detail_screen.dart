import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/restaurant_provider.dart';
import '../widgets/restaurant_info.dart';
import '../widgets/restaurant_review_dialog.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final String restaurantId;

  const RestaurantDetailPage({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<RestaurantProvider>(context, listen: false)
        .fetchRestaurantDetail(widget.restaurantId);

    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .onSecondary,
      body: SafeArea(
        key: _scaffoldKey,
        child: Consumer<RestaurantProvider>(
          builder: (context, provider, child) {
            if (provider.state == ResultState.loading) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme
                        .of(context)
                        .colorScheme
                        .secondary,
                  ),
                ),
              );
            } else if (provider.state == ResultState.error) {
              return _buildErrorWidget(context, provider.message);
            } else if (provider.restaurantDetail != null) {
              return RestaurantInfo(
                  restaurantDetail: provider.restaurantDetail!);
            } else {
              return Container();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .secondary,
        onPressed: () => _showAddReviewDialog(context),
        child: Icon(Icons.comment,
            color: Theme
                .of(context)
                .colorScheme
                .onSecondary),
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
            color: Theme
                .of(context)
                .colorScheme
                .secondary,
          ),
          const SizedBox(height: 12.0),
          Center(
            child: Text(
              'Error loading restaurant details. $errorMessage',
              textAlign: TextAlign.center,
              style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(
                color: Theme
                    .of(context)
                    .colorScheme
                    .secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ReviewDialog(
        nameController: _nameController,
        reviewController: _reviewController,
        onAddReview: () {
          _addReview(context);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _addReview(BuildContext context) async {
    final provider = Provider.of<RestaurantProvider>(context, listen: false);

    final name = _nameController.text.trim();
    final review = _reviewController.text.trim();

    if (name.isNotEmpty && review.isNotEmpty) {
      try {
        await provider.addReview(widget.restaurantId, name, review);
        await provider.fetchRestaurantDetail(widget.restaurantId);
        _showSnackbar('Review added successfully');
      } catch (e) {
        _showSnackbar('Failed to add review');
      }
    } else {
      _showSnackbar('Name and Review can not be Empty');
    }

    _nameController.clear();
    _reviewController.clear();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
