import 'package:flutter/material.dart';
import 'package:flutter_eft/constants.dart';

class IconInput extends StatefulWidget {
  final IconData icon;
  final String inputHintText;
  final TextEditingController editingController;
  final bool checkPassword;
  const IconInput(
      {Key key,
      this.icon,
      this.inputHintText,
      this.editingController,
      this.checkPassword})
      : super(key: key);
  @override
  _IconInputState createState() => _IconInputState();
}

class _IconInputState extends State<IconInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: kBorderColor,
        ),
        borderRadius: BorderRadius.circular(50),
        color: kHintTextColor,
      ),
      child: Row(
        children: [
          SizedBox(
            child: Icon(
              widget.icon,
              size: 15,
            ),
            width: 60,
          ),
          Expanded(
            child: TextField(
              onChanged: (text) => print(text),
              controller: widget.editingController,
              obscureText: widget.checkPassword ? true : false,
              decoration: InputDecoration(
                hintText: widget.inputHintText,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
