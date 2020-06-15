

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override   // overriding th stateless widget to custom widget ,for ur convience
  Widget build(BuildContext context) {
    return MaterialApp(
       home: new LoginPage(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
      )
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
 }
 class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{   // provides single animation
  AnimationController _iconAnimationController;
  Animation<double>  _iconAnimation;

  @override
  void initState() {
    super.initState();                      // for flutter logo
    _iconAnimationController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 500)
    );
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.bounceOut
    );
    _iconAnimation.addListener(()=> this.setState((){}));
    _iconAnimationController.forward();
  }
   @override // overriding th stateless widget to custom widget ,for ur convience
   Widget build(BuildContext context) {
     return new Scaffold(
       backgroundColor: Colors.greenAccent,
       body: new Stack(
         fit: StackFit.expand,
         children: <Widget>[
           new Image(
               image:  new NetworkImage('https://i.pinimg.com/originals/4c/1d/bd/4c1dbdc7d062dd11cd5b8bf5bbd25d61.jpg'),
             fit: BoxFit.cover,
             color: Colors.black87,
             colorBlendMode: BlendMode.darken,
           ),
           new Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               new FlutterLogo(
                 size:_iconAnimation.value * 100,
               ),
               new Form(

                 child: new Theme(
                   data: new ThemeData(
                     brightness: Brightness.dark,primarySwatch: Colors.teal,
                       inputDecorationTheme: new InputDecorationTheme(
                         labelStyle: new TextStyle(
                           color: Colors.teal,fontSize: 20.0
                         )
                       )
                   ),
                   child: new Container(
                     padding:const EdgeInsets.all(60.0),
                     child: new Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[
                          new TextFormField(   // for email
                           decoration: new InputDecoration(
                             labelText: "Enter Email",
                           ),
                           keyboardType: TextInputType.emailAddress,
                         ),
                         new TextFormField(    //for password
                           decoration: new InputDecoration(
                             labelText: "Enter Password",
                           ),
                           keyboardType: TextInputType.text,
                           obscureText: true,  // by not showing the text
                         ),
                         new Padding(
                           padding: const EdgeInsets.only(top:40.0),
                         ),
                         new MaterialButton(
                           height: 40.0,
                           minWidth: 100.0,
                           color: Colors.teal,
                           textColor: Colors.white,
                           child: new Text("Login"), //Text
                           onPressed: ()=>{} ,
                           splashColor: Colors.redAccent,
                         ),
                       ],
                     ),
                   ),
                 )
               )
             ],
           )
         ]
       ),
     );
   }
 }





