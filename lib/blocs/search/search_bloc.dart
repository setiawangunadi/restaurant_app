import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_app/config/models/search_response.dart';
import 'package:restaurant_app/config/repositories/search_respository.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository = SearchRepository();

  SearchBloc() : super(SearchInitial()) {
    on<DoSearchRestaurant>(doSearchRestaurant);
  }

  Future<void> doSearchRestaurant(
    DoSearchRestaurant event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(OnLoadingSearch());
      final response = await searchRepository.doSearch(query: event.query);
      if (response.statusCode == 200) {
        SearchResponse searchResponse = SearchResponse.fromJson(response.data);
        emit(OnSuccessSearch(searchResponse: searchResponse));
      }
    } on SocketException catch (e) {
      emit(OnFailedSearch(message: e.toString()));
    } catch (e) {
      emit(OnFailedSearch(message: e.toString()));
    }
  }
}
