import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/lessons/components/body.dart';

class Lesson extends StatefulWidget {
  const Lesson({Key key}) : super(key: key);

  @override
  _LessonState createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(size: size),
    );
  }
}
