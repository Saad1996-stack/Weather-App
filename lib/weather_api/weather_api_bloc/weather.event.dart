class WeatherEvent {}

class GetWeatherEvent extends WeatherEvent {}

class GetWeatherByCityEvent extends WeatherEvent
{
  String cityName;
  GetWeatherByCityEvent({required this.cityName});
}