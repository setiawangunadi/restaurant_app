import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/config/data/handler/notification_helper.dart';
import 'package:restaurant_app/config/data/local/shared_prefs_storage.dart';
import 'package:restaurant_app/config/models/list_restaurant_response.dart';
import 'package:restaurant_app/config/repositories/get_list_restaurant_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetListRestaurantRepository getListRestaurantRepository =
      GetListRestaurantRepository();

  HomeBloc() : super(HomeInitial()) {
    on<GetListRestaurant>(getListRestaurant);
    on<DoSetNotification>(doSetNotification);
  }

  Future<void> getListRestaurant(
    GetListRestaurant event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(OnLoadingHome());
      final response = await getListRestaurantRepository.getListRestaurant();
      if (response.statusCode == 200) {
        ListRestaurantResponse listRestaurantResponse =
            ListRestaurantResponse.fromJson(response.data);
        emit(OnSuccessGetRestaurant(
            listRestaurantModel: listRestaurantResponse));
      }
    } on SocketException catch (e) {
      emit(OnFailedHome(message: e.toString()));
    } catch (e) {
      emit(OnFailedHome(message: e.toString()));
    }
  }

  Future<void> doSetNotification(
    DoSetNotification event,
    Emitter<HomeState> emit,
  ) async {
    try {
      int value = await SharedPrefsStorage.getNotification() ?? 0;
      int index = 0;
      var rng = Random();
      index = rng.nextInt(event.data.restaurants!.length);
      debugPrint("THIS INDEX VALUE RANDOM : $index");
      if (value == 1) {
        await NotificationHelper().scheduleNotification(
          title: event.data.restaurants?[index].name,
          body: event.data.restaurants?[index].description,
        );
        emit(OnSuccessSetNotification(
            id: event.data.restaurants?[index].id ?? ""));
        debugPrint(
            "SET NOTIFICATION ${event.data.restaurants?[index].name}");
      }
    } on SocketException catch (e) {
      emit(OnFailedHome(message: e.toString()));
    } catch (e) {
      emit(OnFailedHome(message: e.toString()));
    }
  }
}
