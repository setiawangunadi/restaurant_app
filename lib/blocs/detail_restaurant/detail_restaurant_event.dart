part of 'detail_restaurant_bloc.dart';

@immutable
abstract class DetailRestaurantEvent {}

class GetDetailRestaurant extends DetailRestaurantEvent {
  final String id;

  GetDetailRestaurant({required this.id});
}

class DoFavoriteRestaurant extends DetailRestaurantEvent {
  final DetailRestaurantResponse detailRestaurantResponse;

  DoFavoriteRestaurant({required this.detailRestaurantResponse});
}