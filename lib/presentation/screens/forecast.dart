import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../constants/constants/constants.dart';
import 'package:new_bloc_weather_app/logic/blocs/weather_bloc/weather_bloc.dart';

import '../../constants/widgets/weather_item.dart';

class ForecastPage extends StatelessWidget {
  final Constants constants = Constants();
  ForecastPage({super.key});

  @override
  Widget build(BuildContext forecastContext) {
    Size size = MediaQuery.of(forecastContext).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constants.primaryColor.withOpacity(.5),
        centerTitle: true,
        title: const Text("Forecast Weather"),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if(state is WeatherLoadedState) {
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    height: size.height * .75,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -50,
                          right: 20,
                          left: 20,
                          child: SizedBox(
                            height: size.height * .75,
                            width: size.width,
                            child: ListView.builder(
                                itemCount: state.weatherData.forecasts.length,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                    final dailyForecast = state.weatherData
                                        .forecasts[index];
                                    final dailyForecastAvgTemp = dailyForecast
                                        .day.avgTemp.toString();
                                    final forecastDate = DateFormat('MMMMEEEEd')
                                        .format(
                                        DateTime.parse(dailyForecast.date));
                                    final forecastChanceOfRain = dailyForecast
                                        .day.dailyChanceOfRain;
                                    final forecastAvgHumidity = dailyForecast
                                        .day.humidity;
                                    final forecastMaxWindSpeed = dailyForecast
                                        .day.maxwindKph;
                                    final forecastLocation = state.weatherData
                                        .location.name;

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: size.height,
                                        width: size.width * .85,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.center,
                                              colors: [
                                                Color(0xffa9c1f5),
                                                Color(0xff6696f5),
                                              ]),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blue.withOpacity(
                                                  .1),
                                              offset: Offset(0, 25),
                                              blurRadius: 3,
                                              spreadRadius: -10,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(
                                              15),
                                        ),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            const Positioned(
                                              top: 80,
                                              left: 50,
                                              child: Padding(
                                                padding:
                                                EdgeInsets.only(bottom: 10.0),
                                                child: Text(
                                                  'Avg Temperature:',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),

                                            Positioned(
                                              top: 100,
                                              left: 90,
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        top: 8.0),
                                                    child: Text(
                                                      dailyForecastAvgTemp,
                                                      style: TextStyle(
                                                        fontSize: 80,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        foreground: Paint()
                                                          ..shader =
                                                              constants.shader,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '\u2103',
                                                    style: TextStyle(
                                                      fontSize: 40,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      foreground: Paint()
                                                        ..shader = constants
                                                            .shader,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),


                                            Positioned(

                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "Location: ",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          foreground: Paint()
                                                            ..shader =
                                                                constants.shader,
                                                        ),
                                                      ),

                                                      Text(
                                                        forecastLocation,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          foreground: Paint()
                                                            ..shader =
                                                                constants.shader,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 40,
                                                  ),
                                                  const Center(
                                                    child: Text(
                                                      "Forecast Date: ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15),
                                                    ),
                                                  ),

                                                  Text(
                                                    forecastDate,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Positioned(
                                              bottom: 10,
                                              left: 20,
                                              child: Container(
                                                width: size.width * .8,
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    WeatherItem(
                                                      text: 'Wind Speed',
                                                      value: forecastMaxWindSpeed
                                                          .toInt(),
                                                      unit: "km/h",
                                                      imageUrl:
                                                      "assets/windspeed.png",
                                                    ),
                                                    WeatherItem(
                                                      text: 'Humidity',
                                                      value: forecastAvgHumidity
                                                          .toInt(),
                                                      unit: "%",
                                                      imageUrl:
                                                      "assets/humidity.png",
                                                    ),
                                                    WeatherItem(
                                                      text: 'Chance of Rain',
                                                      value: forecastChanceOfRain
                                                          .toInt(),
                                                      unit: "%",
                                                      imageUrl:
                                                      "assets/lightrain.png",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );

                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is WeatherLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else
          if (state is WeatherLoadingFailureState) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .center,
                mainAxisAlignment: MainAxisAlignment
                    .center,
                children: [
                  const Text(
                      "City not found. Please refresh"),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WeatherBloc>().add(
                          FetchWeatherEvent(
                              'Kuala Lumpur'));
                    },
                    child: const Text('Refresh'),
                  ),
                ],
              ),

            );
          } else {
            return const Center(
              child: Text("Unknown server error."),
            );
          }
        },
      ),
    );
  }
}
