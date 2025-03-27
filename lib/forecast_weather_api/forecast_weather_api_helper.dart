import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as httpClients;
import 'package:weatherapp/forecast_weather_api/forecast_weather_error_handling/forecast_weather_error_handling.dart';

class ForecastWeatherApiHelper
{
  Future<dynamic>getForecastWeatherApi({required url})
  async{
    var uri = Uri.parse(url);

    try
        {
          var res = await httpClients.get(uri);
          return returnJsonResponse(res);
        }

        on SocketException catch (e)
    {
      throw FetchDataException(errorMsg: "No Internet");
    }

  }

  dynamic returnJsonResponse(httpClients.Response resp)
  {
    switch (resp.statusCode) {
      case 200:
        {
          var mData = jsonDecode(resp.body);
          return mData;
        }
      case 400:
        {
          throw BadRequestException(errorMsg: resp.body.toString());
        }
      case 401:
      case 403:
        {
          throw UnauthorisedException(errorMsg: resp.body.toString());
        }
      case 500:
        default:
          throw(FetchDataException(errorMsg: "Error occurred while communication with Server with Status Code : ${resp.statusCode}"));
    }
  }

}