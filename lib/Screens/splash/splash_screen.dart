import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/home/home_screen.dart';
import 'package:flutter_eft/Screens/models/users.dart';
import 'package:flutter_eft/Screens/services/auth.dart';
import 'package:flutter_eft/Screens/services/database.dart';
import 'package:flutter_eft/Screens/services/storage.dart';
import 'package:flutter_eft/Screens/splash/components/loading.dart';
import 'package:flutter_eft/constants.dart';
import 'package:flutter_eft/Screens/splash/components/heading.dart';
import 'package:flutter_eft/Screens/splash/components/content.dart';
import 'package:flutter_eft/Screens/splash/components/get_started_button.dart';
import 'package:flutter_eft/Screens/splash/components/primary_button.dart';
import 'package:flutter_eft/Screens/splash/components/icon_input.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static String splashPage = "splash_screen";

  SplashScreen({
    Key key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Storage _storage = Storage();
  XFile image;
  AnimationController _controller;
  TextEditingController emailEditingController = TextEditingController();
  PlatformFile pickedFile;
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController ageEditingController = TextEditingController();

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
  double _infoWidth = 0;
  double _infoXOffset = 0;
  double _infoNextWidth = 0;
  double _infoNextYOffset = 0;
  double _infoNextXOffset = 0;
  double _infoNextHeight = 0;
  double _infoOpacity = 1;
  double _infoNextOpacity = 1;
  String imageUrl;
  bool loadingInProgress = false;
  Color _backgroundColor = Colors.white;
  Color _headingColor = kGetStartedButtonColor;
  int _pageState = 0;
  double _registerYOffset = 0;
  bool _keyboardVisibility = false;
  final GlobalKey<FormState> _formKeyEmailSignUp = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyEmailSignIn = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPasswordSignUp = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPasswordSignIn = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyProfileFirstName = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyProfileLastName = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyProfileAge = GlobalKey<FormState>();
  String error = '';
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
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      }
    });

    _controller.forward();

    _loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
    firstNameEditingController.dispose();
    lastNameEditingController.dispose();
    ageEditingController.dispose();
    super.dispose();
  }

  Future _loadData() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    setState(() {
      loadingInProgress = true;
    });
  }

  Future<String> uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _imagePicker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        for (var i = 0; i < 1000000000; i++) {
          var snapshot = await _firebaseStorage
              .ref()
              .child('images/imageName$i')
              .putFile(file);
          var downloadUrl = await snapshot.ref.getDownloadURL();

          setState(() {
            imageUrl = downloadUrl;
          });
        }
        //print("downloadUrl: " + downloadUrl);
        print("imageUrl: " + imageUrl);
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;
    _loginHeight = windowHeight - 270;
    _registerHeight = windowHeight - 270;
    _infoHeight = windowHeight - 270;
    final user = Provider.of<Users>(context);
    if (user == null && _pageState == 1) {
      setState(() {
        _pageState = 1;
      });
    } else if (user != null && _pageState > 4) {
      return const HomeScreen();
    }
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
        _loginYOffset = _keyboardVisibility ? 40 : 270;
        _loginHeight = _keyboardVisibility ? windowHeight : windowHeight - 270;
        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        _registerOpacity = 1;
        _infoYOffset = windowHeight;
        break;
      case 2:
        _backgroundColor = kBackgroundColor;
        _headingColor = Colors.white;
        _headingTop = 100;
        _registerWidth = windowWidth;
        _loginWidth = windowWidth - 40;
        _loginOpacity = 0.7;
        _registerOpacity = 1;
        _registerXOffset = 0;
        _loginYOffset = _keyboardVisibility ? 30 : 240;
        _loginHeight = _keyboardVisibility ? windowHeight : windowHeight - 240;
        _loginXOffset = 20;
        _registerYOffset = _keyboardVisibility ? 40 : 270;
        _registerHeight =
            _keyboardVisibility ? windowHeight : windowHeight - 270;
        _infoYOffset = windowHeight;
        break;
      case 3:
        _backgroundColor = kBackgroundColor;
        _headingColor = Colors.white;
        _registerWidth = windowWidth - 40;
        _headingTop = 100;
        _infoWidth = windowWidth;
        _registerOpacity = 0.7;
        _loginOpacity = 0.7;
        _infoOpacity = 1;
        _registerYOffset = _keyboardVisibility ? 40 : 240;
        _registerHeight =
            _keyboardVisibility ? windowHeight : windowHeight - 240;
        _registerXOffset = 20;
        _infoYOffset = _keyboardVisibility ? 55 : 270;
        _infoXOffset = 0;
        _loginHeight = 0;
        _infoHeight = _keyboardVisibility ? windowHeight : windowHeight - 270;
        _infoNextYOffset = windowHeight;
        break;
      case 4:
        _backgroundColor = kBackgroundColor;
        _headingColor = Colors.white;
        _headingTop = 100;
        _infoWidth = windowWidth - 40;
        _infoNextWidth = windowWidth;
        _infoOpacity = 0.7;
        _infoNextOpacity = 1;
        _infoNextXOffset = 0;
        _infoYOffset = _keyboardVisibility ? 40 : 240;
        _infoHeight = _keyboardVisibility ? windowHeight : windowHeight - 240;
        _infoXOffset = 20;
        _infoNextYOffset = _keyboardVisibility ? 55 : 270;
        _infoNextHeight =
            _keyboardVisibility ? windowHeight : windowHeight - 270;
        _registerHeight = 0;
        _loginHeight = 0;
        break;
    }

    if (loadingInProgress == false) {
      return Loading(controller: _controller);
    } else {
      return Scaffold(
        body: Stack(
          children: [
            AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(
                milliseconds: 1000,
              ),
              color: _backgroundColor,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          loadingInProgress = true;
                          _pageState = 0;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Heading(
                          headingColor: _headingColor,
                          headingTop: _headingTop,
                        ),
                        Content(
                          windowHeight: windowHeight - 280,
                          controller: _controller,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _pageState = 1;
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
              child: colBackgroundLoginAndRegister(
                "Login to Continue",
                "Enter your email",
                "Enter your password",
                "Login",
                "Create New Account",
                2,
                Icons.email,
                Icons.lock,
                false,
                true,
                emailEditingController,
                passwordEditingController,
                _formKeyEmailSignIn,
                _formKeyPasswordSignIn,
              ),
            ),
            AnimatedContainer(
              height: _registerHeight,
              width: _registerWidth,
              duration: const Duration(
                milliseconds: 1000,
              ),
              padding: const EdgeInsets.all(32),
              curve: Curves.fastLinearToSlowEaseIn,
              transform: Matrix4.translationValues(
                  _registerXOffset, _registerYOffset, 1),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(_registerOpacity),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: colBackgroundLoginAndRegister(
                "Create a New Account",
                "Enter your email",
                "Enter your password",
                "Continue",
                "Back To Login",
                1,
                Icons.email,
                Icons.lock,
                false,
                true,
                emailEditingController,
                passwordEditingController,
                _formKeyEmailSignUp,
                _formKeyPasswordSignUp,
              ),
            ),
            AnimatedContainer(
              height: _infoHeight,
              width: _infoWidth,
              duration: const Duration(
                milliseconds: 1000,
              ),
              padding: const EdgeInsets.all(32),
              curve: Curves.fastLinearToSlowEaseIn,
              transform:
                  Matrix4.translationValues(_infoXOffset, _infoYOffset, 1),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(_infoOpacity),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: colBackgroundLoginAndRegister(
                "Profile",
                "Enter your first name",
                "Enter your last name",
                "Continue",
                "Back to Create New Account",
                2,
                Icons.person,
                Icons.people,
                false,
                false,
                firstNameEditingController,
                lastNameEditingController,
                _formKeyProfileFirstName,
                _formKeyProfileLastName,
              ),
            ),
            AnimatedContainer(
              height: _infoNextHeight,
              width: _infoNextWidth,
              duration: const Duration(
                milliseconds: 1000,
              ),
              padding: const EdgeInsets.all(32),
              curve: Curves.fastLinearToSlowEaseIn,
              transform: Matrix4.translationValues(
                  _infoNextXOffset, _infoNextYOffset, 1),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(_infoNextOpacity),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: colBackgroundProfile(
                  "Profile",
                  "Enter your age",
                  "Create new account",
                  "Back To Previous",
                  3,
                  Icons.person,
                  Icons.file_open,
                  _formKeyProfileAge),
            ),
          ],
        ),
      );
    }
  }

  Column colBackgroundLoginAndRegister(
    String header,
    String emailHint,
    String passwordHint,
    String textBtn,
    String convertTextBtn,
    int statePage,
    IconData iconFirst,
    IconData iconSecond,
    bool checkPasswordFirst,
    bool checkPasswordSecond,
    TextEditingController firstController,
    TextEditingController secondController,
    dynamic formKeyFirst,
    dynamic formKeySecond,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        IconInput(
          icon: iconFirst,
          inputHintText: emailHint,
          editingController: firstController,
          checkPassword: checkPasswordFirst,
          isEmail: firstController == emailEditingController ? true : false,
          isName: firstController == firstNameEditingController ? true : false,
          isAge: false,
          formKey: formKeyFirst,
        ),
        IconInput(
          icon: iconSecond,
          inputHintText: passwordHint,
          editingController: secondController,
          checkPassword: checkPasswordSecond,
          isName: secondController == lastNameEditingController ? true : false,
          isEmail: false,
          isAge: false,
          formKey: formKeySecond,
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () async {
                if (_pageState == 1) {
                  setState(() {
                    loadingInProgress = true;
                  });
                  if (formKeyFirst.currentState.validate() &&
                      formKeySecond.currentState.validate()) {
                    dynamic result = await _auth.signInWithEmailAndPassword(
                        emailEditingController.text,
                        passwordEditingController.text);
                    if (result == null) {
                      setState(() =>
                          error = 'COULD NOT SIGN IN WITH THOSE CREDENTIALS');
                    } else if (result != null) {
                      setState(() {
                        error = '';
                      });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          settings: const RouteSettings(name: '/homepage'),
                          builder: (BuildContext context) {
                            return const HomeScreen();
                          },
                        ),
                      );
                      setState(() {
                        loadingInProgress = false;
                      });
                    }
                  }
                } else if (_pageState == 2) {
                  if (formKeyFirst.currentState.validate() &&
                      formKeySecond.currentState.validate()) {
                    dynamic result = await _auth.registerWithEmailAndPassword(
                      emailEditingController.text,
                      passwordEditingController.text,
                    );
                    if (result == null) {
                      setState(() {
                        error =
                            'Please Supply A Valid Email Or Email Is Already Created';
                      });
                    } else if (result != null) {
                      setState(() {
                        _pageState = 3;
                        error = '';
                      });
                    }
                  } else {
                    setState(() {
                      error = '';
                    });
                  }
                } else if (_pageState == 3) {
                  try {
                    final userName = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(auth.currentUser.uid)
                        .set({
                      'first_name': firstNameEditingController.text,
                      'last_name': lastNameEditingController.text,
                      'age': ageEditingController.text,
                      'password': passwordEditingController.text,
                    });
                    setState(() {
                      _pageState = 4;
                    });
                    return userName;
                  } catch (e) {
                    print(e);
                  }
                }
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
            const SizedBox(
              height: 12,
            ),
            Text(
              error,
              style: const TextStyle(color: kBackgroundColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }

  Column colBackgroundProfile(
    String header,
    String fistHint,
    String textBtn,
    String convertTextBtn,
    int statePage,
    IconData iconFirst,
    IconData iconSecond,
    dynamic formKey,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 20,
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
          inputHintText: fistHint,
          editingController: ageEditingController,
          checkPassword: false,
          isEmail: false,
          isName: false,
          isAge: true,
          formKey: formKey,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: kBorderColor,
              width: 2,
            ),
            color: kHintTextColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                  },
                  child: const Center(
                    child: Text(
                      "Choose an image",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () async {
                if (_pageState == 4) {
                  try {
                    final url = await _storage.uploadFile(File(image.path));
                    final userAge = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(auth.currentUser.uid)
                        .set({
                      'first_name': firstNameEditingController.text,
                      'last_name': lastNameEditingController.text,
                      'age': int.parse(ageEditingController.text),
                      'password': passwordEditingController.text,
                      'photo_url': url,
                    });
                    setState(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          settings: const RouteSettings(name: '/homepage'),
                          builder: (BuildContext context) {
                            return const HomeScreen();
                          },
                        ),
                      );
                    });
                    return userAge;
                    // if (userAge != null) {

                    // }
                  } catch (e) {
                    print(e);
                  }
                }
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
}
