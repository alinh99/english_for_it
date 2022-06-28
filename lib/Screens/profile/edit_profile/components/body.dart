import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/models/users.dart';
import 'package:flutter_eft/Screens/services/database.dart';
import 'package:flutter_eft/constants.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  const Body({Key key, @required this.size}) : super(key: key);
  final Size size;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _showPassword = true;
  bool loading = false;
  bool isHover = false;
  bool isPlaceHolder = false;
  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  String userFirstName;
  String userLastName;
  String userPassword;
  String userImage;
  int userAge;
  Users user = Users(FirebaseAuth.instance.currentUser.uid);
  final GlobalKey<FormState> _formKeyFirstName = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyLastName = GlobalKey<FormState>();

  //final GlobalKey<FormState> _formKeyEmail = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPassword = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyAge = GlobalKey<FormState>();
  //Users user;
  Future<void> _getUserData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc((FirebaseAuth.instance.currentUser).uid)
        .get()
        .then((value) {
      setState(() {
        userFirstName = value.data()['first_name'];
        userLastName = value.data()['last_name'];
        userPassword = value.data()['password'];
        userAge = value.data()['age'];
        userImage = value.data()['photo_url'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: widget.size.height - (widget.size.height / 5),
          width: widget.size.width,
          decoration: const BoxDecoration(
            color: kBackgroundColor,
          ),
          padding: const EdgeInsets.only(
            left: 24,
          ),
          child: SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                        alignment: Alignment.center,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Align(
                          child: Expanded(
                            child: ProfilePic(
                              avatarUrl: userImage,
                              onTap: () async{
                                
                              },
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              height: widget.size.height - (widget.size.height / 2.5),
              width: widget.size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(34),
                  topRight: Radius.circular(34),
                ),
              ),
              child: Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    Expanded(
                      child: buildTextField('First Name', userFirstName, false,
                          _formKeyFirstName),
                    ),
                    Expanded(
                      child: buildTextField(
                          'Last Name', userLastName, false, _formKeyLastName),
                    ),
                    Expanded(
                      child: buildTextField(
                          'Password',
                          userPassword.replaceAll(
                                  userPassword, '*' * userPassword.length) ??
                              '',
                          true,
                          _formKeyPassword),
                    ),
                    Expanded(
                      child: buildTextField(
                          'Age', userAge.toString(), false, _formKeyAge),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "CANCEL",
                                style: TextStyle(
                                  fontSize: 14,
                                  //letterSpacing: 0.3,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: RaisedButton(
                              onPressed: () async {
                                if (_formKeyPassword.currentState.validate()) {
                                  //print("second workded");
                                  await DatabaseService(
                                          uid: FirebaseAuth
                                              .instance.currentUser.uid)
                                      .storeUserPassword(userPassword);
                                } else if (_formKeyAge.currentState
                                    .validate()) {
                                  //print("third workded");
                                  await DatabaseService(
                                          uid: FirebaseAuth
                                              .instance.currentUser.uid)
                                      .storeUserDataAge(userAge);
                                }
                              },
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              color: kBackgroundColor,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "SAVE",
                                style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextField(String labelText, String placeHolder,
      bool isPasswordTextField, dynamic formKey) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: Form(
        key: formKey,
        child: TextFormField(
          onChanged: (value) {
            placeHolder = value;
          },
          cursorColor: Colors.black,
          obscureText: isPasswordTextField ? _showPassword : false,
          decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kBackgroundColor),
            ),
            iconColor: kBackgroundColor,
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: _showPassword == false
                        ? const Icon(
                            Icons.remove_red_eye,
                            color: kBackgroundColor,
                          )
                        : const Icon(Icons.remove_red_eye_outlined,
                            color: kBackgroundColor),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeHolder,
            labelStyle: const TextStyle(color: kBackgroundColor),
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
