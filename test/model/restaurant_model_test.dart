import 'package:flutter_test/flutter_test.dart';
import 'package:tasty_bites/model/restaurant_model.dart';

import '../test_utils/mock_data.dart';

void main() {
  group('Restaurant Model Test', () {
    test('Restaurant Model should be created from JSON', () {
      final restaurant = Restaurant.fromJson(MockData.restaurantJson);

      expect(restaurant.id, '1');
      expect(restaurant.name, 'Test Restaurant');
      expect(restaurant.description, 'This is a test restaurant');
      expect(restaurant.pictureId, 'www.');
      expect(restaurant.city, 'Depok City');
      expect(restaurant.rating, 4.8
      );
      expect(
          restaurant.isFavorite, false);
    });

    test('Restaurant Detail Model should be created from JSON', () {
      final restaurantDetail = RestaurantDetail.fromJson(MockData.restaurantDetailJson);

      expect(restaurantDetail.id, '1');
      expect(restaurantDetail.name, 'Test Restaurant');
      expect(restaurantDetail.description, 'This is a test restaurant');
      expect(restaurantDetail.city, 'Depok City');
      expect(restaurantDetail.address, '123 Test Street');
      expect(restaurantDetail.pictureId, 'www.');

      expect(restaurantDetail.categories.length, 2);
      expect(restaurantDetail.categories[0].name, 'Category 1');
      expect(restaurantDetail.categories[1].name, 'Category 2');

      expect(restaurantDetail.menus.foods.length, 2);
      expect(restaurantDetail.menus.foods[0].name, 'Food 1');
      expect(restaurantDetail.menus.foods[1].name, 'Food 2');
      expect(restaurantDetail.menus.drinks.length, 2);
      expect(restaurantDetail.menus.drinks[0].name, 'Drink 1');
      expect(restaurantDetail.menus.drinks[1].name, 'Drink 2');

      expect(restaurantDetail.rating, 4.8);

      expect(restaurantDetail.customerReviews.length, 2);
      expect(restaurantDetail.customerReviews[0].name, 'John Doe');
      expect(restaurantDetail.customerReviews[0].review, 'Great food!');
      expect(restaurantDetail.customerReviews[0].date, '2023-01-01');
      expect(restaurantDetail.customerReviews[1].name, 'Jane Smith');
      expect(restaurantDetail.customerReviews[1].review, 'Excellent service!');
      expect(restaurantDetail.customerReviews[1].date, '2023-01-02');

      expect(restaurantDetail.isFavorite, false);
    });
  });
}
