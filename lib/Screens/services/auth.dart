import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_eft/Screens/models/users.dart';
import 'package:flutter_eft/Screens/services/database.dart';
import 'package:flutter_eft/Screens/services/storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users _currentUser;
  final Storage _storage = Storage();
  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  Stream<Users> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Users get currentUser => _currentUser;

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Users> signInWithEmailAndPassword(
      String email, String password) async {
    // try {
    //   UserCredential result = await _auth.signInWithEmailAndPassword(
    //       email: email, password: password);
    //   User user = result.user;
    //   return _userFromFirebaseUser(user);
    // } catch (e) {
    //   print(e.toString());
    //   return null;
    // }
    var authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return Users(uid: authResult.user.uid);
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid)
          .storeUserEmailPassword(email, password);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
