part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class DoSearchRestaurant extends SearchEvent {
  final String query;

  DoSearchRestaurant({required this.query});

}