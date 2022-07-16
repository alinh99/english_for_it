import 'package:flutter/widgets.dart';

class Lesson {
  final String subject;
  final String id;
  final String title;
  final String question;
  final Map<String, bool> answer;
  // options will be like - {'1': true, '2': false} = something like this
  Lesson({
    this.id,
    this.title,
    this.question,
    this.answer,
    this.subject,
  });

  @override
  String toString() {
    return 'Lesson(id: $id, title: $title, answer: $answer, subject: $subject)';
  }

  static Lesson fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'],
      title: map['title'],
      answer: Map.castFrom(map['answer']),
      question: map['question'],
      subject: map['subject'],
    );
  }
}
