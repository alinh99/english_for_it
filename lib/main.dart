import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/models/users.dart';
// import 'package:flutter_eft/Screens/review_details/quizz_page/models/db_connect.dart';
// import 'package:flutter_eft/Screens/review_details/quizz_page/models/question_model.dart';
import 'package:flutter_eft/Screens/splash/splash_screen.dart';
import 'package:flutter_eft/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Screens/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // var db = DBConnect();
  // call this function to add question
  // db.addQuestion(
  //   Question(
  //     id: '1',
  //     title:
  //         'What is a database program developed by the Microsoft Corporation ?',
  //     options: {
  //       'ADSL': false,
  //       '(Microsoft) access': true,
  //       'AI': false,
  //       'Alt(key)': false,
  //     },
  //   ),
  // );
  // db.addQuestion(
  //   Question(
  //     id: '2',
  //     title:
  //         'A wireless network device that connects a wirless network to a weird network is:',
  //     options: {
  //       'access point': true,
  //       '(Microsoft) access': false,
  //       'AI': false,
  //       'Alt(key)': false,
  //     },
  //   ),
  // );
  // db.addQuestion(
  //   Question(
  //     id: '3',
  //     title:
  //         'A registration for a user of a network system. It is used of a network system. It is used for controlling access to the system. It is:',
  //     options: {
  //       'actual': false,
  //       'active window': false,
  //       'account': true,
  //       'Alt(key)': false,
  //     },
  //   ),
  // );
  // db.addQuestion(
  //   Question(
  //     id: '4',
  //     title:
  //         'The window in a WIMP system that is currently being used. It is usually on top of any other open windows.',
  //     options: {
  //       'actual': false,
  //       'algorithm': false,
  //       'account': false,
  //       "active window": true,
  //     },
  //   ),
  // );
  // db.addQuestion(
  //   Question(
  //     id: '5',
  //     title:
  //         'the set of conductors that carry the memory address signals between different parts of a computer system',
  //     options: {
  //       'actual': false,
  //       'address bus': true,
  //       'anti - virus': false,
  //       "active window": true,
  //     },
  //   ),
  // );
  
  // db.fetchQuestion();
  //getUset();
  runApp(const EFTApp());
}

class EFTApp extends StatelessWidget {
  const EFTApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "Nunito",
        ).copyWith(
          primaryColor: kBackgroundColor,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          //resizeToAvoidBottomInset: false,
          body: SplashScreen(),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
