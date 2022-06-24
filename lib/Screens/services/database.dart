import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  // add user data
  Future updateUserEmailPassword(email, password) async {
    return await userCollection.doc(uid).set({
      'email': email,
      'password': password,
    });
  }

  Future storeUserDataName(
      firstNameEditingController, lastNameEditingController) async {
    try {
      final userName = await userCollection.doc(uid).set({
        'first_name': firstNameEditingController,
        'last_name': lastNameEditingController,
      });
      return userName;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future storeUserDataAge(
    ageEditingController,
  ) async {
    try {
      final userAge = await userCollection.doc(uid).set({
        'age': ageEditingController,
      });
      return userAge;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future storeUserDataPhotoUrl(
    String photoUrl,
  ) async {
    try {
      final userPhotoUrl = await userCollection.doc(uid).set({
        'photo_url': uploadImage(),
      });
      return userPhotoUrl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _imagePicker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        for (var i = 0; i < 1000000000; i++) {
          var snapshot = await _firebaseStorage
              .ref()
              .child('images/imageName$i')
              .putFile(file);
          return await snapshot.ref.getDownloadURL();
          // setState(() {
          //   imageUrl = downloadUrl;
          // });
        }
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }
}
