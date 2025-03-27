  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:weatherapp/forecast_weather_api/forecast_weather_bloc/forecast_weather_event.dart';
  import 'package:weatherapp/forecast_weather_api/forecast_weather_bloc/forecast_weather_state.dart';

  import '../../weather_model/weather_forecast_model.dart';
  import '../../weather_url/weather_forecast_url.dart';
  import '../forecast_weather_api_helper.dart';
  import '../forecast_weather_error_handling/forecast_weather_error_handling.dart';

  class ForecastWeatherBloc extends Bloc<ForecastWeatherEvent, ForecastWeatherState>
  {
    ForecastWeatherApiHelper forecastWeatherApiHelper;
    ForecastWeatherBloc({required this.forecastWeatherApiHelper}) : super(InitialForecastWeatherState())
    {
      on<GetForecastWeatherEvent>((event, emit)async{
        emit(LoadingForecastWeatherState());

        try {
          var resJson = await forecastWeatherApiHelper.getForecastWeatherApi(url: WeatherForecastUrl.getWeatherForecastUrl);
          print("API Response: $resJson");

          if(resJson !=null)
            {
              var mResForecastData = DataWeatherForecastModel.fromJson(resJson);
              emit(LoadedForecastWeatherState(resDataWeatherForecastModel: mResForecastData));
            }
          else
            {
              emit(ErrorForecastWeatherState(errorMsg: "Oh.. No!!, Error Occurred"));
            }
        }
        catch (e) {
          if (e is ForecastWeatherErrorHandling) {
            emit(ErrorForecastWeatherState(errorMsg: e.toErrorMsg()));
          } else {
            emit(ErrorForecastWeatherState(errorMsg: "Unexpected Error: ${e.toString()}"));
          }
        }
      });
    }
  }