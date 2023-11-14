import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_app/config/data/database/db_provider.dart';
import 'package:restaurant_app/config/models/favorite_restaurant.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<GetFavoriteRestaurant>(getFavoriteRestaurant);
  }

  Future<void> getFavoriteRestaurant(
      GetFavoriteRestaurant event,
      Emitter<FavoriteState> emit,
      ) async {
    try {
      emit(OnLoadingFavorite());
      final response = await DbProvider().getAllRestaurantFavorite();
      emit(OnSuccessGetListFavorite(listRestaurant: response));
    } on SocketException catch (e) {
      emit(OnFailedFavorite(message: e.toString()));
    } catch (e) {
      emit(OnFailedFavorite(message: e.toString()));
    }
  }
}
