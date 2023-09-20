class WeatherData {
  final Location location;
  final List<Forecast> forecasts;
  final CurrentWeather current;

  WeatherData({required this.location, required this.forecasts, required this.current});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final location = Location.fromJson(json['location']);
    final List<Forecast> forecasts = List<Forecast>.from(
        json['forecast']['forecastday'].map((forecast) => Forecast.fromJson(forecast)));
    final current = CurrentWeather.fromJson(json['current']);

    return WeatherData(location: location, forecasts: forecasts, current: current);
  }
}

class CurrentWeather {
  final double tempC;
  final double windKph;
  final String condition;
  final String iconUrl;
  final int humidity;
  final int cloud;

  CurrentWeather({
    required this.tempC,
    required this.windKph,
    required this.condition,
    required this.iconUrl,
    required this.humidity,
    required this.cloud,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    final tempC = json['temp_c'].toDouble();
    final windKph = json['wind_kph'].toDouble();
    final condition = json['condition']['text'];
    final icon = json['condition']['icon'];
    final iconUrl = 'https:$icon';
    final humidity = json['humidity'];
    final cloud = json['cloud'];

    return CurrentWeather(
      tempC: tempC,
      windKph: windKph,
      condition: condition,
      iconUrl: iconUrl,
      humidity: humidity,
      cloud: cloud,
    );
  }
}
class Location {
  final String name;
  final String region;
  final String country;
  final String localtime;

  Location({required this.name, required this.region, required this.country, required this.localtime});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        name: json['name'],
        region: json['region'],
        country: json['country'],
        localtime:json['localtime']);

  }
}

class Forecast {
  final String date;
  final Day day;
  final List<HourlyTemperature> hourlyTemperature;

  Forecast({required this.date, required this.day, required this.hourlyTemperature});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    final date = json['date'];
    final day = Day.fromJson(json['day']);
    final List<HourlyTemperature> hourlyTemperature = List<HourlyTemperature>.from(json['hour'].map((hour)=> HourlyTemperature.fromJson(hour)));
    return Forecast(
      date: date,
      day: day,
      hourlyTemperature: hourlyTemperature,
    );
  }
}

class Day {
  final double maxTemp;
  final double minTemp;
  final String condition;
  final String iconUrl;
  final double avgTemp;
  final double maxwindKph;
  final double dailyChanceOfRain;
  final double humidity;

  Day(
      {required this.maxTemp,
        required this.minTemp,
        required this.condition,
        required this.iconUrl,
        required this.avgTemp,
        required this.maxwindKph,
      required this.dailyChanceOfRain,
      required this.humidity});

  factory Day.fromJson(Map<String, dynamic> json) {
    final maxTemp = json['maxtemp_c'].toDouble();
    final minTemp = json['mintemp_c'].toDouble();
    final condition = json['condition']['text'];
    final icon = json['condition']['icon'];
    final iconUrl = 'https:$icon';
    final avgTemp = json['avgtemp_c'].toDouble();
    final maxwindKph = json['maxwind_kph'].toDouble();
    final dailyChanceOfRain = json['daily_chance_of_rain'].toDouble();
    final humidity = json['avghumidity'].toDouble();

    return Day(
        maxTemp: maxTemp,
        minTemp: minTemp,
        condition: condition,
        iconUrl: iconUrl,
        avgTemp: avgTemp,
    dailyChanceOfRain: dailyChanceOfRain,
      maxwindKph: maxwindKph,
      humidity: humidity,
    );
  }
}

class HourlyTemperature{
  final String time;
  final double tempC;
  final String iconUrl;
  final String condition;

  HourlyTemperature({required this.time, required this.tempC, required this.iconUrl, required this.condition});

  factory HourlyTemperature.fromJson(Map<String, dynamic> json)
  {
    final time = json['time'];
    final tempC = json['temp_c'].toDouble();
    final icon = json['condition']['icon'];
    final iconUrl = 'https:$icon';
    final condition = json['condition']['text'];

    return HourlyTemperature(time: time, tempC: tempC, iconUrl: iconUrl, condition: condition);
  }

}
