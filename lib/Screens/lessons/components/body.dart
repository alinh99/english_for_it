import 'package:flutter/material.dart';
import 'package:flutter_eft/colors.dart';
import 'package:flutter_eft/Screens/lessons/components/question_list.dart';
import 'package:flutter_eft/Screens/lessons/components/table_data.dart';
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
  bool isPlayed = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
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

    super.initState();
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    final player = AudioCache(prefix: 'assets/database/');
    final url = await player.load('unit1task3.mp3');
    audioPlayer.play(url.path, isLocal: true);
  }

  @override
  Widget build(BuildContext context) {
    // double _width = MediaQuery.of(context).size.width;
    // double _height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/database/less_back_ver2.png"),
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
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      //crossAxisAlignment: CrossAxisAlignment.end,
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
            decoration: BoxDecoration(
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
                children: <Widget>[
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Now listen to the recordings and note the actual uses described.",
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.5,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TableData(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Now listen to the recordings again to find the answers to these questions:",
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        QuestionList(),
                      ],
                    ),
                  ),
                  SizedBox(
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
                  )
                ],
              ),
            ),
          )
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
