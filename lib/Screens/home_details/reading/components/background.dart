import 'package:flutter/material.dart';
import 'package:flutter_eft/colors.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      //fit: StackFit.expand,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: size.height - (size.height / 4),
            width: size.width,
            decoration: const BoxDecoration(
              color: AppColors.red,
            ),
          ),
        ),
        child
      ],
    );
  }
}
