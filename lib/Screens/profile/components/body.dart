import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/profile/edit_profile/edit_profile_screen.dart';
import 'package:flutter_eft/Screens/services/auth.dart';
import 'package:flutter_eft/Screens/splash/splash_screen.dart';
import 'package:flutter_eft/constants.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  const Body({Key key, @required this.size}) : super(key: key);
  final Size size;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String userImage;

  Future<void> _getUserImage() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc((FirebaseAuth.instance.currentUser).uid)
        .get()
        .then((value) {
      setState(() {
        userImage = value.data()['photo_url'];
      });
    });
  }

  @override
  void initState() {
    _getUserImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: widget.size.height - (widget.size.height / 5),
          width: widget.size.width,
          decoration: const BoxDecoration(
            color: kBackgroundColor,
          ),
          padding: const EdgeInsets.only(
            left: 24,
          ),
          child: SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                        alignment: Alignment.center,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Align(
                          child: Expanded(
                            child: ProfilePic(avatarUrl: userImage),
                          ),
                          alignment: Alignment.center,
                        ),
                        // Align(
                        //   child: Expanded(
                        //     child: Text(user.displayName),
                        //   ),
                        //   alignment: Alignment.center,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            height: widget.size.height - (widget.size.height / 2.5),
            width: widget.size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(34),
                topRight: Radius.circular(34),
              ),
            ),
            child: Expanded(
              child: Column(
                children: [
                  //SizedBox(height: 20),
                  Expanded(
                    child: ProfileMenu(
                      text: "My Account",
                      icon: CupertinoIcons.person,
                      press: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            settings: const RouteSettings(
                                name: '/edit_profile_screen'),
                            builder: (BuildContext context) {
                              return const EditProfileScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: ProfileMenu(
                      text: "Notifications",
                      icon: CupertinoIcons.bell,
                      press: () {},
                    ),
                  ),
                  Expanded(
                    child: ProfileMenu(
                      text: "Settings",
                      icon: CupertinoIcons.settings,
                      press: () {},
                    ),
                  ),
                  Expanded(
                    child: ProfileMenu(
                      text: "Help Center",
                      icon: CupertinoIcons.question,
                      press: () {},
                    ),
                  ),
                  Expanded(
                    child: ProfileMenu(
                      text: "Log Out",
                      icon: Icons.logout,
                      press: () async {
                        AuthService().signOut();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            settings:
                                const RouteSettings(name: '/splash_screen'),
                            builder: (BuildContext context) {
                              return SplashScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
