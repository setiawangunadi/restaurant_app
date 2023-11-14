part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class OnLoadingFavorite extends FavoriteState {}

class OnSuccessGetListFavorite extends FavoriteState {
  final List<FavoriteRestaurant> listRestaurant;

  OnSuccessGetListFavorite({required this.listRestaurant});
}

class OnFailedFavorite extends FavoriteState {
  final String message;
  final int? statusCode;

  OnFailedFavorite({required this.message, this.statusCode});
}
