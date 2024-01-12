import 'database_helper.dart';

class FavoriteHelper {
  static Future<List<String>> getFavorites() async {
    return DatabaseHelper.instance.getFavoriteRestaurantIds();
  }

  static Future<void> addFavorite(String restaurantId) async {
    await DatabaseHelper.instance.addFavoriteRestaurant(restaurantId);
  }

  static Future<void> removeFavorite(String restaurantId) async {
    await DatabaseHelper.instance.removeFavoriteRestaurant(restaurantId);
  }
}
