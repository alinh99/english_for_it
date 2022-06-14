import 'package:flutter/material.dart';
import 'package:flutter_eft/Components/custom_bottom_nav_bar.dart';
import 'package:flutter_eft/Screens/review/components/body.dart';
import 'package:flutter_eft/enums.dart';

class ReviewScreen extends StatelessWidget {
  static String reviewPage = "review_screen";

  const ReviewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Body(
        size: size,
      ),
      bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.review),
    );
  }
}
