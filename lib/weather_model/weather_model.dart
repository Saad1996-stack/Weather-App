class DataWeatherModel
{
  dynamic base;
  CloudsModel? clouds;
  dynamic cod;
  CoordModel? coord;
  dynamic dt;
  num? id;
  MainTempModel? main;
  String? name;
  SysModel? sys;
  dynamic timezone;
  num? visibility;
  List<ListWeatherModel>? weather;
  WindModel? wind;

  DataWeatherModel({required this.base,
  required this.clouds,
  required this.cod,
  required this.coord,
  required this.dt,
  required this.id,
  required this.main,
  required this.name,
  required this.sys,
  required this.timezone,
  required this.visibility,
  required this.weather,
  required this.wind});

  factory DataWeatherModel.fromJson(Map<String,dynamic>json)
  {
    List<ListWeatherModel>mWeather = [];
    for(Map<String,dynamic>eachWeather in json['weather'])
      {
        mWeather.add(ListWeatherModel.fromJson(eachWeather));
      }

    return DataWeatherModel(
        base: json['base'],
        clouds: CloudsModel.fromJson(json['clouds']),
        cod: json['cod'],
        coord: CoordModel.fromJson(json['coord']),
        dt: json['dt'],
        id: json['dt'],
        main: MainTempModel.fromJson(json['main']),
        name: json['name'],
        sys: SysModel.fromJson(json['sys']),
        timezone: json['timezone'],
        visibility: json['visibility'],
        weather: mWeather,
        wind: WindModel.fromJson(json['wind']),
    );
  }


}

class CoordModel
{
  num? lat;
  num? lon;

  CoordModel({required this.lat, required this.lon});

  factory CoordModel.fromJson(Map<String,dynamic>json)
  {
    return CoordModel(
        lat: json['lat'],
        lon: json['lon'],
    );
  }
}

class ListWeatherModel {
  String? description;
  dynamic icon;
  num? id;
  dynamic main;

  ListWeatherModel(
      {required this.description,
      required this.icon,
      required this.id,
      required this.main});


  factory ListWeatherModel.fromJson(Map<String,dynamic>json)
  {
    return ListWeatherModel(
        description: json['description'],
        icon: json['icon'],
        id: json['id'],
        main: json['main'],
    );
  }

}

class MainTempModel {
  num? feels_like;
  num? grnd_level;
  num? humidity;
  num? pressure;
  num? sea_level;
  num? temp;
  num? temp_max;
  num? temp_min;

  MainTempModel({
    required this.feels_like,
    required this.grnd_level,
    required this.humidity,
    required this.pressure,
    required this.sea_level,
    required this.temp,
    required this.temp_max,
    required this.temp_min,
  });

  factory MainTempModel.fromJson(Map<String, dynamic> json) {
    return MainTempModel(
      feels_like: json['feels_like'],
      grnd_level: json['grnd_level'],
      humidity: json['humidity'],
      pressure: json['humidity'],
      sea_level: json['humidity'],
      temp: json['humidity'],
      temp_max: json['temp_max'],
      temp_min: json['temp_max'],
    );
  }
}

class WindModel {
  num deg;
  num speed;
  num? gust;

  WindModel({required this.deg, required this.speed, required this.gust});

  factory WindModel.fromJson(Map<String, dynamic> json) {
    return WindModel(
      deg: json['deg'],
      speed: json['speed'],
      gust: json['gust'],
    );
  }
}

class CloudsModel{
  num? all;

  CloudsModel({required this.all});

  factory CloudsModel.fromJson(Map<String, dynamic> json) {
    return CloudsModel(
      all: json['all'],
    );
  }
}

class SysModel {
  num? type;
  num? id;
  String? country;
  num? sunrise;
  num? sunset;

  SysModel(
      {required this.type,
      required this.id,
      required this.country,
      required this.sunrise,
      required this.sunset});

  factory SysModel.fromJson(Map<String, dynamic> json) {
    return SysModel(
      type: json['type'],
      id: json['id'],
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}
