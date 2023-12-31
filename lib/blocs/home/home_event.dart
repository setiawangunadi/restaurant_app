part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetListRestaurant extends HomeEvent {}

class DoSetNotification extends HomeEvent {
  final ListRestaurantResponse data;

  DoSetNotification({required this.data});
}