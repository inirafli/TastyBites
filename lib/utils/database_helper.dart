import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'tasty_bites.db';
  static const _databaseVersion = 1;

  static const _favoriteTable = 'favorite';
  static const _columnId = 'id';

  late Database _database;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_favoriteTable (
            $_columnId TEXT PRIMARY KEY
          )
        ''');
      },
      version: _databaseVersion,
    );
  }

  Future<List<String>> getFavoriteRestaurantIds() async {
    await initializeDatabase();
    final List<Map<String, dynamic>> maps = await _database.query(_favoriteTable);
    return List<String>.from(maps.map((map) => map[_columnId] as String));
  }

  Future<void> addFavoriteRestaurant(String restaurantId) async {
    await initializeDatabase();
    await _database.insert(_favoriteTable, {_columnId: restaurantId},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFavoriteRestaurant(String restaurantId) async {
    await initializeDatabase();
    await _database.delete(_favoriteTable, where: '$_columnId = ?', whereArgs: [restaurantId]);
  }
}
