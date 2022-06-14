import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_eft/constants.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: kGetStartedButtonColor,
      ),
      child: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "Nunito",
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText("Get Started"),
            ],
            isRepeatingAnimation: true,
            repeatForever: true,
          ),
        ),
      ),
    );
  }
}
