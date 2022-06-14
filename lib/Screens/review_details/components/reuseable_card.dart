import 'package:flutter/material.dart';

class ReuseableCard extends StatelessWidget {
  const ReuseableCard({Key key, @required this.colour, this.cardChild, this.onPress}) : super(key: key);

  final Color colour;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: colour,
        ),
        child: cardChild,
      ),
    );
  }
}
