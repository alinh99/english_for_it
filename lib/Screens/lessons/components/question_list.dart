import 'package:flutter/material.dart';

class QuestionList extends StatelessWidget {
  // const QuestionList({
  //   Key key,
  //   this.index,
  //   this.question
  // }) : super(key: key);
  const QuestionList({Key key, this.index, this.question}) : super(key: key);
  final int index;
  final String question;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        title: Text(
          '${index + 1}. $question',
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
