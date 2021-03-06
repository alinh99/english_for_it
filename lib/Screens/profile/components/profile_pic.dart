import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
              : widget.avatarUrl != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(widget.avatarUrl),
                    )
                  : const SpinKitCubeGrid(
                      color: Color(0xFFF5F6F9),
                    ),
        ],
      ),
    );
  }
}
