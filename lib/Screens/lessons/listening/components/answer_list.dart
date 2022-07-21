import 'package:flutter/material.dart';

class AnswerList extends StatelessWidget {
  const AnswerList({
    Key key,
    @required this.controller,
  }) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(hintText: 'Input your answer'),
    );
  }
}
