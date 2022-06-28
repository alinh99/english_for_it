import 'package:flutter/material.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key key, this.avatarUrl, this.onTap}) : super(key: key);
  final String avatarUrl;
  final Function onTap;
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          widget.avatarUrl == null
              ? const CircleAvatar(
                  backgroundColor: Colors.grey,
                )
              : CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(widget.avatarUrl),
                ),
        ],
      ),
    );
  }
}
