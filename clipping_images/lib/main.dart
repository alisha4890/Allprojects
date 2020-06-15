
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return new Scaffold(
      body: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
          child: new ClipPath(
            child: new Image.network(
            "https://images.unsplash.com/photo-1591225757875-f82526401ec3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"
            ),
            clipper: new MyClipper(),
        ),
      ),
      ),
    );

  }
}

  class MyClipper extends CustomClipper<Path>{
    @override
    Path getClip(Size size) {
      // TODO: implement getClip
       var path = new Path();

                                           //RECTANGLUAR   AND DIAGONAL CUT
  //     path.lineTo(size.width, 0.0);
  //     path.close();
//      path.lineTo(0.0, size.height);
//      path.lineTo(size.width,0.0);
//      path.close();
//      path.moveTo(size.width, 0.0);
//      path.lineTo(size.width, size.height);
//      path.lineTo(0.0,size.height);
//      path.close();

                                            //BENZIER CURVE : --
      path.lineTo(0.0, size.height);


      var firstControlPoint = new Offset(size.width / 4,size.height );
      var firstEndPoint =new Offset(size.width / 2.25, size.height - 30.0);
      path.quadraticBezierTo( firstControlPoint.dx , firstControlPoint.dy,firstEndPoint.dx , firstEndPoint.dy );  //4 paramters : control points and end points

      var secondEndPoint =new Offset(size.width -(size.width /3.25), size.height - 65);
      var secondControlPoint = new Offset(size.width ,size.height - 40);
      path.quadraticBezierTo(secondControlPoint.dx , secondControlPoint.dy,secondEndPoint.dx , secondEndPoint.dy , );


      path.lineTo(size.width , size.height - 40);
      path.lineTo(size.width, 0.0);
      path.close();
      return path;
    }
    @override
    bool shouldReclip(CustomClipper<Path> oldClipper) => false;
  }