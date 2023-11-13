import 'package:dio/dio.dart';
import 'package:restaurant_app/config/data/local/canonical_path.dart';
import 'package:restaurant_app/config/data/network/api_service.dart';

class GetListRestaurantRepository {
  Future<Response> getListRestaurant() async {
    final response = ApiService().get(path: CanonicalPath.getListRestaurant);
    return response;
  }
}