import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({Key key, this.avatarUrl, this.onTap}) : super(key: key);
  final String avatarUrl;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          avatarUrl == null
              ? const CircleAvatar(
                  backgroundColor: Colors.grey,
                )
              : CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
        ],
      ),
    );
  }
}
