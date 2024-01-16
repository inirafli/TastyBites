class MockData {
  static final Map<String, dynamic> restaurantJson = {
    'id': '1',
    'name': 'Test Restaurant',
    'description': 'This is a test restaurant',
    'pictureId': 'www.',
    'city': 'Depok City',
    'rating': 4.8,
  };

  static final Map<String, dynamic> restaurantDetailJson = {
    'id': '1',
    'name': 'Test Restaurant',
    'description': 'This is a test restaurant',
    'city': 'Depok City',
    'address': '123 Test Street',
    'pictureId': 'www.',
    'categories': [
      {'name': 'Category 1'},
      {'name': 'Category 2'},
    ],
    'menus': {
      'foods': [
        {'name': 'Food 1'},
        {'name': 'Food 2'},
      ],
      'drinks': [
        {'name': 'Drink 1'},
        {'name': 'Drink 2'},
      ],
    },
    'rating': 4.8,
    'customerReviews': [
      {'name': 'John Doe', 'review': 'Great food!', 'date': '2023-01-01'},
      {
        'name': 'Jane Smith',
        'review': 'Excellent service!',
        'date': '2023-01-02'
      },
    ],
  };
}
