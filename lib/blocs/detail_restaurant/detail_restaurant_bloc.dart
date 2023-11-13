import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_app/config/models/detail_restaurant_response.dart';
import 'package:restaurant_app/config/repositories/get_detail_restaurant_repository.dart';

part 'detail_restaurant_event.dart';

part 'detail_restaurant_state.dart';

class DetailRestaurantBloc
    extends Bloc<DetailRestaurantEvent, DetailRestaurantState> {
  final GetDetailRestaurantRepository getDetailRestaurantRepository =
      GetDetailRestaurantRepository();

  DetailRestaurantBloc() : super(DetailRestaurantInitial()) {
    on<GetDetailRestaurant>(getDetailRestaurant);
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
}
