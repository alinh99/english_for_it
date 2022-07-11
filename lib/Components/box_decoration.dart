import 'package:flutter/material.dart';
import 'package:flutter_eft/colors.dart';

BoxDecoration boxDecoration() {
  return BoxDecoration(
    color: AppColors.red,
    boxShadow: [
      BoxShadow(
        offset: const Offset(0, -15),
        blurRadius: 20,
        color: const Color(0xFFDADADA).withOpacity(0.15),
      ),
    ],
    // borderRadius: const BorderRadius.only(
    //   topLeft: Radius.circular(40),
    //   topRight: Radius.circular(40),
    // ),
  );
}
