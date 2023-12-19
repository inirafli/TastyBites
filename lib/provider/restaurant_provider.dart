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

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      await _apiServices.getRestaurantDetail(id);

      _state = ResultState.done;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<void> searchRestaurants(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      _restaurants = await _apiServices.searchRestaurants(query);

      _state = ResultState.done;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<void> addReview(String id, String name, String review) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      await _apiServices.addReview(id, name, review);

      _state = ResultState.done;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
