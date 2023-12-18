import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tasty_bites/model/restaurant_model.dart';

class ApiServices {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<List<Restaurant>> getRestaurants() async {
    final response = await http.get(Uri.parse('$baseUrl/list'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> restaurantsJson = data['restaurants'];
      return restaurantsJson.map((json) => Restaurant.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<Restaurant> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, dynamic> restaurantJson = data['restaurant'];
      return Restaurant.fromJson(restaurantJson);
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<List<Restaurant>> searchRestaurants(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search?q=$query'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> restaurantsJson = data['restaurants'];
      return restaurantsJson.map((json) => Restaurant.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search restaurants');
    }
  }

  Future<List<CustomerReview>> addReview(
      String id, String name, String review) async {
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> body = {
      'id': id,
      'name': name,
      'review': review
    };
    final response = await http.post(Uri.parse('$baseUrl/review'),
        headers: headers, body: json.encode(body));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> reviewsJson = data['customerReviews'];
      return reviewsJson.map((json) => CustomerReview.fromJson(json)).toList();
    } else {
      throw Exception('Failed to add review');
    }
  }
}
