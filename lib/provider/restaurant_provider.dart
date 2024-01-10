import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tasty_bites/model/restaurant_model.dart';
import 'package:tasty_bites/data/api_services.dart';

import '../utils/favorite_helper.dart';

enum ResultState { loading, done, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  List<Restaurant> _restaurants = [];
  List<Restaurant> _favoriteRestaurants = [];
  ResultState _state = ResultState.done;
  String _message = '';

  List<Restaurant> get restaurants => _restaurants;

  List<Restaurant> get favoriteRestaurants => _favoriteRestaurants;

  RestaurantDetail? _restaurantDetail;

  RestaurantDetail? get restaurantDetail => _restaurantDetail;

  ResultState get state => _state;

  String get message => _message;

  Future<void> fetchRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      _restaurants = await _apiServices.getRestaurants();

      final favorites = await FavoriteUtils.getFavorites();
      for (var restaurant in _restaurants) {
        restaurant.isFavorite = favorites.contains(restaurant.id);
      }

      _favoriteRestaurants =
          _restaurants.where((restaurant) => restaurant.isFavorite).toList();

      _state = ResultState.done;
      notifyListeners();
    } on SocketException {
      _state = ResultState.error;
      _message = 'No Internet Connection';
      notifyListeners();
    } on TimeoutException catch (_) {
      _state = ResultState.error;
      _message = 'Request Timeout';
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Failed to load list';
      notifyListeners();
    }
  }

  Future<void> fetchFavoriteRestaurants() async {
    final favorites = await FavoriteUtils.getFavorites();
    _favoriteRestaurants = _restaurants
        .where((restaurant) => favorites.contains(restaurant.id))
        .toList();
    notifyListeners();
  }

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      _restaurantDetail = await _apiServices.getRestaurantDetail(id);

      final favorites = await FavoriteUtils.getFavorites();
      _restaurantDetail?.isFavorite = favorites.contains(_restaurantDetail?.id);

      _state = ResultState.done;
      notifyListeners();
    } on SocketException {
      _state = ResultState.error;
      _message = 'No Internet Connection';
      notifyListeners();
    } on TimeoutException catch (_) {
      _state = ResultState.error;
      _message = 'Request Timeout';
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Failed to load detail';
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
    } on SocketException {
      _state = ResultState.error;
      _message = 'No Internet Connection';
      notifyListeners();
    } on TimeoutException catch (_) {
      _state = ResultState.error;
      _message = 'Request Timeout';
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Failed to add review';
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
    } on SocketException {
      _state = ResultState.error;
      _message = 'No Internet Connection';
      notifyListeners();
    } on TimeoutException catch (_) {
      _state = ResultState.error;
      _message = 'Request Timeout';
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Failed to add review';
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(String restaurantId) async {
    final restaurantIndex =
    _restaurants.indexWhere((restaurant) => restaurant.id == restaurantId);

    if (restaurantIndex != -1) {
      final isFavorite = !_restaurants[restaurantIndex].isFavorite;
      _restaurants[restaurantIndex].isFavorite = isFavorite;

      if (isFavorite) {
        await FavoriteUtils.addFavorite(restaurantId);
      } else {
        await FavoriteUtils.removeFavorite(restaurantId);
      }

      await fetchFavoriteRestaurants();

      notifyListeners();

      if (_restaurantDetail?.id == restaurantId) {
        _restaurantDetail!.isFavorite = isFavorite;
        notifyListeners();
      }
    }
  }
}
