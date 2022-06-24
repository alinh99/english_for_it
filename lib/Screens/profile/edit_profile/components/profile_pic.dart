import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({Key key, this.avatarUrl}) : super(key: key);
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          avatarUrl == null
              ? const CircleAvatar(
                  backgroundColor: Colors.grey,
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(avatarUrl),
                ),
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
                  final _imagePicker = ImagePicker();
                  PickedFile image;
                  image =
                      await _imagePicker.getImage(source: ImageSource.gallery);
                  print(image.path);
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
