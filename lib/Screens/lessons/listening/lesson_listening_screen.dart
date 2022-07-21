import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/lessons/listening/components/body.dart';

class LessonListeningScreen extends StatefulWidget {
  const LessonListeningScreen({Key key}) : super(key: key);

  @override
  _LessonListeningScreenState createState() => _LessonListeningScreenState();
}

class _LessonListeningScreenState extends State<LessonListeningScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Body(size: size),
    );
  }
}
