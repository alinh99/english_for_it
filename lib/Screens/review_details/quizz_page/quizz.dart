import 'package:flutter/material.dart';
import 'components/body.dart';

class Quizz extends StatelessWidget {
  static String quizzPage = 'quizz_screen';
  const Quizz({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Body(),
        ),
      ),
    );
  }
}
