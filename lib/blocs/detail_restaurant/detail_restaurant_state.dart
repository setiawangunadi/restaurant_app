part of 'detail_restaurant_bloc.dart';

@immutable
abstract class DetailRestaurantState {}

class DetailRestaurantInitial extends DetailRestaurantState {}

class OnLoadingDetailRestaurant extends DetailRestaurantState {}

class OnSuccessGetDetailRestaurant extends DetailRestaurantState {
  final DetailRestaurantResponse detailRestaurantResponse;

  OnSuccessGetDetailRestaurant({required this.detailRestaurantResponse});
}

class OnSuccessAddFavorite extends DetailRestaurantState {
  final String message;

  OnSuccessAddFavorite({required this.message});
}

class OnSuccessDeleteFavorite extends DetailRestaurantState {
  final String message;

  OnSuccessDeleteFavorite({required this.message});
}

class OnFailedDetailRestaurant extends DetailRestaurantState {
  final String message;
  final int? statusCode;

  OnFailedDetailRestaurant({required this.message, this.statusCode});
}
