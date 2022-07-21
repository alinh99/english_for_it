import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/home_details/listening/listening_screen.dart';
import 'package:flutter_eft/Screens/home_details/reading/reading_screen.dart';
import 'package:flutter_eft/Screens/home_details/speaking/speaking_screen.dart';
import 'package:flutter_eft/Screens/home_details/writing/writing_screen.dart';
import 'package:flutter_eft/Screens/lessons/listening/lesson_listening_screen.dart';
import 'package:flutter_eft/colors.dart';
import 'package:flutter_eft/Screens/home/components/style.dart';
import 'package:flutter_eft/Screens/home/components/long_course_card.dart';

class Body extends StatefulWidget {
  const Body({Key key, @required this.size}) : super(key: key);
  final Size size;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: widget.size.height - (widget.size.height / 4),
            width: widget.size.width,
            decoration: const BoxDecoration(
              color: AppColors.red,
            ),
            child: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 48,
                        ),
                        Text(
                          "Ready to learn?",
                          style: AppStyle.b32w,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Choose your skill",
                          style: AppStyle.r12w,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            height: widget.size.height - (widget.size.height / 3),
            width: widget.size.width,
            decoration: const BoxDecoration(
              color: AppColors.pink,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(34),
                topRight: Radius.circular(34),
              ),
            ),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'All',
                          style: AppStyle.m12b.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Favourite',
                          style: AppStyle.m12bt,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Recommended',
                          style: AppStyle.m12bt,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              LongCourseCard(
                                background: AppColors.red,
                                title: "Listening Course",
                                subTitle: "10 Units",
                                image: ("assets/images/listening.json"),
                                press: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      settings: const RouteSettings(
                                          name: '/listening_screen'),
                                      builder: (BuildContext context) {
                                        return const ListeningScreen();
                                      },
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              LongCourseCard(
                                background: AppColors.red,
                                title: "Writing Course",
                                subTitle: "10 Units",
                                image: ("assets/images/writing.json"),
                                press: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      settings: const RouteSettings(
                                          name: '/writing_screen'),
                                      builder: (BuildContext context) {
                                        return const WritingScreen();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              LongCourseCard(
                                background: AppColors.red,
                                title: "Reading Course",
                                subTitle: "10 Units",
                                image: ("assets/images/reading_2.json"),
                                press: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      settings: const RouteSettings(
                                          name: '/reading_screen'),
                                      builder: (BuildContext context) {
                                        return const ReadingScreen();
                                      },
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              LongCourseCard(
                                background: AppColors.red,
                                title: "Speaking Course",
                                subTitle: "10 Units",
                                image: ("assets/images/speaking.json"),
                                press: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      settings: const RouteSettings(
                                          name: '/speaking_screen'),
                                      builder: (BuildContext context) {
                                        return const SpeakingScreen();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
