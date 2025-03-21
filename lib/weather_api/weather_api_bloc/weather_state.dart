import '../../weather_model/weather_model.dart';

class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherErrorState extends WeatherState
{
  String errorMsg;
  WeatherErrorState({required this.errorMsg});
}

class WeatherLoadedState extends WeatherState
{
  DataWeatherModel resDataWeather;
  WeatherLoadedState({required this.resDataWeather});
}