import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/forecast_weather_api/forecast_weather_bloc/forecast_weather_bloc.dart';
import 'package:weatherapp/forecast_weather_api/forecast_weather_bloc/forecast_weather_state.dart';
import 'package:weatherapp/pages/weather_daily_details.dart';
import 'package:weatherapp/weather_api/weather_api_bloc/weather.event.dart';
import 'package:weatherapp/weather_api/weather_api_bloc/weather_bloc.dart';
import 'package:weatherapp/weather_api/weather_api_bloc/weather_state.dart';

import '../forecast_weather_api/forecast_weather_bloc/forecast_weather_event.dart';

class WeatherService extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()=> WeatherSer();
}

class WeatherSer extends State<WeatherService>
{
  DateTime? selectedDayTime;
  DateFormat df = DateFormat("EE, hh:mm a");

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(GetWeatherEvent());
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/wea_service.jpg"),fit: BoxFit.cover
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                        child: BlocBuilder<WeatherBloc, WeatherState>(
                            builder: (context, state){
                              if(state is WeatherLoadingState)
                                {
                                  return Center(child: CircularProgressIndicator(),);
                                }
                              else if(state is WeatherErrorState)
                                {
                                  return Center(child: Text("${state.errorMsg}"),);
                                }
                              else if(state is WeatherLoadedState)
                                {
                                  //selectedDayTime = DateTime.fromMillisecondsSinceEpoch(state.resDataWeather.dt * 1000);
                                  return Text(state.resDataWeather.name!,style: TextStyle(fontWeight: FontWeight.w900,
                                    fontSize: 50,color: Colors.white70,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                    decorationColor: Colors.white70,
                                  ),);
                                } return Center(child: Text("No Data",style: TextStyle(color: Colors.white70),),);
                            }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Icon(Icons.place,size: 50,color: Colors.white70,),
                    ),
                  ],
                ),
                    Text(df.format(selectedDayTime ?? DateTime.now()),style: TextStyle(fontSize: 25,color: Colors.white70, fontWeight: FontWeight.bold),),

               SizedBox(height: 40,),

               BlocBuilder<WeatherBloc, WeatherState>(
                   builder: (context,state){
                     if(state is WeatherLoadingState)
                       {
                         return Center(child: CircularProgressIndicator(),);
                       }
                     else if(state is WeatherErrorState)
                       {
                         return Center(child: Text("${state.errorMsg}"));
                       }
                     else if(state is WeatherLoadedState)
                       {
                         return Column(
                           children: [
                             Text((state.resDataWeather.weather!=null && state.resDataWeather.weather!.isNotEmpty)
                             ? (state.resDataWeather.weather!.first.main ?? "No Data") : "No Data"
                             ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white70),),

                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(state.resDataWeather.main!.temp!.toStringAsFixed(0),style: TextStyle(fontSize: 80,fontWeight: FontWeight.bold,color: Colors.white),),
                                 Text("°C",style: TextStyle(fontSize: 80,fontWeight: FontWeight.bold,color: Colors.white)),
                               ],
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text("Feels like: ${state.resDataWeather.main!.feels_like!.toStringAsFixed(0)}°",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white)),
                                 SizedBox(width: 10,),
                                 Icon(Icons.arrow_upward,size: 40,color: Colors.red,),
                                 Text("${state.resDataWeather.main!.temp_max!.toStringAsFixed(0)}°",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white)),
                                 Icon(Icons.arrow_downward,size: 40,color: Colors.blue,),
                                 Text("${state.resDataWeather.main!.temp_min!.toStringAsFixed(0)}°",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white)),
                               ],
                             ),
                           ],
                         );
                       }
                     return Center(child: Text("No Data",style: TextStyle(fontSize: 20,color: Colors.white70),),);
                   }),
              ],
            ),
          ),
          Positioned(
            left: 360,
              top: 25,
              child: InkWell(
                onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WeatherDailyDetails()));
                  },
                  child: Icon(Icons.arrow_right,size: 50,color: Colors.white,)))
        ],
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 390,
        child: FloatingActionButton(
          onPressed: ()
          {
            context.read<ForecastWeatherBloc>().add(GetForecastWeatherEvent());
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
               /* isDismissible : false,
                enableDrag: false,*/
                builder: (_)
                {
                  return Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFD0DAE0),
                      borderRadius: BorderRadius.circular(21),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 140),
                          child: Text("Forecast",style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900,color: Colors.blue),),
                        ),
                        Divider(),
                        SizedBox(height: 10,),
                        Expanded(
                          child: BlocBuilder<ForecastWeatherBloc, ForecastWeatherState>(
                            builder: (context, state){
                              if(state is LoadingForecastWeatherState)
                              {
                                return Center(child: CircularProgressIndicator(),);
                              }
                              else if(state is ErrorForecastWeatherState)
                              {
                                return Center(child: Text("${state.errorMsg}"),);
                              }
                              else if(state is LoadedForecastWeatherState)
                              {
                                // var mDataModel = state.resDataWeatherForecastModel;

                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                    itemCount: state.resDataWeatherForecastModel.list.length,
                                    itemBuilder: (_, childIndex){
                                      var forecast = state.resDataWeatherForecastModel.list[childIndex];
                                      return Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                             Text(
                                            DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000))
                                             ,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                                            Image.network("https://openweathermap.org/img/wn/${forecast.weather![0].icon}@4x.png",
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),

                                            SizedBox(height: 20,),
                                            
                                            Text(forecast.main!.temp!= null ? "${forecast.main!.temp!.toStringAsFixed(0)}°" : "No temp",style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),),

                                            SizedBox(height: 20,),


                                            Text("${(forecast.pop * 100).toStringAsFixed(1)}%",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)

                                          ],
                                        ),
                                      );
                                    });
                              }
                              return Center(child: Text("No Data",style: TextStyle(fontSize: 30,color: Colors.black, fontWeight: FontWeight.bold),),);
                            },
                          ),
                        )
                      ],
                    ),
                  );
                }
            );
          },
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Text("5 day / 3 hour forecast",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
        ),
      ),
    );
  }
}