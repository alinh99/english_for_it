import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../constants.dart';

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
