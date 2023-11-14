import 'package:path/path.dart';
import 'package:restaurant_app/config/models/favorite_restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableName = 'favorites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'favorite.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id TEXT PRIMARY KEY,
               name TEXT, description TEXT, city TEXT, pictureId TEXT
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<String> insertFavoriteRestaurant(FavoriteRestaurant favoriteRestaurant) async {
    final Database db = await database;
    await db.insert(_tableName, favoriteRestaurant.toJson());
    return "Success Add To List Favorite Restaurant";
  }

  Future<List<FavoriteRestaurant>> getFavoriteRestaurant() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((res) => FavoriteRestaurant.fromJson(res)).toList();
  }

  Future<FavoriteRestaurant> getFavoriteRestaurantById(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return results.map((res) => FavoriteRestaurant.fromJson(res)).first;
  }

  Future<void> updateFavoriteRestaurant(FavoriteRestaurant favoriteRestaurant) async {
    final db = await database;

    await db.update(
      _tableName,
      favoriteRestaurant.toJson(),
      where: 'id = ?',
      whereArgs: [favoriteRestaurant.id],
    );
  }

  Future<void> deleteFavoriteRestaurant(String id) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}