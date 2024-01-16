class Restaurant {
  final String id, name, description, pictureId, city;
  final double rating;
  bool isFavorite;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.isFavorite = false,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating']?.toDouble() ?? 0.0,
      );
}

class RestaurantDetail {
  final String id, name, description, city, address, pictureId;
  final List<Category> categories;
  final Menus menus;
  final double rating;
  final List<CustomerReview> customerReviews;
  bool isFavorite;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
    this.isFavorite = false,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        city: json['city'],
        address: json['address'],
        pictureId: json['pictureId'],
        categories: (json['categories'] as List)
            .map((item) => Category.fromJson(item))
            .toList(),
        menus: Menus.fromJson(json['menus']),
        rating: json['rating']?.toDouble() ?? 0.0,
        customerReviews: (json['customerReviews'] as List)
            .map((item) => CustomerReview.fromJson(item))
            .toList(),
      );
}

class Category {
  final String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json['name'],
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

class CustomerReview {
  final String name, review, date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json['name'],
        review: json['review'],
        date: json['date'],
      );
}
