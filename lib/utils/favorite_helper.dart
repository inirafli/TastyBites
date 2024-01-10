import 'package:shared_preferences/shared_preferences.dart';

class FavoriteUtils {
  static const _favoriteKey = 'favorite_key';

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoriteKey) ?? [];
  }

  static Future<void> addFavorite(String restaurantId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    if (!favorites.contains(restaurantId)) {
      favorites.add(restaurantId);
      prefs.setStringList(_favoriteKey, favorites);
    }
  }

  static Future<void> removeFavorite(String restaurantId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    if (favorites.contains(restaurantId)) {
      favorites.remove(restaurantId);
      prefs.setStringList(_favoriteKey, favorites);
    }
  }
}
