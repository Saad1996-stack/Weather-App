class ForecastWeatherErrorHandling implements Exception
{
  String? title;
  String? msg;

  ForecastWeatherErrorHandling({required this.title, required this.msg});

  String toErrorMsg()
  {
    return "$title, $msg}";
  }
}

class FetchDataException extends ForecastWeatherErrorHandling
{
  FetchDataException({required String errorMsg})  : super(title: "Network Error", msg: errorMsg);
}

class BadRequestException extends ForecastWeatherErrorHandling
{
  BadRequestException({required String errorMsg}) : super(title: "Invalid Request", msg: errorMsg);
}

class UnauthorisedException extends ForecastWeatherErrorHandling
{
  UnauthorisedException({required String errorMsg}) : super(title: "Unauthorised", msg: errorMsg);
}

class InvalidInputException extends ForecastWeatherErrorHandling
{
  InvalidInputException({required String errorMsg}) : super(title: "Invalid Input", msg: errorMsg);
}