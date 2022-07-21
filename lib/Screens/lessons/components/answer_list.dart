import 'package:flutter/material.dart';
import 'package:flutter_eft/constants.dart';

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
