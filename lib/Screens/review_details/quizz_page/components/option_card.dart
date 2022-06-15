import 'package:flutter/material.dart';
import 'package:flutter_eft/constants.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    Key key,
    @required this.option,
    @required this.colour,
  }) : super(key: key);
  final String option;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colour,
      child: ListTile(
        title: Text(
          option,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color:
                colour.red != colour.green ? kNeutralAnswerColor : Colors.black,
          ),
        ),
      ),
    );
  }
}
