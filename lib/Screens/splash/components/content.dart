import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Content extends StatefulWidget {
  final AnimationController controller;

  const Content({Key key, @required this.controller}) : super(key: key);
  @override
  _ContentState createState() => _ContentState();
}

double windowHeight = 0;

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    //windowHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
      ),
      child: Center(
        child: Lottie.asset(
          "assets/images/people.json",
          height: 450,
          controller: widget.controller,
          onLoaded: (composition) {
            widget.controller.duration = composition.duration;
            widget.controller.forward();
          },
          repeat: true,
          animate: true,
        ),
      ),
    );
  }
}
