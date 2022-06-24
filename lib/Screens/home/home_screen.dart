import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/home/components/body.dart';
import 'package:flutter_eft/enums.dart';
import 'package:flutter_eft/Components/custom_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  static String homePage = "home_screen";

  const HomeScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Body(size: size),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
