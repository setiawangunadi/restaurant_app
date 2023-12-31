part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class OnLoadingSearch extends SearchState {}

class OnSuccessSearch extends SearchState {
  final SearchResponse searchResponse;

  OnSuccessSearch({required this.searchResponse});
}

class OnFailedSearch extends SearchState {
  final String message;
  final int? statusCode;

  OnFailedSearch({required this.message, this.statusCode});
}
