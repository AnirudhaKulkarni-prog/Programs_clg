import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
main()
{
  runApp(MaterialApp(
    home:MyApp(),));
}
class MyApp  extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {

  var webdata;
  var cmd;

  web (cmd)
  async {
    var url="http://192.168.43.169/cgi-enabled/first.py?x=${cmd}";
    var r=await http.get(url);
    setState(() {
    webdata=r.body;
    });
      
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:Drawer(
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Text('Drawer Header'),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
      ListTile(
        title: Text('Item 1'),
        onTap: () {
          // Update the state of the app.
          // ...
         Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Weather()),
          );
                  },
      )
                
          ,
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
          
                  appBar:AppBar(title:Text("Docker Command Processor")) ,
                  body: Center(
                    child: Container(
                      width:300 ,
                      height: 300,
                      color:Colors.red ,
                      child:Column(
                        
                        children: <Widget>[
                          Card(
                            
                            child:TextField(
                              onChanged: (value) => {
                                cmd=value
                              },
                              decoration: InputDecoration(
                                hintText:"Enter the Command",
                                prefixIcon: Icon(Icons.style)
                              ),
                              
          
                            )
                          ),
                          Card(
                            child:TextField(
          
                            )
                          ),
                          Card(
                            child:FlatButton(onPressed:(){
                                  web(cmd);
                                  
                            } , 
                            child:Text("Press Me")),),
                            Text(webdata ?? "Winter is Coming"),
                        ],
                        
                      )  ,
                      
          
          
                    ),
                  ),);
              
                
              
            }
          }

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  var city;
  var webdata;
  web(city)
  async {
    var url="https://samples.openweathermap.org/data/2.5/weather?q=${city}&appid=74d6009109fb04cf21744b2e28c39f13";
    var r=await http.get(url);
    setState(() {
    var wdata=r.body;
    webdata=jsonDecode(wdata);
    print(webdata.runtimeType);
    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(appBar: AppBar(title:Text("This is weather report")),
      body: Center(
        child: Container(
          height:MediaQuery.of(context).size.height*0.6,
          width:MediaQuery.of(context).size.width*0.5,
          color: Colors.transparent,
          child:Column(
            children: <Widget>[
              TextField(
                onChanged:(value) {
                    city=value;
                },
              decoration: InputDecoration(
                hintText:"Enter the city name",

              ),),
              FlatButton(onPressed:(){
                web(city);
                print(webdata["main"]??"Wait...");
              } , 
              child: Text("Click Me")),
               Text(webdata["main"]??"wait for it..."),
            ],
          
            
          )
        ),
      ),),);
  }
}
