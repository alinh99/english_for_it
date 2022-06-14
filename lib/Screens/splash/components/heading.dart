import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Heading extends StatelessWidget {
  const Heading({
    Key key,
    @required Color headingColor,
    @required double headingTop,
  })  : _headingColor = headingColor, _headingTop = headingTop,
        super(key: key);

  final Color _headingColor;
  final double _headingTop;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(
            milliseconds: 1000,
          ),
          margin: EdgeInsets.only(
            top: _headingTop,
          ),
          child: Center(
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 24,
                color: _headingColor,
                fontFamily: "Nunito",
              ),
              textAlign: TextAlign.center,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText("Learn Free"),
                ],
                repeatForever: true,
                isRepeatingAnimation: true,
              ),
            ),
          ),
        ),
        Center(
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 16,
              color: _headingColor,
              fontFamily: "Nunito",
            ),
            textAlign: TextAlign.center,
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                    "Join EFT app to learn English for IT for free.")
              ],
              repeatForever: true,
            ),
          ),
        ),
      ],
    );
  }
}
