// To parse this JSON data, do
//
//     final listRestaurantResponse = listRestaurantResponseFromJson(jsonString);

import 'dart:convert';

ListRestaurantResponse listRestaurantResponseFromJson(String str) => ListRestaurantResponse.fromJson(json.decode(str));

String listRestaurantResponseToJson(ListRestaurantResponse data) => json.encode(data.toJson());

class ListRestaurantResponse {
  final bool? error;
  final String? message;
  final int? count;
  final List<Restaurant>? restaurants;

  ListRestaurantResponse({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  factory ListRestaurantResponse.fromJson(Map<String, dynamic> json) => ListRestaurantResponse(
    error: json["error"],
    message: json["message"],
    count: json["count"],
    restaurants: json["restaurants"] == null ? [] : List<Restaurant>.from(json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": restaurants == null ? [] : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
  };
}

class Restaurant {
  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final double? rating;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: json["rating"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "rating": rating,
  };
}
