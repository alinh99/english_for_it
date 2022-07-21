import 'package:flutter/material.dart';
import 'package:flutter_eft/components/custom_bottom_nav_bar.dart';
import 'package:flutter_eft/Screens/Home_details/listening/components/body.dart';
import 'package:flutter_eft/enums.dart';

class ListeningScreen extends StatefulWidget {
  static const String detailsPage = "listening_screen";
  const ListeningScreen({Key key}) : super(key: key);
  @override
  _ListeningScreenState createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.home,
      ),
      body: Body(),
    );
  }
}
