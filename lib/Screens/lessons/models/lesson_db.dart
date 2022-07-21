import 'package:flutter_eft/Screens/lessons/models/lesson.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LessonDB {
  final url = Uri.parse(
      'https://flutter-eft-final-default-rtdb.firebaseio.com/lesson.json');
  Future<void> addLesson(Lesson lesson) async {
    http.post(
      url,
      body: json.encode(
        {
          'subject': lesson.subject,
          'title': lesson.title,
          'question': lesson.question,
          'answer': lesson.answer,
        },
      ),
    );
  }

  // fetch data from db
  Future<List<Lesson>> fetchLessonDB() async {
    return http.get(url).then((response) {
      var data = json.decode(response.body) as Map<dynamic, dynamic>;
      List<Lesson> newLesson = [];
      data.forEach((key, value) {
        var newQuestion = Lesson(
          id: key,
          title: value['title'],
          answer: Map.castFrom(value['answer']),
          subject: value['subject'],
          question: value['question'],
        );
        newLesson.add(newQuestion);
      });
      //print(response.body);
      return newLesson;
    });
  }
}
