import 'package:flutter/material.dart';
import 'package:flutter_eft/components/custom_bottom_nav_bar.dart';
import 'package:flutter_eft/Screens/Home_details/writing/components/body.dart';
import 'package:flutter_eft/enums.dart';

class WritingScreen extends StatefulWidget {
  static const String detailsPage = "writing_screen";

  const WritingScreen({Key key}) : super(key: key);

  @override
  _WritingScreenState createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      body: Body(),
    );
  }
}
