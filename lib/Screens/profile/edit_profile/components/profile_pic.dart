import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_eft/Screens/services/storage.dart';

class ProfilePic extends StatefulWidget {
  ProfilePic({Key key, this.avatarUrl, this.isSaved, this.editingController})
      : super(key: key);
  String avatarUrl;
  bool isSaved;
  TextEditingController editingController;
  @override
  ProfilePicState createState() => ProfilePicState();
}

class ProfilePicState extends State<ProfilePic> {
  static File image;
  File imageSaved;
  XFile img;
  static String test;
  // final Storage _storage = Storage();
  final DatabaseService _databaseService = DatabaseService();
  bool isOldImage = true;

  final Storage _storage = Storage();
  //connect camera
  Future updateImageProfile() async {
    print('Picker is Called');
    img = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (img != null) {
      image = File(img.path);
      print('Image' + image.path);
    }
    setState(() {
      isOldImage = false;
    });
    //test = image.toString();
  }

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
                  //widget.isSaved == false
                  // widget.isSaved == true
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(widget.avatarUrl),
                    )
                  : widget.avatarUrl != null && isOldImage == false
                      //widget.isSaved == true
                      // widget.isSaved == false
                      ? CircleAvatar(
                          backgroundImage: Image.file(image).image,
                        )
                      : widget.isSaved == true && widget.avatarUrl != null
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
                  await updateImageProfile();
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
