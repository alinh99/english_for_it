import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/home/components/style.dart';
import 'package:flutter_eft/Components/seassion_card.dart';
import 'package:flutter_eft/Screens/lessons/lesson.dart';
import 'background.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
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
                      const SizedBox(
                        height: 48,
                      ),
                      Text(
                        "Let's go",
                        style: AppStyle.b32w,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Choose an unit. You should start from scratch",
                        style: AppStyle.r12w,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 20),
                      height: size.height - (size.height / 5),
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(34),
                          topRight: Radius.circular(34),
                        ),
                      ),
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: <Widget>[
                              SeassionCard(
                                seassionNum: 1,
                                press: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Lesson();
                                  }));
                                },
                              ),
                              SeassionCard(
                                seassionNum: 2,
                                press: () {},
                              ),
                              SeassionCard(
                                seassionNum: 3,
                                press: () {},
                              ),
                              SeassionCard(
                                seassionNum: 4,
                                press: () {},
                              ),
                              SeassionCard(
                                seassionNum: 5,
                                press: () {},
                              ),
                              SeassionCard(
                                seassionNum: 6,
                                press: () {},
                              ),
                              SeassionCard(
                                seassionNum: 7,
                                press: () {},
                              ),
                              SeassionCard(
                                seassionNum: 8,
                                press: () {},
                              ),
                              SeassionCard(
                                seassionNum: 9,
                                press: () {},
                              ),
                              SeassionCard(
                                seassionNum: 10,
                                press: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
