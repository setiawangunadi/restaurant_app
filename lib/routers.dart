import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/detail_restaurant/detail_restaurant_bloc.dart';
import 'package:restaurant_app/blocs/favorite/favorite_bloc.dart';
import 'package:restaurant_app/blocs/home/home_bloc.dart';
import 'package:restaurant_app/blocs/search/search_bloc.dart';
import 'package:restaurant_app/screens/detail_restaurant_screen.dart';
import 'package:restaurant_app/screens/favorite_screen.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/screens/search_screen.dart';

class Routers {
  static const String home = "/home";
  static const String detail = "/detail";
  static const String search = "/search";
  static const String favorite = "/favorite";

  final route = <String, WidgetBuilder>{
    Routers.home: (BuildContext context) {
      return BlocProvider(
        create: (context) => HomeBloc(),
        child: const HomeScreen(),
      );
    },
    Routers.detail: (BuildContext context) {
      var args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;

      return BlocProvider(
        create: (context) => DetailRestaurantBloc(),
        child: DetailRestaurantScreen(
          id: args[0],
          type: args[1],
        ),
      );
    },
    Routers.search: (BuildContext context) {
      return BlocProvider(
        create: (context) => SearchBloc(),
        child: const SearchScreen(),
      );
    },
    Routers.favorite: (BuildContext context) {
      return BlocProvider(
        create: (context) => FavoriteBloc(),
        child: const FavoriteScreen(),
      );
    },
  };
}
