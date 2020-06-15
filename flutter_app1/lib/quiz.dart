import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';
class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int quesIndex;
  final Function ansQuestion;

  Quiz({
    @required this.questions,
    @required this.ansQuestion,
    @required this.quesIndex});

  @override
  Widget build(BuildContext context) {
    return Column(            //TERNARY STMT IN quesIndex
        children:[
          Question(questions[quesIndex]['questionText'],
          ),
          ...(questions[quesIndex]['answers'] as List<Map<String, Object>>).map((answer) {
            return Answers(() => ansQuestion(answer['score']), answer['text']);
          }).toList()
        ],
    );
  }
}
