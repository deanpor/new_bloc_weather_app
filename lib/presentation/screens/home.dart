import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bloc_weather_app/presentation/screens/compass.dart';
import 'package:new_bloc_weather_app/presentation/screens/forecast.dart';
import 'package:new_bloc_weather_app/presentation/screens/today_weather.dart';

import '../../logic/cubits/bottom_navigation_cubit.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final PageController _pageController = PageController(initialPage: 0);
  final _bottomNavigationBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.cloud, color: Colors.blue), label: 'Today Weather'),
    BottomNavigationBarItem(icon: Image.asset(
        width: 20, "assets/sunny.png"), label: 'Weather Forecast'),
    const BottomNavigationBarItem(icon: Icon(Icons.compass_calibration_sharp, color: Colors.blueGrey), label: 'Compass'),

  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavigationCubit = BlocProvider.of<BottomNavigationCubit>(context);
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(

      builder: (context, state) {
        final pageState = context.watch<BottomNavigationCubit>().state;
        return Scaffold(
          body: PageView(
            controller: _pageController,
            onPageChanged: (newIndex) {
              bottomNavigationCubit.updateIndex(newIndex);
            },
            children: [
              TodayWeather(),
              ForecastPage(),
              CompassPage(),
              //LoadingPage(),

            ],
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: pageState.pageIndex,
            items: _bottomNavigationBarItems,
            onTap: (index) {
              _pageController.animateToPage(
                  index, duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
              bottomNavigationCubit.updateIndex(index);
            },
            // type: BottomNavigationBarType.fixed,
          ),

          // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}
