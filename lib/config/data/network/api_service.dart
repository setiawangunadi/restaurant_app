import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:restaurant_app/config/data/local/constants.dart';

class ApiService {
  final Dio dio = Dio()
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));

  ApiService._privateConstructor();

  static final ApiService _instance = ApiService._privateConstructor();

  factory ApiService() => _instance;

  Future<Response> get({required String path}) async {
    try {
      final response = await dio.get('$baseUrl$path');
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> post({required String path, dynamic data}) async {
    try {
      final response = await dio.post('$baseUrl$path', data: data);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}