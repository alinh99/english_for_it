import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/home/home_screen.dart';
import 'package:flutter_eft/constants.dart';
import 'package:flutter_eft/Screens/splash/components/heading.dart';
import 'package:flutter_eft/Screens/splash/components/content.dart';
import 'package:flutter_eft/Screens/splash/components/get_started_button.dart';
import 'package:flutter_eft/Screens/splash/components/primary_button.dart';
import 'package:flutter_eft/Screens/splash/components/icon_input.dart';

import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:lottie/lottie.dart';

// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  static String splashPage = "splash_screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  TextEditingController emailEditingController;
  TextEditingController passwordEditingController;

  AnimationController _controller;
  double windowWidth = 0;
  double windowHeight = 0;
  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;
  double _registerHeight = 0;
  double _infoHeight = 0;
  double _infoYOffset = 0;
  double _registerOpacity = 1;
  double _headingTop = 100;
  double _registerWidth = 0;
  double _registerXOffset = 0;
  // Animation _animation;
  bool _loadingInProgress = false;
  Color _backgroundColor = Colors.white;
  Color _headingColor = kGetStartedButtonColor;
  int _pageState = 0;
  double _registerYOffset = 0;
  bool _keyboardVisibility = false;
  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardVisibility = visible;
        });
      },
    );
    _loadingInProgress = true;
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        // Navigator.pop(context);
        _controller.reset();
      }
    });

    _controller.forward();

    _loadData();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  Future _loadData() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    _dataLoaded();
  }

  void _dataLoaded() {
    setState(() {
      _loadingInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;
    // _loginHeight = windowHeight - 270;
    // _registerHeight = windowHeight - 270;
    // _infoHeight = windowHeight - 270;
    switch (_pageState) {
      case 0:
        _backgroundColor = Colors.white;
        _headingColor = kGetStartedButtonColor;
        _headingTop = 100;
        _loginWidth = windowWidth;
        _loginOpacity = 1;
        _loginXOffset = 0;
        _loginYOffset = windowHeight;
        _registerOpacity = 1;
        _loginHeight = _keyboardVisibility ? windowHeight : windowHeight - 270;
        _registerYOffset = windowHeight;
        _infoYOffset = windowHeight;
        break;
      case 1:
        _backgroundColor = kBackgroundColor;
        _headingColor = Colors.white;
        _headingTop = 90;
        _loginWidth = windowWidth;
        _loginOpacity = 1;
        _registerWidth = windowWidth;
        _loginYOffset = _keyboardVisibility ? 47 : 270;
        _loginHeight =
            _keyboardVisibility ? windowHeight - 298 : windowHeight - 270;
        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        _registerOpacity = 1;
        _infoYOffset = windowHeight;
        break;
      case 2:
        _backgroundColor = kBackgroundColor;
        _headingColor = Colors.white;
        _headingTop = 80;
        _registerWidth = windowWidth;
        _loginWidth = windowWidth - 40;
        _loginOpacity = 0.7;
        _registerOpacity = 1;
        _registerXOffset = 0;
        _loginYOffset = _keyboardVisibility ? 30 : 240;
        _loginHeight = _keyboardVisibility ? windowHeight : windowHeight - 240;
        _loginXOffset = 20;
        _registerYOffset = _keyboardVisibility ? 35 : 270;
        _registerHeight =
            _keyboardVisibility ? windowHeight : windowHeight - 270;
        _infoYOffset = windowHeight;
        break;
      case 3:
        _backgroundColor = kBackgroundColor;
        _headingColor = Colors.white;
        _registerWidth = windowWidth - 40;
        _registerOpacity = 0.7;
        _registerYOffset = _keyboardVisibility ? 30 : 240;
        _registerHeight =
            _keyboardVisibility ? windowHeight : windowHeight - 240;
        _registerXOffset = 20;
        _infoYOffset = _keyboardVisibility ? 35 : 270;
        _infoHeight = _keyboardVisibility ? windowHeight : windowHeight - 270;
        break;
    }

    // if (_loadingInProgress == true) {
    //   return Center(
    //     child: SpinKitCubeGrid(
    //       color: kBackgroundColor,
    //       size: 50.0,
    //       controller: _controller,
    //     ),
    //   );
    // } else {
    //   Future.delayed(
    //     Duration.zero,
    //     () => showSuccessfulDialog(),
    //   );
    return Stack(
      children: [
        AnimatedContainer(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(
            milliseconds: 1000,
          ),
          color: _backgroundColor,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      _pageState = 0;
                    },
                  );
                },
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Heading(
                      headingColor: _headingColor,
                      headingTop: _headingTop,
                    ),
                    Content(controller: _controller),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _pageState = 2;
                        });
                      },
                      child: const GetStartedButton(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            AnimatedContainer(
              height: _loginHeight,
              width: _loginWidth,
              duration: const Duration(
                milliseconds: 1000,
              ),
              padding: const EdgeInsets.all(32),
              curve: Curves.fastLinearToSlowEaseIn,
              transform:
                  Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(_loginOpacity),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Column(
              //       children: [
              //         Container(
              //           margin: const EdgeInsets.only(
              //             bottom: 20,
              //           ),
              //           child: const Text(
              //             "Login To Continue",
              //             style: TextStyle(fontSize: 20),
              //           ),
              //         ),
              //         IconInput(
              //           checkPassword: false,
              //           icon: Icons.email,
              //           editingController: emailEditingController,
              //           inputHintText: "Enter your email...",
              //         ),
              //         const SizedBox(
              //           height: 20,
              //         ),
              //         IconInput(
              //           checkPassword: true,
              //           icon: Icons.remove_red_eye,
              //           editingController: passwordEditingController,
              //           inputHintText: "Enter your password...",
              //         ),
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         PrimaryButton(
              //           btnText: "Login",
              //           backgroundColor: kBackgroundColor,
              //           colorTextStyle: Colors.white,
              //         ),
              //         SizedBox(
              //           height: 20,
              //         ),
              //         GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               _pageState = 2;
              //             });
              //           },
              //           child: PrimaryButton(
              //             btnText: "Create a New Account",
              //             backgroundColor: Colors.white,
              //             colorTextStyle: kBackgroundColor,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              child: ColBackgroundLoginAndRegister(
                "Login to Continue",
                "Enter your email",
                "Enter your password",
                "Login",
                "Create New Account",
                2,
                Icons.email,
                Icons.lock,
              ),
            ),
          ],
        ),
        AnimatedContainer(
          height: _registerHeight,
          width: _registerWidth,
          duration: const Duration(
            milliseconds: 1000,
          ),
          padding: const EdgeInsets.all(32),
          curve: Curves.fastLinearToSlowEaseIn,
          transform:
              Matrix4.translationValues(_registerXOffset, _registerYOffset, 1),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(_registerOpacity),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Column(
          //       children: [
          //         Container(
          //           margin: EdgeInsets.only(
          //             bottom: 20,
          //           ),
          //           child: Text(
          //             "Create a New Account",
          //             style: TextStyle(fontSize: 20),
          //           ),
          //         ),
          //         IconInput(
          //           checkPassword: false,
          //           icon: Icons.email,
          //           editingController: emailEditingController,
          //           inputHintText: "Enter your email...",
          //         ),
          //         const SizedBox(
          //           height: 20,
          //         ),
          //         IconInput(
          //           checkPassword: true,
          //           icon: Icons.remove_red_eye,
          //           editingController: passwordEditingController,
          //           inputHintText: "Enter your password...",
          //         ),
          //       ],
          //     ),
          //     Column(
          //       children: [
          //         PrimaryButton(
          //           btnText: "Create Account",
          //           backgroundColor: kBackgroundColor,
          //           colorTextStyle: Colors.white,
          //         ),
          //         SizedBox(
          //           height: 20,
          //         ),
          //         GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               _pageState = 1;
          //             });
          //           },
          //           child: PrimaryButton(
          //             btnText: "Back to Login",
          //             backgroundColor: Colors.white,
          //             colorTextStyle: kBackgroundColor,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          child: ColBackgroundLoginAndRegister(
            "Create a New Account",
            "Enter your email",
            "Enter your password",
            "Continue",
            "Back To Login",
            1,
            Icons.email,
            Icons.lock,
          ),
        ),
        AnimatedContainer(
          height: _infoHeight,
          //width: _infoWidth,
          duration: const Duration(
            milliseconds: 1000,
          ),
          padding: const EdgeInsets.all(32),
          curve: Curves.fastLinearToSlowEaseIn,
          transform: Matrix4.translationValues(0, _infoYOffset, 1),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: ColBackgroundLoginAndRegister(
            "Profile",
            "Enter your full name",
            "Enter your Age",
            "Create new account",
            "Back To Create New Account",
            2,
            Icons.person,
            Icons.date_range_sharp,
          ),
        ),
      ],
    );
    // }
  }

  Column ColBackgroundLoginAndRegister(
    String header,
    String emailHint,
    String passwordHint,
    String textBtn,
    String convertTextBtn,
    int statePage,
    IconData iconFirst,
    IconData iconSecond,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 20,
            //top: 20,
          ),
          child: Text(
            header,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        IconInput(
          icon: iconFirst,
          inputHintText: emailHint,
          editingController: emailEditingController,
          checkPassword: false,
        ),
        IconInput(
          icon: iconSecond,
          inputHintText: passwordHint,
          editingController: passwordEditingController,
          checkPassword: true,
        ),
        Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(
                  () {
                    if (_pageState == 1) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          settings: const RouteSettings(name: '/homepage'),
                          builder: (BuildContext context) {
                            return const HomeScreen();
                          },
                        ),
                      );
                    } else if (_pageState == 2) {
                      _pageState = 3;
                    } else if (_pageState == 3) {
                      _pageState = 1;
                    }
                  },
                );
              },
              child: PrimaryButton(
                btnText: textBtn,
                backgroundColor: kBackgroundColor,
                colorTextStyle: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _pageState = statePage;
                });
              },
              child: PrimaryButton(
                btnText: convertTextBtn,
                backgroundColor: Colors.white,
                colorTextStyle: kBackgroundColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showSuccessfulDialog() async => showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset("assets/images/transaction_success.json",
                  repeat: false,
                  height: 200,
                  width: 200,
                  controller: _controller, onLoaded: (composition) {
                _controller.duration = composition.duration;
                _controller.forward();
              }),
              const Center(
                child: Text(
                  "Done!",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 21),
            ],
          ),
        ),
      );
}
