import 'package:flutter/material.dart';
import 'package:flutter_eft/constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox(
      {Key key,
      @required this.result,
      @required this.questionLength,
      @required this.press})
      : super(key: key);
  final int result;
  final int questionLength;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kBackgroundColor,
      content: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Result",
              style: TextStyle(
                color: kNeutralAnswerColor,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 20.0),
            CircleAvatar(
              child: Text(
                "$result/$questionLength",
                style: const TextStyle(fontSize: 30.0),
              ),
              radius: 70.0,
              backgroundColor: result == questionLength / 2
                  ? Colors.yellow
                  : result < questionLength / 2
                      ? kIncorrectAnswerColor
                      : kCorrectAnswerColor,
            ),
            const SizedBox(height: 20.0),
            Text(
              result == questionLength / 2
                  ? 'Almost There'
                  : result < questionLength / 2
                      ? 'Try Again ?'
                      : 'Great!',
              style: const TextStyle(
                color: kNeutralAnswerColor,
              ),
            ),
            const SizedBox(height: 25.0),
            GestureDetector(
              onTap: press,
              child: Text(
                "Start Over",
                style: TextStyle(
                  color: Colors.red[900],
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
