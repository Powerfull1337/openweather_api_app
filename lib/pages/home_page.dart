import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:openweather_api_app/bloc/weather_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 10, 28, 59),
              Color.fromARGB(255, 8, 65, 37)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherSuccess) {
              final weather = state.weather;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    RichText(
                      text: TextSpan(
                          text: "You position is here:  ",
                          style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: "${weather.country}",
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                    getWeatherIcon(weather.weatherConditionCode!),
                    const SizedBox(height: 30),
                    Text(
                      "Current temperature: ${weather.temperature}",
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Image.asset(
                            'assets/images/13.png',
                            scale: 8,
                          ),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Temp Max',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "${weather.tempMax} °C",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          )
                        ]),
                        Row(children: [
                          Image.asset(
                            'assets/images/14.png',
                            scale: 8,
                          ),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Temp Min',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "${weather.tempMin} °C",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          )
                        ])
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is WeatherFailure) {
              return Center(child: Text(state.error));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

Widget getWeatherIcon(int code) {
  switch (code) {
    case >= 200 && < 300:
      return Image.asset('assets/images/1.png');
    case >= 300 && < 400:
      return Image.asset('assets/images/2.png');
    case >= 500 && < 600:
      return Image.asset('assets/images/3.png');
    case >= 600 && < 700:
      return Image.asset('assets/images/4.png');
    case >= 700 && < 800:
      return Image.asset('assets/images/5.png');
    case == 800:
      return Image.asset('assets/images/6.png');
    case > 800 && <= 804:
      return Image.asset('assets/images/7.png');
    default:
      return Image.asset('assets/images/7.png');
  }
}
