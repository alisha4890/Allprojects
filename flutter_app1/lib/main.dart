import 'package:flutter/material.dart';
import 'package:flutterapp1/result.dart';

import './quiz.dart';
import './result.dart';

void main() =>runApp(MyApp());

  class MyApp extends StatefulWidget {

    @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
    }
  }
  class _MyAppState extends State<MyApp> {
    final _questions = const [
      {
        'questionText': 'What\'s you favorite color?', // USING MAPS
        'answers': [
          {'text': 'Black', 'score': 10},
          {'text': 'Red', 'score': 5},
          {'text': 'Green', 'score': 3},
          {'text': 'White', 'score': 1}
          ],
      },
      {
        'questionText':  'What\'s you favorite animal?',
        'answers': [
          {'text': 'Dog', 'score': 10},
          {'text': 'Rabbit', 'score': 5},
          {'text': 'Lion', 'score': 3},
          {'text': 'Cat', 'score': 1}
        ],
      },
      {
        'questionText': 'Who\'s your bestfrd ?',
        'answers': [
          {'text': 'Bharti', 'score': 10},
          {'text': 'Rose', 'score': 5},
          {'text': 'Garima', 'score': 3},
          {'text': 'Winni', 'score': 1}
            ],
      }

    ];
    var _quesIndex = 0;
    var _totalscore = 0;
    void _resetQuiz() {
      setState(() {
        _quesIndex = 0;
        _totalscore = 0;
      });
    }
    void _ansQuestion(int score) {
      //var aBool = true;
      // aBool= false;
      _totalscore = _totalscore + score;
      if(_quesIndex < _questions.length)
        {
          print('We havr more questions!');
        }
      else
        {
          print('No more questions');
        }
      setState(() {
        _quesIndex = _quesIndex + 1;
      });
      print(_quesIndex);
    }
  @override
  Widget build(BuildContext context){


      return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("My First App"),),
            body: _quesIndex < _questions.length
                ? Quiz(
              ansQuestion: _ansQuestion ,
              quesIndex: _quesIndex,
              questions: _questions,
            )
                : Result(_totalscore, _resetQuiz),
        ),

      );
    }
  }

