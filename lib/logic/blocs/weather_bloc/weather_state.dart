part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitialState extends WeatherState{
}

class WeatherLoadingState extends WeatherState{}

class WeatherLoadedState extends WeatherState{
  final WeatherData weatherData;

  WeatherLoadedState(this.weatherData);

}

class WeatherLoadingFailureState extends WeatherState{
  final String error;

  WeatherLoadingFailureState(this.error);

}

class WeatherRefreshState extends WeatherState {


}

