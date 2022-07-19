import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/lessons/components/result_box.dart';
import 'package:flutter_eft/Screens/lessons/models/lesson.dart';
import 'package:flutter_eft/Screens/lessons/models/lesson_db.dart';
import 'package:flutter_eft/Screens/lessons/components/next_button.dart';
import 'package:flutter_eft/colors.dart';
import 'package:flutter_eft/Screens/lessons/components/question_list.dart';
import 'package:flutter_eft/Screens/lessons/components/table_data.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  List<TextEditingController> userAnswerType = [];
  //TextEditingController answerController = TextEditingController();
  bool isPlayed = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  LessonDB db = LessonDB();
  //Future _lessons;
  Lesson _lesson = Lesson();
  DatabaseReference lessonRef;
  int ind = 0;
  int score = 0;
  bool isPressed = false;
  bool isSelected = false;
  bool isCorrected = false;
  Icon icon;
  List<String> userAnswerList = [];
  List<String> realAnswerList = [];
  void startOver() {
    setState(() {
      ind = 0;
      score = 0;
      isPressed = false;
      isSelected = false;
    });
    Navigator.pop(context);
  }

  void nextQuestion(int questionLength) {
    if (ind == questionLength - 1) {
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
            ind++;
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
    lessonRef = FirebaseDatabase.instance.reference().child('lesson').child('');
    super.initState();
  }

  @override
  void dispose() {
    userAnswerType[ind].dispose();
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
    var lessons = <Lesson>[];
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
                  StreamBuilder(
                    stream: lessonRef != null ? lessonRef.onValue : null,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && !snapshot.hasError) {
                        var event = snapshot.data as DatabaseEvent;
                        var snapshot2 = event.snapshot.value;
                        if (snapshot2 == null) {
                          return const Center(
                            child: Text('No Tasks Added Yet'),
                          );
                        }
                        Map<String, dynamic> map =
                            Map<String, dynamic>.from(snapshot2);

                        for (var taskMap in map.values) {
                          Lesson lessonModel = Lesson.fromMap(
                              Map<String, dynamic>.from(taskMap));

                          lessons.add(lessonModel);
                        }
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: ListView.builder(
                            itemCount: lessons.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              userAnswerType.add(TextEditingController());
                              Lesson lesson = lessons[index];
                              return Column(
                                children: [
                                  Text(
                                    lesson.title,
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
                                    question: lesson.question,
                                  ),
                                  TextField(
                                    controller: userAnswerType[index],
                                    decoration: const InputDecoration(
                                        hintText: 'Input your answer'),
                                    onChanged: (value) {
                                      value = userAnswerType[index].text;
                                    },
                                  ),
                                  Text(realAnswerList[index])
                                ],
                              );
                            },
                          ),
                        );
                      } else {
                        return SafeArea(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                CircularProgressIndicator(),
                                // SizedBox(
                                //   height: 20.0,
                                // ),
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
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child: NextButton(),
                    onTap: () {
                      for (int i = 0; i < lessons.length; i++) {
                        userAnswerList.insert(i, "(${userAnswerType[i].text})");
                        print(userAnswerList);
                        print("Answer Key: ${lessons[i].answer.keys}");
                        print("User Answer: ${userAnswerType[i].text}");
                        if (userAnswerList.isEmpty) {
                          print("null list");
                          //return Text("null list");
                        } else {
                          if (userAnswerList[i].toLowerCase().toString() ==
                              lessons[i].answer.keys.toString()) {
                            print("Results: true");
                            //return Text("true");
                          } else {
                            print("Results: false");
                            //return Text("false");
                            realAnswerList
                                .add(lessons[i].answer.keys.toString());
                            print("AnswerKey List: $realAnswerList");
                            // setState(() {
                            //   answerKey[i] = lessons[i].answer.keys.toString();
                            // });
                          }
                        }
                      }
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
