import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/models/users.dart';
import 'package:flutter_eft/Screens/services/database.dart';
import 'package:flutter_eft/Screens/services/storage.dart';
import 'package:flutter_eft/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
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
  // bool _isLoading  = false;
  @override
  void initState() {
    //_getUserData();
    super.initState();
  }

  File imagePath;
  String url;
  String userFirstName;
  String userLastName;
  String userPassword;
  File image;
  String userImage;
  Users users = Users();
  final Storage _storage = Storage();
  final _formKey = GlobalKey<FormState>();
  AnimationController controller;
  int userAge;
  // bool isOldImage = false;

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _photoUrl = TextEditingController();
  bool isSaved;
  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _password.dispose();
    _age.dispose();
    _photoUrl.dispose();
    super.dispose();
  }

  Future previewImageProfile() async {
    print('Picker is Called');
    XFile img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);
      setState(() {
        isSaved = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        alignment: Alignment.center,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          child: Expanded(
                            child: StreamBuilder(
                                stream: DatabaseService(uid: user.uid).userData,
                                builder: (context, snapshot) {
                                  Users userData = snapshot.data;
                                  if (snapshot.hasData) {
                                    return ProfilePic(
                                      avatarUrl: userData.photoUrl,
                                      // isOldImage: isSaved == true,
                                      // onTap: () async {
                                      //   // if (isSaved == false) {
                                      //   await previewImageProfile();
                                      //   // } else {}
                                      // },
                                    );
                                  } else if (snapshot.hasError) {
                                    print('${snapshot.error}');
                                    return Text('${snapshot.error}');
                                  } else {
                                    return Text("Loading...");
                                  }
                                }),
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: StreamBuilder<Users>(
                          stream: DatabaseService(uid: user.uid).userData,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Users userData = snapshot.data;
                              return Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: textEditProfileForm(
                                          'First Name',
                                          false,
                                          userData.firstName,
                                          _firstName),
                                    ),
                                    Expanded(
                                      child: textEditProfileForm('Last Name',
                                          false, userData.lastName, _lastName),
                                    ),
                                    Expanded(
                                      child: textEditProfileForm(
                                          'Password',
                                          true,
                                          '*' * userData.password.length,
                                          _password),
                                    ),
                                    Expanded(
                                      child: textEditProfileForm('Age', false,
                                          userData.age.toString(), _age),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                primary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 50),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "CANCEL",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: RaisedButton(
                                              onPressed: () async {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  await DatabaseService(
                                                          uid: user.uid)
                                                      .updateUserData(
                                                    _password.text ??
                                                        userData.password,
                                                    _firstName.text ??
                                                        userData.firstName,
                                                    _lastName.text ??
                                                        userData.lastName,
                                                    int.parse(_age.text) ??
                                                        userData.age,
                                                  );
                                                }
                                                Navigator.pop(context);
                                              },
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50),
                                              color: kBackgroundColor,
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Text(
                                                "SAVE",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (snapshot.hasError) {
                              print('${snapshot.error}');
                              return Text('${snapshot.error}');
                            } else {
                              return Text("Loading...");
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextFormField textEditProfileForm(String labelText, bool isPasswordTextField,
      String val, TextEditingController editingController) {
    return TextFormField(
      onChanged: (value) {
        if (value == null) {
          val = value;
        } else {
          value = editingController.text.trim();
        }
      },
      controller: editingController,
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
        hintText: val,
        labelStyle: const TextStyle(color: kBackgroundColor),
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
