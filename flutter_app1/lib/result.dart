import 'package:flutter/material.dart';



class Result extends StatelessWidget {
  final int resultscore;
  final Function resetHandler;

  Result(this.resultscore , this.resetHandler);

  String get resultPhrase{
    var resulttext = 'You did it';
    if(resultscore <= 8)
      {
        resulttext = 'You are awesome and innocent';
      }
    else if(resultscore <=12)
      {
        resulttext = 'Pretty Likeable!';
      }
    else if(resultscore <=16)
      {
        resulttext = 'You are.....STRANGE';
      }
    else
      {
        resulttext = 'Bad you are !';
      }
    return resulttext;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
          resultPhrase,
            style: TextStyle(
              fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(child: Text('Restart Quiz !'),
            textColor: Colors.brown,
            onPressed: resetHandler,)
        ],
      ),
    );
  }
}
