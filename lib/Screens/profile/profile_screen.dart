import 'package:flutter/material.dart';
import 'package:flutter_eft/components/custom_bottom_nav_bar.dart';
import 'package:flutter_eft/enums.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String profilePage = "profile_screen";

  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Body(
        size: size,
      ),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
