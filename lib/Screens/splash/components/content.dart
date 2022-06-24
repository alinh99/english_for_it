import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Content extends StatefulWidget {
  final AnimationController controller;
  final double windowHeight;
  const Content(
      {Key key, @required this.controller, @required this.windowHeight})
      : super(key: key);
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        "assets/images/people.json",
        height: widget.windowHeight,
        controller: widget.controller,
        onLoaded: (composition) {
          widget.controller.duration = composition.duration;
          widget.controller.forward();
        },
        repeat: true,
        animate: true,
      ),
    );
  }
}
