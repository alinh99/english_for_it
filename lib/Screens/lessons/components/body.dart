import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/lessons/components/answer_list.dart';
import 'package:flutter_eft/Screens/lessons/components/result_box.dart';
import 'package:flutter_eft/Screens/lessons/models/lesson.dart';
import 'package:flutter_eft/Screens/lessons/models/lesson_db.dart';
import 'package:flutter_eft/Screens/lessons/components/next_button.dart';
import 'package:flutter_eft/colors.dart';
import 'package:flutter_eft/Screens/lessons/components/question_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_eft/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:audioplayers/audioplayers.dart';

class Body extends StatefulWidget {
  const Body({Key key, @required this.size}) : super(key: key);
  final Size size;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  AudioPlayer audioPlayer = AudioPlayer();
  List<TextEditingController> userAnswerTypes = [];
  //TextEditingController answerController = TextEditingController();
  bool isPlayed = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  LessonDB db = LessonDB();
  DatabaseReference lessonRef;

  int score = 0;
  bool isPressed = false;
  bool isSelected = false;
  bool isCorrected = false;
  bool isSummited = false;
  Icon icon;
  List<Lesson> lessons = [];
  List<String> userAnswerList = [];
  List<String> realAnswerList = [];
  Future _lessons;
  Future<List<Lesson>> getData() async {
    return db.fetchLessonDB();
  }

  checkAnswer(int i) {
    userAnswerList.insert(i, "(${userAnswerTypes[i].text})");
    realAnswerList.add(lessons[i].answer.keys.toString());
    setState(() {
      isSummited = true;
      realAnswerList[i] = lessons[i].answer.keys.toString();
    });

    //
    print(i);
    if (userAnswerList.isEmpty) {
      score += 0;
      return false;
    } else {
      if (userAnswerList[i].toString().toLowerCase() ==
          lessons[i].answer.keys.toString()) {
        score += 1;
        return true;
      } else {
        score += 0;
        return false;
      }
    }
  }

  void startOver() {
    setState(() {
      score = 0;
      userAnswerTypes.clear();
      isSummited = false;
    });
    Navigator.pop(context);
  }

  void nextQuestion(int questionLength) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // disable dismiss function on clicking outside of box
      builder: (ctx) => ResultBox(
        result: score,
        questionLength: questionLength,
        resetPress: startOver,
        checkAnswerPress: () {},
        nextExercisePress: () {},
      ),
    );
  }

  @override
  void initState() {
    // Listen to States: Playing, Pause, Stop
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlayed = event == PlayerState.PLAYING;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    _lessons = getData();
    super.initState();
  }

  @override
  void dispose() {
    for (TextEditingController userAnswerType in userAnswerTypes) {
      userAnswerType.dispose();
    }
    super.dispose();
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    final player = AudioCache(prefix: 'assets/database/');
    final url = await player.load('unit1task3.mp3');
    audioPlayer.play(url.path, isLocal: true);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/database/less_back_ver2.png"),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(AppColors.demo2, BlendMode.modulate),
              ),
            ),
            width: double.infinity,
            height: widget.size.height * 0.8,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("assets/images/back_icon.svg"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SvgPicture.asset("assets/images/heart_icon.svg"),
                        const SizedBox(
                          width: 20,
                        ),
                        SvgPicture.asset("assets/images/share_icon.svg"),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Column(
                      children: [
                        Slider(
                          thumbColor: Colors.red,
                          inactiveColor: AppColors.pink,
                          min: 0,
                          onChanged: (double value) async {
                            final position = Duration(seconds: value.toInt());
                            await audioPlayer.seek(position);
                          },
                          value: position.inSeconds.toDouble(),
                          max: duration.inSeconds.toDouble(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formatTime(position),
                              ),
                              Text(
                                formatTime(duration),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 25,
                          child: IconButton(
                            onPressed: () async {
                              if (isPlayed) {
                                await audioPlayer.pause();
                              } else {
                                await setAudio();
                              }
                            },
                            icon:
                                Icon(isPlayed ? Icons.pause : Icons.play_arrow),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: widget.size.height * 0.4),
            width: double.infinity,
            decoration: const BoxDecoration(
              //color: AppColors.pink,
              image: DecorationImage(
                image: AssetImage("assets/database/less_v2.png"),
                fit: BoxFit.fill,
                colorFilter:
                    ColorFilter.mode(AppColors.demo, BlendMode.modulate),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    child: Container(
                      width: 150,
                      height: 7,
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: _lessons as Future<List<Lesson>>,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done ||
                          snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          var extractedData = snapshot.data as List<Lesson>;
                          for (var i in extractedData) {
                            lessons.add(i);
                          }
                          //print(lessons.length);
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ListView.builder(
                              itemCount: extractedData.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                //userAnswerType.add(TextEditingController());
                                userAnswerTypes.add(TextEditingController());
                                realAnswerList.add(extractedData[index]
                                    .answer
                                    .keys
                                    .toString());
                                return Column(
                                  children: [
                                    Text(
                                      extractedData[index].title,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        height: 1.5,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    QuestionList(
                                      index: index,
                                      question: extractedData[index].question,
                                    ),
                                    AnswerList(
                                      controller: userAnswerTypes[index],
                                    ),
                                    // isSummited == false
                                    //     ? Text("")
                                    //     : Text(
                                    //         extractedData[index]
                                    //             .answer
                                    //             .keys
                                    //             .toString(),
                                    //         style: TextStyle(
                                    //             color: userAnswerList[index]
                                    //                         .toString()
                                    //                         .toLowerCase() ==
                                    //                     lessons[index]
                                    //                         .answer
                                    //                         .keys
                                    //                         .toString()
                                    //                 ? kCorrectAnswerColor
                                    //                 : kIncorrectAnswerColor),
                                    //       ),
                                  ],
                                );
                              },
                            ),
                          );
                        }
                      } else {
                        return SafeArea(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                CircularProgressIndicator(),
                                Text(
                                  "Please Wait while Questions are loading..",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    // color: kNeutralAnswerColor,
                                    decoration: TextDecoration.none,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Text("No data");
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child: const NextButton(),
                    onTap: () {
                      int i;
                      for (i = 0; i < lessons.toSet().toList().length; i++) {
                        checkAnswer(i);
                      }
                      nextQuestion(i);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: 150,
                            height: 150,
                            child: IconButton(
                              icon: Icon(Icons.abc),
                              onPressed: () {
                                print('acbd');
                              },
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kBackgroundColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: 150,
                            height: 150,
                            child: IconButton(
                              icon: Icon(Icons.abc),
                              onPressed: () {
                                print('acbd');
                              },
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kBackgroundColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: 150,
                            height: 150,
                            child: IconButton(
                              icon: Icon(Icons.abc),
                              onPressed: () {
                                print('acbd');
                              },
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kBackgroundColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
}
