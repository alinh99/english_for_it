import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  PlatformFile pickedFile;
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
}
