import 'package:flutter/material.dart';
import 'package:flutter_eft/colors.dart';
import 'package:flutter_eft/Screens/review_details/quizz_page/components/next_button.dart';
import 'package:flutter_eft/Screens/review_details/quizz_page/components/option_card.dart';
import 'package:flutter_eft/Screens/review_details/quizz_page/components/question_widget.dart';
import 'package:flutter_eft/Screens/review_details/quizz_page/components/result_box.dart';
import 'package:flutter_eft/Screens/review_details/quizz_page/models/question_model.dart';
import 'package:flutter_eft/constants.dart';
import 'models/db_connect.dart';

class QuizzScreen extends StatefulWidget {
  static String quizzPage = 'quizz_screen';
  const QuizzScreen({Key key}) : super(key: key);
  @override
  _QuizzScreenState createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  // final List<Question> _questions = [
  //   Question(
  //     id: '10',
  //     title: 'What is 2 + 2?',
  //     options: {'5': false, '30': false, '4': true, '10': false},
  //   ),
  //   Question(
  //     id: '11',
  //     title: 'What is 10 + 20?',
  //     options: {'50': false, '30': true, '40': false, '10': false},
  //   )
  // ];
  var db = DBConnect();
  Future _questions;

  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isSelected = false;

  Future<List<Question>> getData() async {
    return db.fetchQuestion();
  }

  @override
  void initState() {
    _questions = getData();
    super.initState();
  }

  // create a function to display next question
  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isSelected = false;
    });
    Navigator.pop(context);
  }

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
        context: context,
        barrierDismissible:
            false, // disable dismiss function on clicking outside of box
        builder: (ctx) => ResultBox(
          result: score,
          questionLength: questionLength,
          press: startOver,
        ),
      );
    } else {
      if (isPressed) {
        setState(
          () {
            index++;
            isPressed = false;
            isSelected = false;
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select any option'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(vertical: 20),
          ),
        );
      }
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isSelected) {
      return;
    } else {
      if (value) {
        score++;
      }
      setState(
        () {
          isPressed = true;
          isSelected = true;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Question>;
            return Scaffold(
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(extractedData.length),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: NextButton(),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  color: AppColors.red,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back),
                            alignment: Alignment.center,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Text(
                              "Score: $score",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  color: kNeutralAnswerColor, fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                      QuestionWidget(
                        question: extractedData[index].title, // currently at 0
                        indexQuestion: index, // means the first qs in the list
                        totalQuestion:
                            extractedData.length, // total length of the list
                      ),
                      const Divider(
                        color: kNeutralAnswerColor,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      for (int i = 0;
                          i < extractedData[index].options.length;
                          i++)
                        GestureDetector(
                          onTap: () => checkAnswerAndUpdate(
                              extractedData[index].options.values.toList()[i]),
                          child: OptionCard(
                            option:
                                extractedData[index].options.keys.toList()[i],
                            colour: isPressed
                                ? extractedData[index]
                                            .options
                                            .values
                                            .toList()[i] ==
                                        true
                                    ? kCorrectAnswerColor
                                    : kIncorrectAnswerColor
                                : AppColors.pink,
                            //press: changeColor,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const SafeArea(
              child: Center(
                child: Text(
                  "No Data",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kNeutralAnswerColor,
                    decoration: TextDecoration.none,
                    fontSize: 14.0,
                  ),
                ),
              ),
            );
          }
        }
        return SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Please Wait while Questions are loading..",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kNeutralAnswerColor,
                    decoration: TextDecoration.none,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
