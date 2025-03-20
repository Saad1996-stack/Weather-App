import 'package:flutter/material.dart';

class WeatherService extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()=> WeatherSer();
}

class WeatherSer extends State<WeatherService>
{

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Container(
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
                    child: Text("Berlin",style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 50,color: Colors.white70,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                      decorationColor: Colors.white70,
                    ),)),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Icon(Icons.place,size: 50,color: Colors.white70,),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 390,
        child: FloatingActionButton(
          onPressed: ()
          {
            showModalBottomSheet(
                context: context,
                builder: (_)
                {
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("5 day / 3 hour forecast",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Divider(),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (_,index){
                              return Text("Khan");
                            }),
                        )
                      ],
                    ),
                  );
                }
            );
          },
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Text("5 day / 3 hour forecast",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white70),),
        ),
      ),
    );
  }
}