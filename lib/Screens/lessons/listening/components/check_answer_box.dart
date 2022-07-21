import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/lessons/listening/models/lesson.dart';

import 'package:flutter_eft/constants.dart';

class CheckAnswerBox extends StatelessWidget {
  const CheckAnswerBox({Key key, @required this.lessonList}) : super(key: key);
  final List<Lesson> lessonList;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kBackgroundColor,
      title: Text(
        "Answer Key",
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: 300,
        height: 300,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ListView.builder(
              itemCount: lessonList.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                //print(lesson);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${index + 1}. ${lessonList[index].answer.keys.toString().trim().replaceAll('(', '').replaceAll(')', '')}",
                    ),
                    const SizedBox(height: 20)
                  ],
                );
              }),
        ),
      ),
    );
  }
}
