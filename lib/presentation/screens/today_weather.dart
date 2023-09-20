
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:new_bloc_weather_app/constants/constants/constants.dart';
import 'package:new_bloc_weather_app/logic/blocs/weather_bloc/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/widgets/weather_item.dart';
import '../../logic/cubits/location_cubit.dart';

class TodayWeather extends StatefulWidget {
  const TodayWeather({super.key});

  @override
  State<TodayWeather> createState() => _TodayWeatherState();
}

class _TodayWeatherState extends State<TodayWeather> {


  @override
  Widget build(BuildContext homeContext) {
    final cityController = TextEditingController();
    final Constants constants = Constants();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    Size size = MediaQuery.of(homeContext).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constants.primaryColor.withOpacity(.5),
        centerTitle: true,
        title: const Text('Today Weather'),
      ),
      body: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {

          return BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
            if (state is WeatherLoadedState) {
              final currentLocation = state.weatherData.location;
              final currentLocationName = currentLocation.name;
              final currentForecast = state.weatherData.forecasts[0];
              final currentWeatherIcon =
                  "assets/${currentForecast.day.condition.replaceAll(' ', '').toLowerCase()}.png";
              final currentWeather = state.weatherData.current;
              final currentTemperature = currentWeather.tempC.toString();
              final todayDate = DateFormat('MMMMEEEEd')
                  .format(DateTime.parse(state.weatherData.location.localtime));
              final lastUpdatedTime = DateFormat('h:mm a')
                  .format(DateTime.parse(state.weatherData.location.localtime));
              final currentWindSpeed = currentWeather.windKph.toInt();
              final currentHumidity = currentWeather.humidity.toInt();
              final currentChanceOfRain = currentWeather.cloud.toInt();


              return SingleChildScrollView(
                child: Container(
                  width: size.width,
                  height: size.height,
                  padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
                  color: constants.primaryColor.withOpacity(.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        height: size.height * .7,
                        decoration: BoxDecoration(
                          gradient: constants.linearGradientBlue,
                          boxShadow: [
                            BoxShadow(
                              color: constants.primaryColor.withOpacity(.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            )
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/menu.png",
                                  width: 40,
                                  height: 40,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/pin.png",
                                      width: 20,
                                    ),
                                    Text(
                                      currentLocationName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        cityController.clear();
                                        showMaterialModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                SingleChildScrollView(
                                                  controller:
                                                      ModalScrollController.of(
                                                          context),
                                                  child: Container(
                                                    height: size.height * 0.5,
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          width: 70,
                                                          child: Divider(
                                                            thickness: 3.5, color: constants.primaryColor,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextField(
                                                          controller:
                                                              cityController,
                                                          autofocus: true,
                                                          decoration:
                                                              InputDecoration(
                                                            prefixIcon:
                                                                GestureDetector(
                                                              onTap: () =>
                                                                  cityController
                                                                      .clear(), child: Icon(
                                                                Icons.close,
                                                                color: constants.primaryColor,
                                                              ),
                                                            ),
                                                            suffixIcon:
                                                                GestureDetector(
                                                              onTap: () {
                                                                context.read<LocationCubit>().updateLocation(cityController.text.trim());
                                                                context.read<WeatherBloc>().add(FetchWeatherEvent(cityController.text.trim()));
                                                                Navigator.pop(context); //use for dismissing the keyboard
                                                              },
                                                              child: Icon(
                                                                Icons.search,
                                                                color: constants
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                            hintText:
                                                                'Search city e.g. Kuala Lumpur',
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: constants
                                                                    .primaryColor,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Image.asset(
                                height: 160,
                                currentWeatherIcon // Assuming you want the icon for the first forecast
                                ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        currentTemperature,
                                        style: TextStyle(
                                          fontSize: 80,
                                          fontWeight: FontWeight.bold,
                                          foreground: Paint()
                                            ..shader = constants.shader,
                                        ),
                                      ),
                                      Text(
                                        '\u2103',
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          foreground: Paint()
                                            ..shader = constants.shader,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  todayDate,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Last Updated (Local Time): ',
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      lastUpdatedTime,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: const Divider(
                                    color: Colors.white70,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      WeatherItem(
                                        text: 'Wind Speed',
                                        value: currentWindSpeed,
                                        unit: 'km/h',
                                        imageUrl: 'assets/windspeed.png',
                                      ),
                                      WeatherItem(
                                        text: 'Humidity',
                                        value: currentHumidity,
                                        unit: '%',
                                        imageUrl: 'assets/humidity.png',
                                      ),
                                      WeatherItem(
                                        text: 'Chance Of Rain',
                                        value: currentChanceOfRain,
                                        unit: '%',
                                        imageUrl: 'assets/cloud.png',
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        height: size.height * .20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Today',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(homeContext)
                                        .pushNamed('/forecast');
                                  },
                                  child: Text(
                                    'Forecast',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: constants.primaryColor,
                                    ),
                                  ), //this will open forecast screen
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 110,
                              child: ListView.builder(
                                itemCount: state.weatherData.forecasts[0]
                                    .hourlyTemperature.length,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),

                                //hourly temperature forecast

                                itemBuilder: (BuildContext context, int index) {
                                  final hourlyTemp = state.weatherData
                                      .forecasts[0].hourlyTemperature;
                                  String currentTime = DateFormat('HH:mm:ss')
                                      .format(DateTime.now());
                                  String currentHour =
                                      currentTime.substring(0, 2);
                                  String forecastTime =
                                      hourlyTemp[index].time.substring(11, 16);
                                  String forecastHour =
                                      hourlyTemp[index].time.substring(11, 13);
                                  String hourlyWeatherIcon =
                                      "${hourlyTemp[index].condition.replaceAll(' ', '').toLowerCase()}.png";
                                  String forecastTemperature = hourlyTemp[index]
                                      .tempC
                                      .round()
                                      .toString();

                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    margin: const EdgeInsets.only(right: 20),
                                    width: 65,
                                    decoration: BoxDecoration(
                                        color: currentHour == forecastHour
                                            ? Colors.white
                                            : constants.primaryColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0, 1),
                                            blurRadius: 5,
                                            color: constants.primaryColor
                                                .withOpacity(.2),
                                          )
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          forecastTime,
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: constants.greyColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/' + hourlyWeatherIcon,
                                          width:
                                              20, // Assuming you want the icon for the first forecast
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              forecastTemperature,
                                              style: TextStyle(
                                                color: constants.greyColor,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              '\u2103',
                                              style: TextStyle(
                                                color: constants.greyColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                                fontFeatures: const [
                                                  FontFeature.enable('sups'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is WeatherLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherLoadingFailureState) {
              return  Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("City not found. Please refresh"),
                    ElevatedButton(
                      onPressed: () {
                        context.read<WeatherBloc>().add(FetchWeatherEvent('Kuala Lumpur'));
                        context.read<LocationCubit>().updateLocation('Kuala Lumpur');

                      },
                      child: Text('Refresh'),
                    ),
                  ],
                ),

              );
            } else {
              return const Center(
                child: Text("Unknown server error."),
              );
            }
          });
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
