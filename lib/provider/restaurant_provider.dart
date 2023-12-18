import 'package:flutter/material.dart';
import 'package:tasty_bites/model/restaurant_model.dart';
import 'package:tasty_bites/data/api_services.dart';

enum ResultState { loading, done, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  List<Restaurant> _restaurants = [];
  ResultState _state = ResultState.done;
  String _message = '';

  List<Restaurant> get restaurants => _restaurants;

  ResultState get state => _state;

  String get message => _message;

  Future<void> fetchRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      _restaurants = await _apiServices.getRestaurants();

      _state = ResultState.done;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

// TODO: More Methods!
}
