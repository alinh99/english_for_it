import 'package:flutter/widgets.dart';

class Question {
  final String id;
  final String title;
  final Map<String, bool> options;
  // options will be like - {'1': true, '2': false} = something like this

  Question({@required this.id, @required this.title, @required this.options});

  // override toString method to print the question to console
  @override
  String toString() {
    return 'Question(id: $id, title: $title, options: $options)';
  }
}
