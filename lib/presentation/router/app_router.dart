import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_bloc_weather_app/presentation/screens/forecast.dart';
import 'package:new_bloc_weather_app/presentation/screens/home.dart';

class AppRouter {

  Route? onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case'/':
        return MaterialPageRoute(builder: (_) => MyHomePage(),);

      case'/forecast':
        return MaterialPageRoute(builder: (_) => ForecastPage(),);

      default:
        return null;

    }

  }
}