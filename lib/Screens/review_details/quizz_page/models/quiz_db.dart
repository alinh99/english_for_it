import 'dart:convert';
import 'package:http/http.dart' as http;
import './question_model.dart';

class QuizzDB {
  final url = Uri.parse(
      'https://flutter-eft-final-default-rtdb.firebaseio.com/question.json');
  // add question - move to CRUD admin page later
  Future<void> addQuestion(Question question) async {
    http.post(
      url,
      body: json.encode(
        {
          'title': question.title,
          'option': question.options,
        },
      ),
    );
  }

  // fetch data from db
  Future<List<Question>> fetchQuestion() async {
    return http.get(url).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<Question> newQuestions = [];
      data.forEach((key, value) {
        var newQuestion = Question(
          id: key,
          title: value['title'],
          options: Map.castFrom(value['option']),
        );
        newQuestions.add(newQuestion);
      });
      return newQuestions;
    });
  }
}
