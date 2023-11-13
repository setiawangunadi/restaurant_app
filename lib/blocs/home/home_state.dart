part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class OnLoadingHome extends HomeState {}

class OnSuccessGetRestaurant extends HomeState {
  final ListRestaurantResponse listRestaurantModel;

  OnSuccessGetRestaurant({required this.listRestaurantModel});
}

class OnFailedHome extends HomeState {
  final String message;
  final int? statusCode;

  OnFailedHome({required this.message, this.statusCode});
}
