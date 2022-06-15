import 'package:flutter/material.dart';
// import 'package:flutter_eft/Screens/review_details/quizz_page/models/db_connect.dart';
// import 'package:flutter_eft/Screens/review_details/quizz_page/models/question_model.dart';
import 'package:flutter_eft/Screens/splash/splash_screen.dart';
import 'package:flutter_eft/constants.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // var db = DBConnect();
  // db.addQuestion(Question(id: '20', title: 'What is 20 x 100 ?', options: {
  //   '100': false,
  //   '200': true,
  //   '300': false,
  //   '400': false,
  // }));
  // db.fetchQuestion();
  runApp(const EFTApp());
}

class EFTApp extends StatelessWidget {
  const EFTApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Nunito",
      ).copyWith(
        primaryColor: kBackgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: SplashScreen(),
      ),
    );
  }
}
