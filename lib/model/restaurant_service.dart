import 'package:flutter/services.dart';
import 'restaurant_model.dart';

class RestaurantService {
  Future<List<Restaurant>> getRestaurants() async {
    try {
      String data = await rootBundle.loadString('assets/local_restaurant.json');

      List<Restaurant> restaurants = parseRestaurants(data);

      return restaurants;
    } catch (e) {
      print('Error loading restaurants: $e');
      return [];
    }
  }
}
