import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:openweather_api_app/bloc/weather_bloc.dart';
import 'package:openweather_api_app/pages/home_page.dart';

import 'package:geolocator/geolocator.dart';
import 'package:openweather_api_app/service/geolocator.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: LocatorService().determinePosition(),
            builder: (context, snap) {
              if (snap.hasData) {
                return BlocProvider<WeatherBloc>(
                  create: (context) =>
                      WeatherBloc()..add(FetchWeather(snap.data as Position)),
                  child: const HomePage(),
                );
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }));
  }
}
