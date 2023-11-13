import 'package:dio/dio.dart';
import 'package:restaurant_app/config/data/local/canonical_path.dart';
import 'package:restaurant_app/config/data/network/api_service.dart';

class GetDetailRestaurantRepository {
  Future<Response> getListRestaurant({required String id}) async {
    final response =
        ApiService().get(path: "${CanonicalPath.getDetailRestaurant}/$id");
    return response;
  }
}
