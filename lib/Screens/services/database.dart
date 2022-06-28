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
  final AuthService _authService = AuthService();
  final Storage _storage = Storage();
  DatabaseService({this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // add user data
  Future storeUserEmailPassword(email, password) async {
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

  Future storeUserPassword(password) async {
    return await userCollection.doc(uid).set({
      'password': password,
    });
  }

  Future updateUserData(
      String password, String firstName, String lastName, int age) async {
    return await userCollection.doc(uid).set({
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'age': age,
    });
  }

  Future updateUserImage(File image) async {
    final url = await _storage.uploadFile(image);
    return await userCollection.doc(uid).set({
      'photo_url': url,
    });
  }

  Future<String> getDownloadURL() async {
    return await _storage.getUserProfileImageDownloadUrl(_currentUser.uid);
  }

  void updateProfilePicture(File image) async {
    _currentUser = Users(_auth.currentUser.uid);
    _currentUser.photoUrl = await _storage.uploadFile(image);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    _currentUser =
        await _authService.signInWithEmailAndPassword(email, password);
    _currentUser.photoUrl = await getDownloadURL();
  }
}
