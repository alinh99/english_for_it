import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String lastName;
  final String firstName;
  final int age;
  final String password;
  final String email;
  final String uid;
  final String photoUrl;

  Users(
      {this.lastName,
      this.firstName,
      this.age,
      this.password,
      this.email,
      this.uid,
      this.photoUrl});

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'age': age,
        'password': password,
        'email': email,
        'uid': uid
      };

  factory Users.fromDocument(DocumentSnapshot docx) {
    return Users(
        email:
            docx.data().toString().contains('email') ? docx.get('email') : '',
        firstName: docx.data().toString().contains('first_name')
            ? docx.get('first_name')
            : '',
        password: docx.data().toString().contains('password')
            ? docx.get('password')
            : '',
        lastName: docx.data().toString().contains('last_name')
            ? docx.get('last_name')
            : '',
        uid: docx.data().toString().contains('uid') ? docx.get('uid') : '',
        age: docx.data().toString().contains('age') ? docx.get('age') : '');
  }

  updateProfile(userUpdateInfo) {}

  reload() {}
}
