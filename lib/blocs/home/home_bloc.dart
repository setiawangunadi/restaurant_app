import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_app/config/models/list_restaurant_response.dart';
import 'package:restaurant_app/config/repositories/get_list_restaurant_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetListRestaurantRepository getListRestaurantRepository =
      GetListRestaurantRepository();

  HomeBloc() : super(HomeInitial()) {
    on<GetListRestaurant>(getListRestaurant);
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
}
