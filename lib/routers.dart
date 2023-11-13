import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/home/home_bloc.dart';
import 'package:restaurant_app/screens/home_screen.dart';

class Routers {
  static const String home = "/home";

  final route = <String, WidgetBuilder>{
    Routers.home: (BuildContext context) {
      return BlocProvider(
        create: (context) => HomeBloc(),
        child: const HomeScreen(),
      );
    }
  };
}