import 'package:flutter/material.dart';
import 'package:flutter_eft/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatelessWidget {
  const Loading({
    Key key,
    @required AnimationController controller,
  }) : _controller = controller, super(key: key);

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCubeGrid(
        color: kBackgroundColor,
        size: 50.0,
        controller: _controller,
      ),
    );
  }
}
