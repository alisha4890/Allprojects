
import 'dart:convert';
import 'package:flutter/material.dart';

void main()  => runApp(new MaterialApp(
  theme: new ThemeData(
    primarySwatch:Colors.amber
  ),
  home: new HomePage(),
));



class HomePage extends StatefulWidget{

  @override
  HomePageState createState()=> new HomePageState();

}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      appBar: new AppBar(
      title: new Text("Load Json App"),
      ),

      body: new Container(
        child: new Center(
          child: new FutureBuilder(
            future: DefaultAssetBundle.of(context).loadString('load_json/person.json'),
            builder: (context ,snapshot) {
              //Decode json
              var mydata = JSON.decode(snapshot.data.toString());
              return
            }
          ),
        ),
      ),
    );
  }
}