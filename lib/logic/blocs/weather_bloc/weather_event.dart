
part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class FetchWeatherEvent extends WeatherEvent{

  final String location;

  FetchWeatherEvent(this.location);

}

class ReinitializeWeatherEvent extends WeatherEvent{ }
