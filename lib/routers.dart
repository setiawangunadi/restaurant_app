import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/detail_restaurant/detail_restaurant_bloc.dart';
import 'package:restaurant_app/blocs/home/home_bloc.dart';
import 'package:restaurant_app/blocs/search/search_bloc.dart';
import 'package:restaurant_app/screens/detail_restaurant_screen.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/screens/search_screen.dart';

class Routers {
  static const String home = "/home";
  static const String detail = "/detail";
  static const String search = "/search";

  final route = <String, WidgetBuilder>{
    Routers.home: (BuildContext context) {
      return BlocProvider(
        create: (context) => HomeBloc(),
        child: const HomeScreen(),
      );
    },
    Routers.detail: (BuildContext context) {
      return BlocProvider(
        create: (context) => DetailRestaurantBloc(),
        child: DetailRestaurantScreen(
            id: ModalRoute.of(context)!.settings.arguments as String),
      );
    },
    Routers.search: (BuildContext context) {
      return BlocProvider(
        create: (context) => SearchBloc(),
        child: const SearchScreen(),
      );
    },
  };
}
