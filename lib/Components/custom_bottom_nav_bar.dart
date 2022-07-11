import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/review_details/review_details_screen.dart';
import 'package:flutter_eft/colors.dart';
import 'package:flutter_eft/constants.dart';
import 'package:flutter_eft/screens/home/home_screen.dart';
import 'package:flutter_eft/screens/profile/profile_screen.dart';
import 'box_decoration.dart';
import 'package:flutter_eft/enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: boxDecoration(),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(
                  CupertinoIcons.home,
                ),
                color: MenuState.home == selectedMenu
                    ? AppColors.pink
                    : kInActiveIconColor,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: const RouteSettings(name: '/homepage'),
                    builder: (BuildContext context) {
                      return const HomeScreen();
                    },
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  CupertinoIcons.pencil_ellipsis_rectangle,
                ),
                color: MenuState.review == selectedMenu
                    ? AppColors.pink
                    : kInActiveIconColor,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: const RouteSettings(name: '/review_screen'),
                    builder: (BuildContext context) {
                      return const ReviewDetailsScreen();
                    },
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.person),
                color: MenuState.profile == selectedMenu
                    ? AppColors.pink
                    : kInActiveIconColor,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: const RouteSettings(name: '/profile_screen'),
                    builder: (BuildContext context) {
                      return const ProfileScreen();
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
