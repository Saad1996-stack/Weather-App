import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/weather_api/exception_handling/weather_error_handling.dart';
import 'package:weatherapp/weather_api/weather_api_bloc/weather.event.dart';
import 'package:weatherapp/weather_api/weather_api_bloc/weather_state.dart';
import 'package:weatherapp/weather_model/weather_model.dart';
import 'package:weatherapp/weather_url/weather_url.dart';

import '../weather_api_helper.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>
{
  WeatherApiHelper WeatherApiHelp;
  WeatherBloc({required this.WeatherApiHelp}) : super(WeatherInitialState())

  {
    on<GetWeatherEvent>((event, emit)async{
      emit(WeatherLoadingState());

      try
          {
            var resJson = await WeatherApiHelp.getWeatherApi(url: WeatherUrl.getWetherUrl);
            if(resJson !=null)
              {
                var mResWeatherData = DataWeatherModel.fromJson(resJson);
                emit(WeatherLoadedState(resDataWeather: mResWeatherData));
              }
            else
              {
                emit(WeatherErrorState(errorMsg: "oh.. No!!, Error Occurred"));
              }
          }
          catch (e)
      {
        emit(WeatherErrorState(errorMsg: (e as WeatherErrorHandling).toErrorMsg()));
      }
    });
  }

}