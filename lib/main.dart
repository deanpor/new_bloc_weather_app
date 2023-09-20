import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:new_bloc_weather_app/logic/cubits/compass_cubit.dart';
import 'package:new_bloc_weather_app/logic/cubits/location_cubit.dart';
import 'package:new_bloc_weather_app/presentation/router/app_router.dart';
import 'package:new_bloc_weather_app/logic/blocs/weather_bloc/weather_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'logic/cubits/bottom_navigation_cubit.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  runApp(MyApp(
    appRouter:AppRouter(),

  ));
}

class MyApp extends StatelessWidget {
  final AppRouter? appRouter;

  const MyApp({super.key, @required this.appRouter});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(locationCubit: LocationCubit()),
        ),

        BlocProvider<BottomNavigationCubit>(
          create: (context) => BottomNavigationCubit(),
        ),

        BlocProvider<CompassCubit>(
          create: (context) => CompassCubit(),
        ),

        BlocProvider<LocationCubit>(
          create:(context) => LocationCubit(),
        ),

      ], child: MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      onGenerateRoute: appRouter?.onGenerateRoute,

    ),
    );

  }
}

