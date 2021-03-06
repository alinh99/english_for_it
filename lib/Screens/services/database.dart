import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_eft/Screens/models/users.dart';
import 'package:flutter_eft/Screens/services/auth.dart';
import 'package:flutter_eft/Screens/services/storage.dart';
import 'package:image_picker/image_picker.dart';

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
  Future updateUserEmailPassword(email, password) async {
    return await userCollection.doc(uid).set({
      'email': email,
      'password': password,
    });
  }

  Future updateUserPassword(String password) async {
    return await userCollection.doc(uid).set({
      'password': password,
    });
  }

  Future updateUserFirstName(String firstNameEditingController) async {
    try {
      final userName = await userCollection.doc(uid).set({
        'first_name': firstNameEditingController,
      });
      return userName;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateUserLastName(String lastNameEditingController) async {
    try {
      final userName = await userCollection.doc(uid).set({
        'lastName': lastNameEditingController,
      });
      return userName;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateUserAge(
    int age,
  ) async {
    try {
      final userAge = await userCollection.doc(uid).set({
        'age': age.toString(),
      });
      return userAge;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateUserData(String firstName, String lastName, String password,
      int age, String image) async {
    return await userCollection.doc(uid).set({
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'age': age,
      'photo_url': image,
    });
  }

  Future update(
      String password, String firstName, String lastName, int age) async {
    return await userCollection.doc(uid).update({
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'age': age,
    });
  }

  Future updateUserImage(String image) async {
    //final url = await _storage.uploadFile(File(image));
    return await userCollection.doc(uid).set({
      'photo_url': image,
    });
  }

  Future<String> getDownloadURL() async {
    return await _storage.getUserProfileImageDownloadUrl(_currentUser.uid);
  }

  void updateProfilePicture(File image) async {
    _currentUser = Users(uid: _auth.currentUser.uid);
    _currentUser.photoUrl = await _storage.uploadFile(image);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    _currentUser =
        await _authService.signInWithEmailAndPassword(email, password);
    _currentUser.photoUrl = await getDownloadURL();
  }

  Users _userFromSnapshot(DocumentSnapshot snapshot) {
    var docData = snapshot.data() as Map<String, dynamic>;
    return Users(
        uid: uid,
        firstName: docData['first_name'],
        lastName: docData['last_name'],
        age: docData['age'],
        email: docData['email'],
        password: docData['password'],
        photoUrl: docData['photo_url']);
  }

  Stream<Users> get userData {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }
}
