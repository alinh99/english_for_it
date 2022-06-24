import 'package:flutter_eft/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/home/components/style.dart';

class LongCourseCard extends StatefulWidget {
  final Color background;
  final String title;
  final String subTitle;
  final String image;
  final Function press;
  const LongCourseCard(
      {Key key,
      this.background,
      this.title,
      this.subTitle,
      this.image,
      this.press})
      : super(key: key);
  @override
  _LongCourseCardState createState() => _LongCourseCardState();
}

class _LongCourseCardState extends State<LongCourseCard>
    with TickerProviderStateMixin {
  AnimationController _controller;
  bool _loadingInProgress = false;
  //Animation _animation;
  @override
  void initState() {
    super.initState();
    _loadingInProgress = true;
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    _controller.forward();

    _loadData();
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future _loadData() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    _dataLoaded();
  }

  void _dataLoaded() {
    setState(() {
      _loadingInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingInProgress == true) {
      return Center(
        child: SpinKitCubeGrid(
          color: kBackgroundColor,
          size: 50.0,
          controller: _controller,
        ),
      );
    } else {
      return Container(
        height: 155,
        width: 192,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: widget.background,
          border: Border.all(
            color: Colors.white,
            width: 10,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 50,
              color: const Color(
                0xFF0B0C2A,
              ).withOpacity(
                .09,
              ),
              offset: const Offset(10, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 12,
            ),
            Text(
              widget.title,
              style: AppStyle.m12w,
            ),
            Text(
              widget.subTitle,
              style: AppStyle.r10wt,
            ),
            IconButton(
              onPressed: widget.press,
              icon: Lottie.asset(
                widget.image,
                repeat: true,
                animate: true,
                controller: _controller,
                onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..forward();
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
