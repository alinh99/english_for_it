import 'package:flutter/material.dart';

BoxDecoration boxDecoration() {
  return BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        offset: const Offset(0, -15),
        blurRadius: 20,
        color: const Color(0xFFDADADA).withOpacity(0.15),
      ),
    ],
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(40),
      topRight: Radius.circular(40),
    ),
  );
}
