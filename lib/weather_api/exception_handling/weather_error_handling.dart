class WeatherErrorHandling implements Exception
{
  String title;
  String msg;

  WeatherErrorHandling({required this.title, required this.msg});

  String toErrorMsg()
  {
    return "$title, $msg";
  }
}

class FetchDataException extends WeatherErrorHandling
{
  FetchDataException({required String errorMsg}) : super(title: "Network Error", msg: errorMsg);
}

class BadRequestException extends WeatherErrorHandling
{
  BadRequestException({required String errorMsg}) : super(title: "Invalid Request", msg: errorMsg);
}

class UnauthorisedException extends WeatherErrorHandling
{
  UnauthorisedException({required String errorMsg}) : super(title: "Unauthorised",msg: errorMsg);
}

class InvalidInputException extends WeatherErrorHandling
{
  InvalidInputException({required String errorMsg}) : super(title: "Invalid Input",msg: errorMsg);
}