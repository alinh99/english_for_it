import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/home/components/colors.dart';
import 'package:flutter_eft/Screens/home/components/long_course_card.dart';
import 'package:flutter_eft/Screens/home/components/style.dart';
import 'package:flutter_eft/Screens/review_details/review_details_screen.dart';
import 'package:flutter_eft/constants.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: size.height - (size.height / 4),
          width: size.width,
          decoration: const BoxDecoration(
            color: kBackgroundColor,
          ),
          padding: const EdgeInsets.only(
            left: 24,
          ),
          child: SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                        alignment: Alignment.center,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          child: Text(
                            "Ready to review?",
                            style: AppStyle.b32w,
                          ),
                          alignment: Alignment.center,
                        ),
                        Align(
                          child: Text(
                            "Choose your skill",
                            style: AppStyle.r12w,
                            textAlign: TextAlign.left,
                          ),
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            height: size.height - (size.height / 3),
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(34),
                topRight: Radius.circular(34),
              ),
            ),
            child: Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Expanded(
                          child: SizedBox(
                            width: 30,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    LongCourseCard(
                                      background: AppColors.pink,
                                      title: "Listening Course",
                                      subTitle: "10 Units",
                                      image: ("assets/images/listening.json"),
                                      press: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            settings: const RouteSettings(
                                                name: '/review_details_screen'),
                                            builder: (BuildContext context) {
                                              return const ReviewDetailsScreen();
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    LongCourseCard(
                                      background: AppColors.pink,
                                      title: "Writing Course",
                                      subTitle: "10 Units",
                                      image: ("assets/images/writing.json"),
                                      press: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            settings: const RouteSettings(
                                                name: '/review_details_screen'),
                                            builder: (BuildContext context) {
                                              return const ReviewDetailsScreen();
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    LongCourseCard(
                                      background: AppColors.pink,
                                      title: "Reading Course",
                                      subTitle: "10 Units",
                                      image: ("assets/images/reading_2.json"),
                                      press: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            settings: const RouteSettings(
                                                name: '/review_details_screen'),
                                            builder: (BuildContext context) {
                                              return const ReviewDetailsScreen();
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    LongCourseCard(
                                      background: AppColors.pink,
                                      title: "Speaking Course",
                                      subTitle: "10 Units",
                                      image: ("assets/images/speaking.json"),
                                      press: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            settings: const RouteSettings(
                                                name: '/review_details_screen'),
                                            builder: (BuildContext context) {
                                              return const ReviewDetailsScreen();
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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
