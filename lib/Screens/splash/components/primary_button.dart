import 'package:flutter/material.dart';
import 'package:flutter_eft/colors.dart';
import 'package:flutter_eft/constants.dart';

class PrimaryButton extends StatefulWidget {
  final String btnText;
  final Color colorTextStyle;
  final Color backgroundColor;
  const PrimaryButton(
      {Key key, this.btnText, this.backgroundColor, this.colorTextStyle})
      : super(key: key);
  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.red,
          width: 2,
        ),
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(
            color: widget.colorTextStyle,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
