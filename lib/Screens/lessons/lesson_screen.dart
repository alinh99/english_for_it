import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/lessons/components/body.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({Key key}) : super(key: key);

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(size: size),
    );
  }
}
