import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfilePic extends StatefulWidget {
  ProfilePic({Key key, this.avatarUrl, this.onTap, this.isOldImage})
      : super(key: key);
  String avatarUrl;
  Function onTap;
  bool isOldImage;
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File image;
  //connect camera
  Future previewImageProfile() async {
    print('Picker is Called');
    XFile img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);
      setState(() {
        isOldImage = false;
      });
    }
  }

  bool isOldImage = true;

  //final Storage _storage = Storage();
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
              : widget.avatarUrl != null && isOldImage == true
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(widget.avatarUrl),
                    )
                  : widget.avatarUrl != null && isOldImage == false
                      ? CircleAvatar(
                          backgroundImage: Image.file(image).image,
                        )
                      : const SpinKitCubeGrid(color: Color(0xFFF5F6F9)),
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
                  await previewImageProfile();
                },
                // onPressed: widget.onTap,
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
