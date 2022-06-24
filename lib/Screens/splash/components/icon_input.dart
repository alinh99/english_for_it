import 'package:flutter/material.dart';
import 'package:flutter_eft/constants.dart';

class IconInput extends StatefulWidget {
  final IconData icon;
  final String inputHintText;
  final TextEditingController editingController;
  final bool checkPassword;
  final dynamic formKey;
  final bool isEmail;
  final bool isName;
  final bool isAge;

  const IconInput(
      {Key key,
      this.icon,
      this.inputHintText,
      this.editingController,
      this.checkPassword,
      this.formKey,
      this.isEmail,
      this.isAge,
      this.isName})
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
        borderRadius: BorderRadius.circular(100.0),
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
            child: Column(
              children: [
                Form(
                  key: widget.formKey,
                  child: TextFormField(
                      //textAlign: TextAlign.center,
                      validator: (value) => widget.checkPassword == false &&
                              value.isEmpty &&
                              widget.isEmail == true
                          ? 'Enter an email'
                          : widget.checkPassword == true && value.length < 6
                              ? 'Enter Password 6+ chars long'
                              : widget.checkPassword == false &&
                                      value.isEmpty &&
                                      widget.isName == true
                                  ? 'Enter some character'
                                  : widget.checkPassword == false &&
                                          value.isEmpty &&
                                          widget.isAge == true
                                      ? 'Enter a number'
                                      : null,
                      onChanged: (text) {
                        text = widget.editingController.text.trim();
                      },
                      cursorColor: Colors.black,
                      controller: widget.editingController,
                      obscureText: widget.checkPassword ? true : false,
                      decoration: InputDecoration(
                        hintText: widget.inputHintText,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        border: InputBorder.none,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: widget.isEmail
                          ? TextInputType.emailAddress
                          : widget.isAge
                              ? TextInputType.number
                              : TextInputType.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
