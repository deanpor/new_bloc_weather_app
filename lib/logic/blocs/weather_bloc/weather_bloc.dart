import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:new_bloc_weather_app/logic/blocs/weather_bloc/weather_bloc.dart';
import 'package:new_bloc_weather_app/logic/blocs/weather_bloc/weather_bloc.dart';
import 'package:new_bloc_weather_app/logic/blocs/weather_bloc/weather_bloc.dart';

import '../../../data/dataprovider/remote_service.dart';
import '../../../data/dataprovider/repository/api_service.dart';
import '../../../data/models/weather_model.dart';
import '../../cubits/location_cubit.dart';


part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final RemoteService _apiService = ApiService();
  final LocationCubit locationCubit;


  WeatherBloc({required this.locationCubit}) : super(WeatherInitialState()) {
    _initializeWeatherData();

    on<ReinitializeWeatherEvent>((event, emit) async {
      await _initializeWeatherData();
    });
  }

  Future<void> _initializeWeatherData() async {
    // final storedLocation = getStoredLocation();
    final defaultLocation = 'Kuala Lumpur';
    final storedLocation = locationCubit.getSavedLocation();

    // Fetch weather data immediately when the WeatherBloc is created.
    on<FetchWeatherEvent>((event, emit) async{
      emit(WeatherLoadingState());
      try{

        final response = await _apiService.getWeatherData(event.location);
        if (response.statusCode == 200) {
          WeatherData weatherData = WeatherData.fromJson(jsonDecode(response.body));
          debugPrint(response.body);
          emit(WeatherLoadedState(weatherData));
        } else if (response.statusCode == 404) {
          final data = jsonDecode(response.body);
          emit(WeatherLoadingFailureState(data['message']));
        } else if (response.statusCode == 429) {
          emit(WeatherLoadingFailureState('Limit crossed'));
        } else {
          emit(WeatherLoadingFailureState('Unknown error ${response.statusCode}'));
        }
      }catch (error) {
        emit(WeatherLoadingFailureState('Unable to fetch weather data'));
        debugPrint('_fetchWeatherDataError: $error');
      }
    });
    storedLocation != '' ? add(FetchWeatherEvent(storedLocation)) : add(FetchWeatherEvent(defaultLocation));
  }

}
