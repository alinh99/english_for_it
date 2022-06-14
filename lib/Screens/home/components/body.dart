import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/home/components/colors.dart';
import 'package:flutter_eft/Screens/home_details/home_details.dart';
import 'package:flutter_eft/constants.dart';
import 'package:flutter_eft/Screens/home/components/style.dart';
import 'package:flutter_eft/Screens/home/components/long_course_card.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: size.height - (size.height / 4),
            width: size.width,
            decoration: const BoxDecoration(
              color: kBackgroundColor,
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
                    child: Row(
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
                                          name: '/details_screen'),
                                      builder: (BuildContext context) {
                                        return const DetailsScreen();
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
                                          name: '/details_screen'),
                                      builder: (BuildContext context) {
                                        return const DetailsScreen();
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
                                          name: '/details_screen'),
                                      builder: (BuildContext context) {
                                        return const DetailsScreen();
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
                                          name: '/details_screen'),
                                      builder: (BuildContext context) {
                                        return const DetailsScreen();
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
