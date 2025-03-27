import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/forecast_weather_api/forecast_weather_bloc/forecast_weather_bloc.dart';
import 'package:weatherapp/pages/weather_daily_details.dart';
import 'package:weatherapp/pages/weather_service.dart';
import 'package:weatherapp/weather_api/weather_api_bloc/weather_bloc.dart';
import 'package:weatherapp/weather_api/weather_api_helper.dart';

import '../forecast_weather_api/forecast_weather_api_helper.dart';

void main() {
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>WeatherBloc(WeatherApiHelp: WeatherApiHelper())),
          BlocProvider(create: (context)=>ForecastWeatherBloc(forecastWeatherApiHelper: ForecastWeatherApiHelper()) ),
        ], child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WeatherService()));
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/weather.jpg"),fit: BoxFit.cover
                  )
              ),
            ),
            Positioned(
              bottom: 60,
                child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText("Weather Vibe", textStyle: TextStyle(fontSize: 50,fontWeight: FontWeight.w900,color: Colors.white),
                        speed: Duration(milliseconds: 100),
                      ),
                    ],
                  /*totalRepeatCount: 3,
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                  isRepeatingAnimation: true,*/
                ),
            ),
          ],
        )
    );
  }
}
