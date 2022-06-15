import 'package:flutter/material.dart';
import 'package:flutter_eft/components/custom_bottom_nav_bar.dart';
import 'package:flutter_eft/Screens/Home_details/components/body.dart';
import 'package:flutter_eft/enums.dart';

class DetailsScreen extends StatefulWidget {
  static const String detailsPage = "details_screen";

  const DetailsScreen({Key key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar:  CustomBottomNavBar(selectedMenu: MenuState.home),
      body: Body(),
    );
  }
}
