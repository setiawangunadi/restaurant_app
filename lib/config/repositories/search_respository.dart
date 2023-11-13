import 'package:dio/dio.dart';
import 'package:restaurant_app/config/data/local/canonical_path.dart';
import 'package:restaurant_app/config/data/network/api_service.dart';

class SearchRepository {
  Future<Response> doSearch({required String query}) async {
    final response = ApiService().get(
        path: CanonicalPath.doSearchRestaurant, queryParameters: {"q": query});
    return response;
  }
}
