import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key key,
    @required this.title,
    @required this.index,
  }) : super(key: key);
  final String title;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Text(
      "${index + 1}. $title",
      style: const TextStyle(
        fontSize: 20,
        height: 1.5,
        color: Colors.black,
      ),
    );
  }
}
