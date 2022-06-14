import 'package:flutter/material.dart';
import '../../quizz_page/data/quizz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  QuizzBrain quizzBrain = QuizzBrain();
  List<Icon> scoreKeeper = [];
  void checkAnswer(bool userAnswer) {
    setState(
      () {
        bool correctAnswer = quizzBrain.getQuestionAnswer();
        if (quizzBrain.isFinished()) {
          Alert alert = Alert(
            context: context,
            title: "Finished!",
            desc: "You've reached the end of the quiz.",
            buttons: [
              DialogButton(
                child: const Text(
                  "Restart",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                    quizzBrain.reset();
                    scoreKeeper = [];
                  });
                },
                width: 120,
              )
            ],
          );
          alert.show();
        }

        if (userAnswer == correctAnswer) {
          scoreKeeper.add(const Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(const Icon(
            Icons.close,
            color: Colors.red,
          ));
        }

        quizzBrain.nextQuestion();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        IconButton(
          alignment: Alignment.topLeft,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizzBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
