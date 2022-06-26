import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_eft/Screens/models/users.dart';
import 'package:flutter_eft/Screens/services/auth.dart';
import 'package:flutter_eft/Screens/services/storage.dart';

class DatabaseService {
  final String uid;
  Users _currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Storage _storage = Storage();
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


  Future<String> getDownloadURL() async {
    return await _storage.getUserProfileImageDownloadUrl(_currentUser.uid);
  }

  void updateProfilePicture(File image) async {
    _currentUser = Users(_auth.currentUser.uid);
    _currentUser.photoUrl = await _storage.uploadFile(image);
  }
}
