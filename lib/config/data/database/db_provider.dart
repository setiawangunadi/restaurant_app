import 'package:flutter/material.dart';
import 'package:restaurant_app/config/data/database/database_helper.dart';
import 'package:restaurant_app/config/models/favorite_restaurant.dart';

class DbProvider extends ChangeNotifier {
  List<FavoriteRestaurant> _restaurantFavorite = [];
  late DatabaseHelper _dbHelper;

  List<FavoriteRestaurant> get restaurantFavorite => _restaurantFavorite;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllRestaurantFavorite();
  }

  void _getAllRestaurantFavorite() async {
    _restaurantFavorite = await _dbHelper.getFavoriteRestaurant();
    notifyListeners();
  }

  Future<List<FavoriteRestaurant>> getAllRestaurantFavorite() async {
    _restaurantFavorite = await _dbHelper.getFavoriteRestaurant();
    notifyListeners();
    return _restaurantFavorite;
  }

  Future<String> addRestaurantFavorite(FavoriteRestaurant restaurantFavorite) async {
    String response = await _dbHelper.insertFavoriteRestaurant(restaurantFavorite);
    _getAllRestaurantFavorite();
    debugPrint("THIS RESPONSE: $response");
    return response;
  }

  Future<FavoriteRestaurant> getRestaurantFavoriteById(int id) async {
    return await _dbHelper.getFavoriteRestaurantById(id);
  }

  void updateRestaurantFavorite(FavoriteRestaurant restaurantFavorite) async {
    await _dbHelper.updateFavoriteRestaurant(restaurantFavorite);
    _getAllRestaurantFavorite();
  }

  Future<String> deleteRestaurantFavorite(String id) async {
    await _dbHelper.deleteFavoriteRestaurant(id);
    _getAllRestaurantFavorite();
    return "Success Delete Favorite Restaurant";
  }
}