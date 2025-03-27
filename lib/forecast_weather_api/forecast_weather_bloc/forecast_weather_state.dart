import '../../weather_model/weather_forecast_model.dart';

class ForecastWeatherState {}

class InitialForecastWeatherState extends ForecastWeatherState {}

class LoadingForecastWeatherState extends ForecastWeatherState {}

class ErrorForecastWeatherState extends ForecastWeatherState
{
  String errorMsg;
  ErrorForecastWeatherState({required this.errorMsg});
}

class LoadedForecastWeatherState extends ForecastWeatherState
{
  DataWeatherForecastModel resDataWeatherForecastModel;
  LoadedForecastWeatherState({required this.resDataWeatherForecastModel});
}