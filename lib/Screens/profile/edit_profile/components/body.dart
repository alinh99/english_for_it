import 'package:flutter/material.dart';
import 'package:flutter_eft/constants.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool showPassword = false;
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
                        const Align(
                          child: Expanded(
                            child: ProfilePic(),
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
                      child: buildTextField("Full Name", "NHL", false),
                    ),
                    Expanded(
                      child:
                          buildTextField("Email", "alinh1803@gmail.com", false),
                    ),
                    Expanded(
                      child: buildTextField("Password", "******", true),
                    ),
                    Expanded(
                      child:
                          buildTextField("Phone Number", "0912345678", false),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: OutlineButton(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "CANCEL",
                                style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: RaisedButton(
                              onPressed: () {},
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

  Widget buildTextField(
      String labelText, String placeHolder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            hoverColor: kBackgroundColor,
            iconColor: kBackgroundColor,
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: showPassword == false
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
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )),
      ),
    );
  }
}
