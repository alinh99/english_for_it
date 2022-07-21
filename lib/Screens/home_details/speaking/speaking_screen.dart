import 'package:flutter/material.dart';
import 'package:flutter_eft/components/custom_bottom_nav_bar.dart';
import 'package:flutter_eft/Screens/Home_details/speaking/components/body.dart';
import 'package:flutter_eft/enums.dart';

class SpeakingScreen extends StatefulWidget {
  static const String detailsPage = "speaking_screen";

  const SpeakingScreen({Key key}) : super(key: key);

  @override
  _SpeakingScreenState createState() => _SpeakingScreenState();
}

class _SpeakingScreenState extends State<SpeakingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      body: Body(),
    );
  }
}
