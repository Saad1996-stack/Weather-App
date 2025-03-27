class DataWeatherForecastModel {
  CityModel? city;
  dynamic cnt;
  dynamic cod;
  dynamic message;
  List<ForecastModel> list;

  DataWeatherForecastModel(
      {required this.city,
      required this.cnt,
      required this.cod,
      required this.message,
      required this.list});

  factory DataWeatherForecastModel.fromJson(Map<String,dynamic>json)
  {
    List<ForecastModel>mForecastModel = [];

    for(Map<String,dynamic>eachWeatherForecast in json['list'])
      {
        mForecastModel.add(ForecastModel.fromJson(eachWeatherForecast));
      }

    return DataWeatherForecastModel(
        city: CityModel.fromJson(json['city']),
        cnt: json['cnt'],
        cod: json['cod'],
        message: json['message'],
        list: mForecastModel,
    );
  }

}

class ForecastModel {
  CloudsModel? clouds;
  dynamic dt;
  dynamic dt_txt;
  MainModel? main;
  num pop;
  /*RainModel rain;*/
  SysModel? sys;
  dynamic visibility;
  List<ListsOfWeather>? weather;
  WindModel? wind;

  ForecastModel({
    required this.clouds,
    required this.dt,
    required this.dt_txt,
    required this.main,
    required this.pop,
   /* required this.rain,*/
    required this.sys,
    required this.visibility,
    required this.weather,
    required this.wind,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    List<ListsOfWeather> fWeather = [];
    for (Map<String, dynamic> eachForecastWeather in json['weather']) {
      fWeather.add(ListsOfWeather.fromJson(eachForecastWeather));
    }

    return ForecastModel(
      clouds: CloudsModel.fromJson(json['clouds']),
      dt: json['dt'],
      dt_txt: json['dt_txt'],
      main: MainModel.fromJson(json['main']),
      pop: json['pop'],
      /*rain: json['rain'],*/
      sys: SysModel.fromJson(json['sys']),
      visibility: json['visibility'],
      weather: fWeather,
      wind: WindModel.fromJson(json['wind']),
    );
  }
}

class MainModel {
  num? feels_like;
  num? grnd_level;
  num? humidity;
  num? pressure;
  num? sea_level;
  num? temp;
  num? temp_kf;
  num? temp_max;
  num? temp_min;

  MainModel({
    required this.feels_like,
    required this.grnd_level,
    required this.humidity,
    required this.pressure,
    required this.sea_level,
    required this.temp,
    required this.temp_kf,
    required this.temp_max,
    required this.temp_min,
  });

  factory MainModel.fromJson(Map<String, dynamic> json) {
    return MainModel(
      feels_like: json['feels_like'],
      grnd_level: json['grnd_level'],
      humidity: json['humidity'],
      pressure: json['pressure'],
      sea_level: json['sea_level'],
      temp: json['temp'],
      temp_kf: json['temp_kf'],
      temp_max: json['temp_max'],
      temp_min: json['temp_min'],
    );
  }
}

class ListsOfWeather {
  String? description;
  dynamic icon;
  num? id;
  String? main;

  ListsOfWeather(
      {required this.description,
      required this.icon,
      required this.id,
      required this.main});

  factory ListsOfWeather.fromJson(Map<String, dynamic> json) {
    return ListsOfWeather(
      description: json['description'],
      icon: json['icon'],
      id: json['id'],
      main: json['main'],
    );
  }
}

class CloudsModel {
  dynamic all;

  CloudsModel({required this.all});

  factory CloudsModel.fromJson(Map<String, dynamic> json) {
    return CloudsModel(
      all: json['all'],
    );
  }
}

class WindModel {
  num? deg;
  num? gust;
  num? speed;

  WindModel({required this.deg, required this.gust, required this.speed});

  factory WindModel.fromJson(Map<String, dynamic> json) {
    return WindModel(
      deg: json['deg'],
      gust: json['gust'],
      speed: json['speed'],
    );
  }
}

/*class RainModel
{
  dynamic threeH;

  RainModel({required this.threeH});

  factory RainModel.fromJson(Map<String,dynamic>json)
  {
    return RainModel(
      threeH: json['rain'],
    );
  }

}*/

class SysModel {
  dynamic pod;

  SysModel({required this.pod});

  factory SysModel.fromJson(Map<String, dynamic> json) {
    return SysModel(
      pod: json['pod'],
    );
  }
}

class CityModel {
  CoordModel? coord;
  String? country;
  num? id;
  String? name;
  num? population;
  dynamic sunrise;
  dynamic sunset;
  dynamic timezone;

  CityModel({
    required this.coord,
    required this.country,
    required this.id,
    required this.name,
    required this.population,
    required this.sunrise,
    required this.sunset,
    required this.timezone,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      coord: CoordModel.fromJson(json['coord']),
      country: json['country'],
      id: json['id'],
      name: json['name'],
      population: json['population'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      timezone: json['timezone'],
    );
  }
}

class CoordModel {
  num? lat;
  num? lon;

  CoordModel({required this.lat, required this.lon});

  factory CoordModel.fromJson(Map<String, dynamic> json) {
    return CoordModel(
      lat: json['lat'],
      lon: json['lon'],
    );
  }
}
