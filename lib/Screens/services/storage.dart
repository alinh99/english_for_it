import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_eft/Screens/models/users.dart';
import 'package:flutter_eft/Screens/services/database.dart';
import 'package:image_picker/image_picker.dart';

class Storage {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users _currentUser;
  FirebaseStorage storage =
      FirebaseStorage.instanceFor(bucket: 'gs://flutter-eft-final.appspot.com');
  Future<String> uploadFile(File file) async {
    var storageRef =
        storage.ref().child('user/profile/${_auth.currentUser.uid}');
    print("STR: $storageRef");
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    print("DU: $downloadUrl");
    return downloadUrl;
  }



  // Future uploadTempoFile(File filePath) async {
  //   //File file = File(filePath);

  //   try {
  //     await FirebaseStorage.instance
  //         .ref('user/profile/${_auth.currentUser.uid}')
  //         .putFile(filePath);

  //     //return uploadTask;
  //   } on FirebaseException catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<String> getUserProfileImageDownloadUrl(String uid) async {
    var storageRef = storage.ref().child('user/profile/$uid');
    return await storageRef.getDownloadURL();
  }
}
