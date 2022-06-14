import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/splash/splash_screen.dart';
import 'package:flutter_eft/constants.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
