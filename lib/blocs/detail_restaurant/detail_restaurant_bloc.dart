import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_app/config/data/database/db_provider.dart';
import 'package:restaurant_app/config/models/detail_restaurant_response.dart';
import 'package:restaurant_app/config/models/favorite_restaurant.dart';
import 'package:restaurant_app/config/repositories/get_detail_restaurant_repository.dart';

part 'detail_restaurant_event.dart';

part 'detail_restaurant_state.dart';

class DetailRestaurantBloc
    extends Bloc<DetailRestaurantEvent, DetailRestaurantState> {
  final GetDetailRestaurantRepository getDetailRestaurantRepository =
      GetDetailRestaurantRepository();

  DetailRestaurantBloc() : super(DetailRestaurantInitial()) {
    on<GetDetailRestaurant>(getDetailRestaurant);
    on<DoFavoriteRestaurant>(doFavoriteRestaurant);
    on<DoDeleteRestaurant>(doDeleteRestaurant);
  }

  Future<void> getDetailRestaurant(
    GetDetailRestaurant event,
    Emitter<DetailRestaurantState> emit,
  ) async {
    try {
      emit(OnLoadingDetailRestaurant());
      final response =
          await getDetailRestaurantRepository.getListRestaurant(id: event.id);
      if (response.statusCode == 200) {
        DetailRestaurantResponse detailRestaurantResponse =
            DetailRestaurantResponse.fromJson(response.data);
        emit(OnSuccessGetDetailRestaurant(
            detailRestaurantResponse: detailRestaurantResponse));
      }
    } on SocketException catch (e) {
      emit(OnFailedDetailRestaurant(message: e.toString()));
    } catch (e) {
      emit(OnFailedDetailRestaurant(message: e.toString()));
    }
  }

  Future<void> doFavoriteRestaurant(
    DoFavoriteRestaurant event,
    Emitter<DetailRestaurantState> emit,
  ) async {
    try {
      emit(OnLoadingDetailRestaurant());
      final FavoriteRestaurant favoriteRestaurant = FavoriteRestaurant();
      favoriteRestaurant.name = event.detailRestaurantResponse.restaurant?.name;
      favoriteRestaurant.id = event.detailRestaurantResponse.restaurant?.id;
      favoriteRestaurant.pictureId =
          event.detailRestaurantResponse.restaurant?.pictureId;
      favoriteRestaurant.description =
          event.detailRestaurantResponse.restaurant?.description;
      favoriteRestaurant.city = event.detailRestaurantResponse.restaurant?.city;
      final response =
          await DbProvider().addRestaurantFavorite(favoriteRestaurant);
      if (response == "Success Add To List Favorite Restaurant") {
        emit(OnSuccessAddFavorite(message: response));
      }
    } on SocketException catch (e) {
      emit(OnFailedDetailRestaurant(message: e.toString()));
    } catch (e) {
      emit(OnFailedDetailRestaurant(message: e.toString()));
    }
  }

  Future<void> doDeleteRestaurant(
    DoDeleteRestaurant event,
    Emitter<DetailRestaurantState> emit,
  ) async {
    try {
      emit(OnLoadingDetailRestaurant());
      final response = await DbProvider().deleteRestaurantFavorite(event.id);
      emit(OnSuccessDeleteFavorite(message: response));
    } on SocketException catch (e) {
      emit(OnFailedDetailRestaurant(message: e.toString()));
    } catch (e) {
      emit(OnFailedDetailRestaurant(message: e.toString()));
    }
  }
}
