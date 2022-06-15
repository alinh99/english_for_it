import 'package:flutter/material.dart';
import 'package:flutter_eft/constants.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key key,
    @required this.question,
    @required this.indexQuestion,
    @required this.totalQuestion,
  }) : super(key: key);
  final String question;
  final int indexQuestion;
  final int totalQuestion;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Question ${indexQuestion + 1}/$totalQuestion: $question',
        style: const TextStyle(
          fontSize: 24.0,
          color: kNeutralAnswerColor,
        ),
      ),
    );
  }
}
