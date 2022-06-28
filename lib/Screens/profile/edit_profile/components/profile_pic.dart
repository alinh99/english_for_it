import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/services/storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  ProfilePic({Key key, this.avatarUrl}) : super(key: key);
  String avatarUrl;
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final Storage _storage = Storage();
  // String avatarUrl = widget.avatarUrl;
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
              : widget.avatarUrl.isNotEmpty
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(widget.avatarUrl),
                    )
                  : null,
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () async {
                  XFile image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  String url = await _storage.uploadFile(File(image.path));
                  setState(() {
                    widget.avatarUrl = url;
                  });
                },
                child: const Icon(
                  CupertinoIcons.camera,
                  color: Color(0xFF333333),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
