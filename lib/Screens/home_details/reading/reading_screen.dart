import 'package:flutter/material.dart';
import 'package:flutter_eft/components/custom_bottom_nav_bar.dart';
import 'package:flutter_eft/Screens/Home_details/reading/components/body.dart';
import 'package:flutter_eft/enums.dart';

class ReadingScreen extends StatefulWidget {
  static const String detailsPage = "reading_screen";

  const ReadingScreen({Key key}) : super(key: key);

  @override
  _ReadingScreenState createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      body: Body(),
    );
  }
}
