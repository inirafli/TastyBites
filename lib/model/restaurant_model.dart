import 'dart:convert';

class Restaurant {
  final String id, name, description, pictureId, city;
  final double rating;
  final Menus menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating']?.toDouble() ?? 0.0,
        menus: Menus.fromJson(json['menus']),
      );
}

class Menus {
  final List<MenuItem> foods, drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: (json['foods'] as List)
            .map((item) => MenuItem.fromJson(item))
            .toList(),
        drinks: (json['drinks'] as List)
            .map((item) => MenuItem.fromJson(item))
            .toList(),
      );
}

class MenuItem {
  final String name;

  MenuItem({
    required this.name,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        name: json['name'],
      );
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
