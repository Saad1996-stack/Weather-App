  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:intl/intl.dart';
  import 'package:weatherapp/weather_api/weather_api_bloc/weather_bloc.dart';
  import 'package:weatherapp/weather_api/weather_api_bloc/weather_state.dart';

  import '../forecast_weather_api/forecast_weather_bloc/forecast_weather_bloc.dart';
  import '../forecast_weather_api/forecast_weather_bloc/forecast_weather_event.dart';
  import '../forecast_weather_api/forecast_weather_bloc/forecast_weather_state.dart';
  import '../weather_api/weather_api_bloc/weather.event.dart';

  class WeatherDailyDetails extends StatefulWidget {

    @override
    State<WeatherDailyDetails> createState() => DetailedWeatherView();
  }

  class DetailedWeatherView extends State<WeatherDailyDetails> {

    @override
    void initState() {
      super.initState();
      context.read<ForecastWeatherBloc>().add(GetForecastWeatherEvent());
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Daily Details",style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<ForecastWeatherBloc,ForecastWeatherState>(
                builder: (context,state){
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
                      Set<String> uniqueDays = {};
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.resDataWeatherForecastModel.list.length,
                            itemBuilder: (_,index) {
                              var weatherDetails = state.resDataWeatherForecastModel.list[index];

                              DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(weatherDetails.dt * 1000);

                              String formattedDate = DateFormat('M/d').format(dateTime); // Unique day format

                              if (!uniqueDays.contains(formattedDate)) {
                                uniqueDays.add(formattedDate);

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        DateFormat('E').format(dateTime),
                                        style: TextStyle(
                                            fontSize: 24, fontWeight: FontWeight.bold),
                                      ),
                                      //SizedBox(height: 5,),

                                      Text(
                                        formattedDate, // "3/26"
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              else {
                                return SizedBox.shrink();
                              }
                            }
                        ),
                      );
                    }
                  return Center(child: Text("No Data",style: TextStyle(fontSize: 20,color: Colors.white70),),);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: Container(
                  height: 650,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    //color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: BlocBuilder<ForecastWeatherBloc,ForecastWeatherState>(
                    builder: (context, state)
                    {
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
                      ///check if list is empty
                      if(state.resDataWeatherForecastModel.list.isEmpty)
                        {
                          return Center(child: Text("No Data", style: TextStyle(fontSize: 20,)));
                        }

                      String time_of_day = "";
                      if(state.resDataWeatherForecastModel.list[0].sys!.pod == 'd')
                      {
                        time_of_day = "Day";
                      }
                      else
                      {
                        time_of_day = "Night";
                      }
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Container(
                              height: 30,
                              width: 90,
                              decoration: BoxDecoration(
                                color: Color(0xFFE2F1F8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                                child: Center(child: Text(time_of_day,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if(state.resDataWeatherForecastModel.list[0].weather![0].icon.isNotEmpty)
                                Image.network("https://openweathermap.org/img/wn/${state.resDataWeatherForecastModel.list[0].weather![0].icon}@2x.png"),

                                if(state.resDataWeatherForecastModel.list[0].main!.temp !=null)
                                Text("${state.resDataWeatherForecastModel.list[0].main!.temp!.toStringAsFixed(0)}°C",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),

                                Icon(Icons.arrow_upward,size: 30,color: Colors.red,),
                              ],
                            ),
                            Text(state.resDataWeatherForecastModel.list[0].weather![0].description.toString(),style: TextStyle(fontSize: 25),),

                            ListTile(
                              leading:Icon(Icons.thermostat,size: 35,),
                              title:Text("Feels like",style: TextStyle(color: Colors.grey,fontSize: 22),),
                              trailing:
                              Text(state.resDataWeatherForecastModel.list[0].main!.feels_like!.toStringAsFixed(0),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                            ),

                            SizedBox(
                              width: 370,
                                child: Divider()),

                            ListTile(
                              leading:  Icon(Icons.air,size: 35,),
                              title:  Text("Wind",style: TextStyle(color: Colors.grey,fontSize: 22),),
                              trailing:Text(state.resDataWeatherForecastModel.list[0].wind!.speed!.toStringAsFixed(0),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                            ),
                            SizedBox(
                                width: 370,
                                child: Divider()),

                            ListTile(
                              leading:  Icon(Icons.ac_unit,size: 35,),
                              title:  Text("Wind Gust",style: TextStyle(color: Colors.grey,fontSize: 22),),
                              trailing: Text(state.resDataWeatherForecastModel.list[0].wind!.gust!.toStringAsFixed(0),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                            ),
                            SizedBox(
                                width: 370,
                                child: Divider()),

                            ListTile(
                              leading: Icon(Icons.grain,size: 35,),
                              title:Text("Precipitation",style: TextStyle(color: Colors.grey,fontSize: 22),),
                              trailing:Text(state.resDataWeatherForecastModel.list[0].wind!.deg!.toStringAsFixed(0),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                            ),

                            SizedBox(
                                width: 370,
                                child: Divider()),

                            ListTile(
                              leading:Icon(Icons.cloud,size: 35,),
                              title:Text("Cloud Cover",style: TextStyle(color: Colors.grey,fontSize: 22),),
                              trailing:Text(state.resDataWeatherForecastModel.list[0].clouds!.all.toStringAsFixed(0),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                            ),
                          ],
                        ),
                      );
                    }
                      return Center(child: Text("No Data",style: TextStyle(fontSize: 20,color: Colors.white70),),);
                    },
                  )
                ),
              ),
            ),

          ],
        )
      );
    }
  }
