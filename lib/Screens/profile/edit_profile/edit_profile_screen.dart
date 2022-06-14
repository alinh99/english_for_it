import 'package:flutter/material.dart';
import 'components/body.dart';
import 'package:flutter_eft/components/custom_bottom_nav_bar.dart';
import 'package:flutter_eft/enums.dart';

class EditProfileScreen extends StatelessWidget {
  static String splashPage = "edit_profile_screen";

  const EditProfileScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Body(size: size),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
